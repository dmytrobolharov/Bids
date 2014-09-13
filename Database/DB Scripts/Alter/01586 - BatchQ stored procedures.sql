IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorwayHeader_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayHeader_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayHeader_SELECT](
	@StyleID UNIQUEIDENTIFIER 
)

AS

SELECT a.StyleHeaderSchema 
FROM pStyleType a
	INNER JOIN	dbo.pStyleHeader b ON a.StyleTypeID = b.StyleType 
WHERE b.StyleID = @StyleID


GO 


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorways_Review_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_UPDATE](
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@MaterialColorID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@StyleMaterialID UNIQUEIDENTIFIER
)
AS 


	UPDATE pBatchQueueStyleMaterialColorTmp
	SET MaterialColorID = @MaterialColorID 
	WHERE BatchQueueJobID = @BatchQueueJobID
		AND StyleMaterialID  = @StyleMaterialID 
		AND ColorPaletteID = @ColorPaletteID

	--UPDATE  pBatchQueueStyleMaterialColorTmp 
	--SET Reviewed = 1 
	--FROM pBatchQueueStyleMaterialColorTmp a
	--	INNER JOIN pStyleMaterials b ON a.StyleMaterialID =  b.StyleMaterialID
	--	INNER JOIN dbo.pStyleMaterials c ON b.StyleID = c.StyleID 
	--WHERE c.StyleMaterialID = @StyleMaterialID
	--	AND c.StyleSet = '1'
		

go

		
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorways_Review_Logic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_Logic_UPDATE]
GO

		
CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_Logic_UPDATE](
	@BatchQueueJobID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER
)
AS 


	UPDATE  pBatchQueueStyleMaterialColorTmp 
	SET Reviewed = 1 
	FROM pBatchQueueStyleMaterialColorTmp a
		INNER JOIN pStyleMaterials b ON a.StyleMaterialID =  b.StyleMaterialID
	WHERE b.StyleID = @StyleID 
		AND  a.BatchQueueJobID = @BatchQueueJobID
		



go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorways_Review_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_SELECT]
GO

		
CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorways_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER
)
AS 



DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER
	
	
CREATE TABLE #bqsc_color(
	ROWID INT IDENTITY(1,1),
	ColorPaletteID UNIQUEIDENTIFIER,
	ColorCode NVARCHAR(200),
	ColorName NVARCHAR(200)
)	



	
--** Get SeasonYearID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT
	
	
--** Get Colors 
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 3
	

SET @sySQL = 'INSERT INTO #bqsc_color ( ColorPaletteID, ColorCode, ColorName )
	SELECT a.ColorPaletteID, b.ColorCode, b.ColorName FROM ' + @syBatchQueueJobTable  + ' a 
		INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
	WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
EXECUTE	sp_executesql @sySQL


INSERT INTO  pBatchQueueStyleMaterialColorTmp  (StyleMaterialColorID, BatchQueueJobID, 
	ColorCode, ColorName, StyleMaterialID , ColorPaletteID )
SELECT NEWID() AS StyleMaterialColorID, @BatchQueueJobID, 
	a.ColorCode, a.ColorName, b.StyleMaterialID , a.ColorPaletteID 
FROM #bqsc_color a
	CROSS JOIN dbo.pStyleMaterials b
	LEFT OUTER JOIN pBatchQueueStyleMaterialColorTmp c ON  c.StyleMaterialID = b.StyleMaterialID 
		AND c.ColorPaletteID = a.ColorPaletteID
		AND c.BatchQueueJobID = @BatchQueueJobId
WHERE StyleID = @StyleID
AND c.StyleMaterialColorID IS NULL
AND b.Colorway = 1
AND b.StyleSet = '1'


--** Default color pitching 
UPDATE dbo.pBatchQueueStyleMaterialColorTmp
	SET MaterialColorID = e.MaterialColorID
FROM pBatchQueueStyleMaterialColorTmp a
	INNER JOIN dbo.pStyleMaterials  b ON a.StyleMaterialID = b.StyleMaterialID 
	INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
	INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
			AND e.MaterialID = b.MaterialID
	INNER JOIN dbo.pMaterialColorSeasonYear d ON d.MaterialColorID = e.MaterialColorID
			AND d.SeasonyearID = @SeasonyearID 
WHERE BatchQueueJobID = @BatchQueueJobID
AND b.StyleID = @StyleID
AND b.StyleSet = '1'
AND ISNULL(a.Reviewed,0) = 0 


DROP TABLE #bqsc_color
	
SELECT a.StyleMaterialID, a.ColorPaletteID, @SeasonYearID AS SeasonYearID, b.MaterialID,
ISNULL(CAST(a.MaterialColorID AS NVARCHAR(40)),'') AS MaterialColorID,
e.MaterialName, e.MaterialNo, e.MaterialCode,
'<img src="../System/Control/ImageStream.ashx?S=50&V='  +  ISNULL(CAST(b.MaterialImageVersion  AS NVARCHAR(5)),'0')+  
'&IID=' + ISNULL(CAST(b.MaterialImageID AS NVARCHAR(40)),'00000000-0000-0000-0000-000000000000') + '" />' AS ImagePath,
c.ComponentOrder, b.MainMaterial, d.Custom AS BBUsage
INTO #tmp2
FROM dbo.pBatchQueueStyleMaterialColorTmp a
	INNER JOIN dbo.pStyleMaterials b ON a.StyleMaterialID = b.StyleMaterialID 
	INNER JOIN pMaterial e ON e.MaterialID  = b.MaterialID
	INNER JOIN dbo.pComponentType c ON c.ComponentTypeID =  e.MaterialType
	LEFT OUTER JOIN xcustom103 d ON d.CustomKey = b.BBUsage
WHERE BatchQueueJobID = @BatchQueueJobId
	AND b.StyleID = @StyleID
	AND b.StyleSet = '1'



DECLARE @tableName NVARCHAR(50)
SET @tableName = '##' + REPLACE(CAST ( NEWID()AS NVARCHAR (50)), '-', '')

EXECUTE spx_Crosstab 
@DBFetch = 'SELECT * FROM #tmp2',
@DBWhere = NULL,
@DBPivot = NULL,
@DBField = 'ColorPaletteID',
@PCField = 'MaterialColorID',
@PCBuild = 'MAX',
@PCAdmin = NULL,
@DBAdmin = 0,
@DBTable = @tableName ,
@DBWrite = NULL,
@DBUltra = 0

DROP TABLE #tmp2

SET @sySQL = 'SELECT * FROM '  + @tableName + ' ORDER BY MainMaterial DESC, ComponentOrder ; DROP TABLE ' + @tableName 
EXEC sp_executesql @sySQL


go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_StyleColor_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQ_StyleColor_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQ_StyleColor_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX)


--** Get Colors 
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 3
	


SET @sySQL = 'SELECT a.ColorPaletteID, b.ColorCode, b.ColorName as ColorHeader
	FROM ' + @syBatchQueueJobTable  + ' a 
	INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
	WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
EXECUTE	sp_executesql @sySQL

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleColorwayTree_SELECT] (
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER = NULL
)
AS 


DECLARE 
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX)


--** Get StyleTable
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
AND BatchQueueJobSeq = 4

CREATE TABLE #bq001_st(
	ROWID INT IDENTITY(1,1),
	StyleID  UNIQUEIDENTIFIER, 
	StyleNo  NVARCHAR(200),
	ImagePath NVARCHAR(200),
	BatchQueueIcon NVARCHAR(200)  
)


SET @sySQL = 'INSERT INTO #bq001_st(StyleID, StyleNo, ImagePath) 
SELECT b.StyleID , b.StyleNo  
, ''<img src="../System/Control/ImageStream.ashx?S=050&V='''''' + 
	CAST(b.DesignSketchVersion AS NVARCHAR(5)) + ''''''&IID='''''' + 
	CAST(b.DesignSketchID AS NVARCHAR(40)) + ''''''" \>'' as  ImagePath
FROM ' + @syBatchQueueJobTable + ' a 
	INNER JOIN dbo.pStyleHeader  b ON a.StyleID	 =  b.StyleID '
	
EXEC sp_executesql @sySQL	


DECLARE 
	@ROWID INT,
	@TOTAL INT,
	@tmpStyleID UNIQUEIDENTIFIER

SELECT @TOTAL  =  COUNT(*) FROM #bq001_st
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN 
	SELECT @tmpStyleID = StyleID FROM #bq001_st WHERE ROWID = @ROWID 

	IF NOT EXISTS ( SELECT * FROM dbo.pBatchQueueStyleMaterialColorTmp a INNER JOIN dbo.pStyleMaterials b ON a.StyleMaterialID = b.StyleMaterialID
		WHERE BatchQueueJobID = @BatchQueueJobID AND StyleID = @tmpStyleID
	)
	BEGIN
		IF @tmpStyleID = @StyleID 
			UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_blue.gif'  WHERE ROWID = @ROWID
		ELSE 
			UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_gray.gif'  WHERE ROWID = @ROWID
	END
	ELSE IF EXISTS ( SELECT * FROM dbo.pBatchQueueStyleMaterialColorTmp a INNER JOIN dbo.pStyleMaterials b ON a.StyleMaterialID = b.StyleMaterialID
			WHERE BatchQueueJobID = @BatchQueueJobID  AND a.Reviewed = 1   AND StyleID = @tmpStyleID
	)
		UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_green.gif'  WHERE ROWID = @ROWID
	ELSE 
		UPDATE #bq001_st SET BatchQueueIcon = 'icon_ball_blue.gif'  WHERE ROWID = @ROWID

	SET @ROWID = @ROWID  + 1 
END 
	

SELECT c.Description + ' (' + c.StyleNo  + ') ' AS StyleDescription, c.StyleNo AS StyleTooltip, 
	c.StyleID, a.BatchQueueIcon
FROM #bq001_st a
	INNER JOIN dbo.pStyleHeader c ON c.StyleID  = a.StyleID 




DROP TABLE #bq001_st 

GO
	
		
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobDep_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQJobDep_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQJobDep_SELECT](
@BatchQueuePageID UNIQUEIDENTIFIER,
@BatchQueueJobID UNIQUEIDENTIFIER
)
AS 

SELECT pBatchQueuePageDep.BatchQueuePageDepID, pBatchQueuePageDep.BatchQueuePageID, pBatchQueuePageDep.BatchQueuePageRelationID, 
  pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, pBatchQueueJobItem.BatchQueueJobTable, 
  pBatchQueuePageType.BatchQueuePagePkID
FROM pBatchQueuePageDep INNER JOIN
  pBatchQueueJobItem ON pBatchQueuePageDep.BatchQueuePageRelationID = pBatchQueueJobItem.BatchQueuePageID INNER JOIN
  pBatchQueuePage ON pBatchQueueJobItem.BatchQueuePageID = pBatchQueuePage.BatchQueuePageID INNER JOIN
  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
WHERE (pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID) AND 
  (pBatchQueuePageDep.BatchQueuePageID = @BatchQueuePageID)


GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQPageNav_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQPageNav_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQPageNav_SELECT](
@BatchQueueID UNIQUEIDENTIFIER = NULL
)
AS 

SELECT '00000000-0000-0000-0000-000000000000' AS BatchQueuePageID,
	'00000000-0000-0000-0000-000000000000' AS BatchQueuePageTypeID,
	BatchQueueID,
	BatchQueueName AS BatchQueuePageTypeName,
	BatchQueueDesc AS BatchQueuePageTypeDesc,
	'BatchQ_Page.aspx' AS BatchQueuePageUrl,
	'' AS BatchQueuePageOrder
FROM pBatchQueue WHERE BatchQueueID = @BatchQueueID
UNION
SELECT pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID,  
      pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, pBatchQueuePageType.BatchQueuePageUrl,
      pBatchQueuePage.BatchQueuePageOrder
FROM pBatchQueuePage INNER JOIN
      pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
WHERE pBatchQueuePage.BatchQueueID = @BatchQueueID
ORDER BY BatchQueuePageOrder
		
GO		
		
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobStatus_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQJobStatus_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQJobStatus_SELECT](
	@TeamID UNIQUEIDENTIFIER 
)
AS 

SELECT BatchQueueJobStatusID, BatchQueueJobStatus, BatchQueueJobStatusIcon
FROM   pBatchQueueJobStatus WITH(NOLOCK)



GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQUserJobs_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQUserJobs_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQUserJobs_SELECT] (
	@TeamID UNIQUEIDENTIFIER
)
AS


SELECT DISTINCT foo.* FROM ( 
	SELECT 
		a.Description, a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
		a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted,
		 
		b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
		b.BatchQueueIcon, b.BatchQueuePageHistoryUrl,
		
		c.BatchQueuePageID, c.BatchQueuePageTypeID, c.BatchQueuePageOrder, 
		d.BatchQueuePageUrl, e.Status
		
	FROM dbo.pBatchQueueJob a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON a.BatchQueueID = b.BatchQueueID 
		INNER JOIN dbo.pBatchQueuePage c WITH(NOLOCK) ON b.BatchQueueID = c.BatchQueueID 
		INNER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON c.BatchQueuePageTypeID = d.BatchQueuePageTypeID
		LEFT OUTER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID
	WHERE     c.BatchQueuePageOrder = '0000'
		AND a.BatchQueueJobTeamID = @TeamID
		AND e.BatchQueueJobStatusID <> '20000000-0000-0000-0000-000000000000'

UNION


	SELECT 	
		a.Description, a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
		a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted,

		b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
		b.BatchQueueIcon, b.BatchQueuePageHistoryUrl,
		
		c.BatchQueuePageID, c.BatchQueuePageTypeID, c.BatchQueuePageOrder,
		d.BatchQueuePageUrl, e.Status
	FROM pBatchQueueJob a 
		INNER JOIN dbo.pBatchQueuePage c ON a.BatchQueueID = c.BatchQueueID
		INNER JOIN ( 
				SELECT BatchQueueID, MAX(BatchQueuePageOrder) AS BatchQueuePageOrder
				FROM dbo.pBatchQueuePage 
				GROUP BY BatchQueueID) AS foo ON foo.BatchQueueID = c.BatchQueueID
					AND foo.BatchQueuePageOrder = c.BatchQueuePageOrder
		INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON b.BatchQueueID = a.BatchQueueID 
		LEFT OUTER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON d.BatchQueuePageTypeID = c.BatchQueuePageTypeID
		INNER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID	
	WHERE a.BatchQueueJobTeamID = @TeamID
		AND a.BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
) AS foo 
	INNER JOIN  sAccessBatchQFolderItems a ON a.BatchQueueID =  foo.BatchQueueID 
WHERE a.AccessRoleId = 3 
ORDER BY foo.BatchQueueJobDate DESC

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQ_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQ_SELECT](
	@TeamID UNIQUEIDENTIFIER = NULL
)
AS 



SELECT DISTINCT b.*
FROM sAccessBatchQFolderItems a WITH(NOLOCK)
	INNER JOIN pBatchQueue b WITH(NOLOCK) ON a.BatchQueueID =  b.BatchQueueID 
WHERE TeamID = @TeamID
	AND a.AccessRoleId = 3 


GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQType_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQType_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQType_SELECT](
	@TeamID UNIQUEIDENTIFIER = NULL
)
AS 



	SELECT DISTINCT a.* 
	FROM pBatchQueueType a WITH(NOLOCK)
		INNER JOIN sAccessBatchQFolderItems b WITH(NOLOCK) ON a.BatchQueueTypeID = b.BatchQTypeID
	WHERE b.TeamID = @TeamID
	 AND b.AccessRoleId = 3




GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialGroupColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER,
	@MaterialCoreID UNIQUEIDENTIFIER
	
	
--** Get SeasonYearID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT



--** Get MaterialCoreID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialCoreID = MaterialCoreID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialCoreID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialCoreID = @MaterialCoreID OUTPUT


IF @SeasonYearID IS NOT NULL  AND @MaterialCoreID IS NOT NULL
BEGIN 

	--** Get Styles 
	CREATE TABLE  #style(
		StyleID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 4

	SET @sySQL = 'INSERT INTO #style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL


	CREATE TABLE #color (
		ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
		ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
	)
	
	--** Get all styleColors
	
	INSERT INTO #color (ColorCode, ColorName)
	SELECT DISTINCT d.ColorCode, d.ColorName
	FROM #style a
		INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleID = b.StyleID 
		INNER JOIN dbo.pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
		INNER JOIN dbo.pStyleColorway e ON e.StyleColorID =  b.StyleColorwayID
		INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = e.ColorPaletteID
	WHERE c.SeasonYearID = @SeasonYearID
		AND LEN(ISNULL(d.ColorCode,'') ) > 0 
		AND LEN(ISNULL(d.ColorName,'')) > 0


	DROP TABLE  #style


	--** Remove colors
	DELETE FROM pBatchQueueStyleMaterialCoreColorTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND ColorCode + '//' + ColorName NOT IN  ( 
		SELECT ColorCode + '//' + ColorName FROM #color
	)

	--** Add colors
	INSERT INTO  pBatchQueueStyleMaterialCoreColorTmp
	( StyleMaterialCoreColorID , BatchQueueJobId, ColorCode, ColorName) 
	SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
	FROM #color
	WHERE ColorCode  + '//' + ColorName NOT IN (
		SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialCoreColorTmp WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
	) 	

	DROP TABLE #color
	
	--** Default selection of colors
	UPDATE pBatchQueueStyleMaterialCoreColorTmp 
	SET MaterialCoreColorID = e.MaterialCoreColorID
	FROM pBatchQueueStyleMaterialCoreColorTmp a
		INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
		INNER JOIN pMaterialCoreColor e ON e.ColorPaletteID =  c.ColorPaletteID 
			AND e.MaterialCoreID = @MaterialCoreID
	WHERE a.BatchQueueJobId = @BatchQueueJobId
		AND  a.MaterialCoreColorID IS null
			
	
			
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialCoreID AS MaterialCoreID
	FROM pBatchQueueStyleMaterialCoreColorTmp a WITH(NOLOCK)
	WHERE a.BatchQueueJobID = @BatchQueueJobID


END
ELSE 
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialCoreID AS MaterialCoreID
	FROM pBatchQueueStyleMaterialCoreColorTmp a WITH(NOLOCK)
	WHERE 1 = 2 



GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQJob_DELETE]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQJob_DELETE](
	 @BatchQueueJobID uniqueidentifier
)
AS 

BEGIN
	DECLARE
		@BatchQueueJobTable varchar(200),
		@BatchQueueJobItemID uniqueidentifier
	
	DECLARE @BatchQueueIndex INT, @BatchQueueRowCount INT

	SET @BatchQueueIndex = 1

	SET NOCOUNT ON

	BEGIN	

		SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex, BatchQueueJobTable 		  
		INTO #BatchQueueJob      
		FROM pBatchQueueJobItem 
		WHERE BatchQueueJobID = @BatchQueueJobID 
		ORDER BY BatchQueueJobSeq ASC    
		
		SET @BatchQueueRowCount = (SELECT COUNT(*) FROM #BatchQueueJob)

			WHILE @BatchQueueIndex <= @BatchQueueRowCount 
				BEGIN
											
					SELECT @BatchQueueJobTable = BatchQueueJobTable
						FROM #BatchQueueJob WHERE BatchQueueIndex = @BatchQueueIndex							
						
							EXEC('IF OBJECT_ID(''dbo.' + @BatchQueueJobTable + ''') IS NOT NULL   
							BEGIN DROP TABLE ' + @BatchQueueJobTable + ' END')  				  
					
							
					
					SET @BatchQueueIndex = @BatchQueueIndex + 1
				END
		
		DROP TABLE #BatchQueueJob 
		
		BEGIN
			DELETE FROM pBatchQueueJobItem WHERE BatchQueueJobID = @BatchQueueJobID 
			DELETE FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID 
		END
		
	SET NOCOUNT OFF
	END
END	
	

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQStartPageUrl_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQStartPageUrl_SELECT]
GO

	
CREATE PROCEDURE [dbo].[spx_BatchQStartPageUrl_SELECT](
@BatchQueueID UNIQUEIDENTIFIER 
)
AS 

SELECT TOP 1 pBatchQueuePageType.BatchQueuePageUrl, pBatchQueuePage.BatchQueueID
FROM pBatchQueuePage INNER JOIN
      pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
WHERE pBatchQueuePage.BatchQueueID = @BatchQueueID
ORDER BY pBatchQueuePage.BatchQueuePageOrder ASC





GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobNew_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQJobNew_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJobNew_INSERT]
(
	 @BatchQueueJobID uniqueidentifier
	,@BatchQueueID uniqueidentifier
	,@BatchQueueJobDate datetime
	,@BatchQueueJobTeamID uniqueidentifier

)
AS 

BEGIN
	INSERT INTO pBatchQueueJob
			(BatchQueueJobID 
			,BatchQueueID 
			,BatchQueueJobDate 
			,BatchQueueJobTeamID)
     VALUES
			(@BatchQueueJobID 
			,@BatchQueueID 
			,@BatchQueueJobDate 
			,@BatchQueueJobTeamID)
END

BEGIN
	DECLARE
		@BatchQueueJobStatusID uniqueidentifier,
		@BatchQueueJobCompleted int,
		@BatchQueuePagePkiName varchar(200),
		@BatchQueuePageID uniqueidentifier,
		@BatchQueueTransId uniqueidentifier,
		@CUser NVarChar(200),
		@CDate datetime

	
--SELECT * FROM #BatchQueueJob	
--	DROP TABLE #BatchQueueJob	
	
DECLARE @BatchQueueIndex INT, @BatchQueueRowCount INT

SET @BatchQueueIndex = 1

	SET NOCOUNT ON

	BEGIN

		SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex,
			  pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID, 
			  pBatchQueuePage.BatchQueuePageOrder, NULL AS BatchQueueJobSeq,
			  pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, pBatchQueuePageType.BatchQueuePagePkID, 
			  pBatchQueuePageType.BatchQueuePageXmlSearch, pBatchQueuePageType.BatchQueuePageXmlForm, pBatchQueuePageType.BatchQueuePageXmlGrid, 
			  pBatchQueuePageType.BatchQueuePageUrl
		INTO #BatchQueueJob      
		FROM pBatchQueuePage INNER JOIN
			  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
		WHERE pBatchQueuePage.BatchQueueID = @BatchQueueID 
		ORDER BY pBatchQueuePage.BatchQueuePageOrder ASC    
		
		SET @BatchQueueRowCount = (SELECT COUNT(*) FROM #BatchQueueJob)

			WHILE @BatchQueueIndex <= @BatchQueueRowCount 
				BEGIN
											
					SELECT @BatchQueuePageID = BatchQueuePageID, @BatchQueuePagePkiName = BatchQueuePagePkID 
						FROM #BatchQueueJob WHERE BatchQueueIndex = @BatchQueueIndex	
						
					DECLARE @TempTableName varchar(200)						
						--Create temp table name
						SELECT @TempTableName = '__' + 
							REPLACE(CAST(@BatchQueueJobID AS VARCHAR(40)),'-','') + '_' + 
							REPLACE(CAST(@BatchQueuePageId AS VARCHAR(40)),'-','')						
			
					INSERT INTO pBatchQueueJobItem(BatchQueueJobID, BatchQueuePageID, BatchQueueJobSeq, BatchQueueJobTable)
						VALUES(@BatchQueueJobID, @BatchQueuePageID, @BatchQueueIndex, @TempTableName) 

						
						EXEC('IF OBJECT_ID(''dbo.' + @TempTableName + ''') IS NULL   
						BEGIN CREATE TABLE ' + @TempTableName + '
						 (
						 TempId [int] IDENTITY(1,1) NOT NULL,' +
						 @BatchQueuePagePkiName + ' UNIQUEIDENTIFIER NOT NULL,' +
						 @BatchQueuePagePkiName + '_TMP UNIQUEIDENTIFIER NULL,
						 BatchQueueJobId UNIQUEIDENTIFIER NULL,
						 BatchQueueJobItemId UNIQUEIDENTIFIER NULL,
						 BatchQueuePageId UNIQUEIDENTIFIER NULL,
						 BatchQueueId UNIQUEIDENTIFIER NULL,
						 CUser VARCHAR(200),
						 CDate DATETIME,
						 CONSTRAINT pk_' + @TempTableName + ' PRIMARY KEY (TempId)
						 )  END')  				  
					
					SET @BatchQueueIndex = @BatchQueueIndex + 1
				END
		
		DROP TABLE #BatchQueueJob 

	SET NOCOUNT OFF
	END
END	
	
	

	
	
GO	


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobItem_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQJobItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJobItem_INSERT]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePagePkID uniqueidentifier,
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueId uniqueidentifier,
	@CUser NVarChar(200),
	@CDate datetime
)
AS 


DECLARE @TempTableName varchar(200)
	
	SELECT @TempTableName = '__' + 
		REPLACE(CAST(@BatchQueueJobId AS VARCHAR(40)),'-','') 
		+ '_' +
		REPLACE(CAST(@BatchQueuePageId AS VARCHAR(40)),'-','');	
	
DECLARE @SQLCountString NVARCHAR(500);	
DECLARE @SQLString NVARCHAR(500);
DECLARE @ParmDefinition NVARCHAR(500);
DECLARE @CountInt INT

	SET @SQLCountString = N'SELECT @cnt = COUNT(*) FROM dbo.' + @TempTableName + '  WHERE ' + @BatchQueuePagePkName + ' = @BatchQueuePagePkID'
	EXEC sp_executesql @SQLCountString, N'@BatchQueuePagePkID varchar(40), @cnt INT OUTPUT', @BatchQueuePagePkID, @cnt = @CountInt OUTPUT

	IF @CountInt = 0
	BEGIN
		SET @SQLString =N'INSERT INTO dbo.' + @TempTableName + ' 
											(' + @BatchQueuePagePkName + ', 
											BatchQueueJobId, 
											BatchQueueJobItemId,
											BatchQueuePageId,
											BatchQueueId,
											CUser,
											CDate)		
										VALUES 
											(@BatchQueuePagePkID,
											@BatchQueueJobId, 
											@BatchQueueJobItemId, 
											@BatchQueuePageId,
											@BatchQueueId,
											@CUser,
											@CDate)'
						
		SET @ParmDefinition = N'@BatchQueuePagePkID varchar(40),
								@BatchQueuePageID varchar(40),
								@BatchQueueJobId varchar(40),
								@BatchQueueJobItemId varchar(40),
								@BatchQueueId varchar(40),						
								@CUser NVarChar(200),
								@CDate datetime'
													

		EXEC sp_executesql @SQLString, @ParmDefinition,
										@BatchQueuePagePkID,
										@BatchQueuePageID,
										@BatchQueueJobId,
										@BatchQueueJobItemId,
										@BatchQueueId,						
										@CUser,
										@CDate

	END


GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJobItem_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQJobItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJobItem_DELETE]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePagePkID varchar(40),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueId uniqueidentifier,
	@CUser NVarChar(200),
	@CDate datetime
)
AS 

	
DECLARE @TempTableName varchar(200)
	
	SELECT @TempTableName = '__' + 
		REPLACE(CAST(@BatchQueueJobId AS VARCHAR(40)),'-','') 
		+ '_' +
		REPLACE(CAST(@BatchQueuePageId AS VARCHAR(40)),'-','');	
	
DECLARE @SQLCountString NVARCHAR(500);	
DECLARE @SQLString NVARCHAR(500);
DECLARE @ParmDefinition NVARCHAR(500);
DECLARE @CountInt INT

	SET @SQLCountString = N'DELETE FROM dbo.' + @TempTableName + '  WHERE ' + @BatchQueuePagePkName + ' = @BatchQueuePagePkID AND BatchQueueJobItemId = @BatchQueueJobItemId'
	EXEC sp_executesql @SQLCountString, N'@BatchQueueJobItemId varchar(40), @BatchQueuePagePkID varchar(40)', @BatchQueueJobItemId, @BatchQueuePagePkID


	--IF @CountInt = 0
	--BEGIN
	--	SET @SQLString =N'INSERT INTO dbo.' + @TempTableName + ' 
	--										(' + @BatchQueuePagePkName + ', 
	--										BatchQueueJobId, 
	--										BatchQueueJobItemId,
	--										BatchQueuePageId,
	--										BatchQueueId,
	--										CUser,
	--										CDate)		
	--									VALUES 
	--										(@BatchQueuePagePkID,
	--										@BatchQueueJobId, 
	--										@BatchQueueJobItemId, 
	--										@BatchQueuePageId,
	--										@BatchQueueId,
	--										@CUser,
	--										@CDate)'
						
	--	SET @ParmDefinition = N'@BatchQueuePagePkID varchar(40),
	--							@BatchQueuePageID varchar(40),
	--							@BatchQueueJobId varchar(40),
	--							@BatchQueueJobItemId varchar(40),
	--							@BatchQueueId varchar(40),						
	--							@CUser NVarChar(200),
	--							@CDate datetime'
													

	--	EXEC sp_executesql @SQLString, @ParmDefinition,
	--									@BatchQueuePagePkID,
	--									@BatchQueuePageID,
	--									@BatchQueueJobId,
	--									@BatchQueueJobItemId,
	--									@BatchQueueId,						
	--									@CUser,
	--									@CDate

	--END


		
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_SELECT]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable varchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate datetime	,
	@ReturnSQLString INT  = 0
)
AS 

BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE NOT EXISTS (SELECT * FROM ' +  @BatchQueueJobTable + ' WHERE ' + @BatchQueuePagePkName + ' = SqlBatchQ.' + @BatchQueuePagePkName + ')'



	DECLARE @tmpBatchQueueJobtable varchar(200),
		@tmpBatchQueuePagePkiName varchar(40),
		@BatchQueueIndex int, 
		@BatchQueueRowCount int

	SET @BatchQueueIndex = 1

		SET NOCOUNT ON
		BEGIN
			 
			SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex,
			 pBatchQueuePageDep.BatchQueuePageDepID, pBatchQueuePageDep.BatchQueuePageID, pBatchQueuePageDep.BatchQueuePageRelationID, 
			  pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, pBatchQueueJobItem.BatchQueueJobTable, 
			  pBatchQueuePageType.BatchQueuePagePkID
			INTO #BatchQueueDep  
			FROM pBatchQueuePageDep INNER JOIN
			  pBatchQueueJobItem ON pBatchQueuePageDep.BatchQueuePageRelationID = pBatchQueueJobItem.BatchQueuePageID INNER JOIN
			  pBatchQueuePage ON pBatchQueueJobItem.BatchQueuePageID = pBatchQueuePage.BatchQueuePageID INNER JOIN
			  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
			WHERE (pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID) AND 
			  (pBatchQueuePageDep.BatchQueuePageID = @BatchQueuePageID) 
			
			
			
			SET @BatchQueueRowCount = (SELECT COUNT(*) FROM #BatchQueueDep)
			
			WHILE @BatchQueueIndex <= @BatchQueueRowCount 
			BEGIN
										
				SELECT @tmpBatchQueueJobtable = BatchQueueJobTable, @tmpBatchQueuePagePkiName = BatchQueuePagePkID 
					FROM #BatchQueueDep WHERE BatchQueueIndex = @BatchQueueIndex	
					
						SET @SQLString = @SQLString + ' AND EXISTS (SELECT * FROM ' + @tmpBatchQueueJobtable +
							' WHERE ' + @tmpBatchQueuePagePkiName + ' = SqlBatchQ.' + @tmpBatchQueuePagePkiName + ')'
				
				
				SET @BatchQueueIndex = @BatchQueueIndex + 1
			END
	
			DROP TABLE #BatchQueueDep

		SET NOCOUNT OFF
		END		
END	
	
BEGIN						
	IF @ReturnSQLString = 0 
		EXEC (@SQLString) 					
	ELSE 
		SELECT @SQLString AS sqlString
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQPageForm_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQPageForm_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQPageForm_SELECT](
@BatchQueuePageID UNIQUEIDENTIFIER,
@BatchQueueJobID UNIQUEIDENTIFIER
)
AS 

--DECLARE
--@BatchQueuePageID UNIQUEIDENTIFIER,
--@BatchQueueJobID UNIQUEIDENTIFIER

--SELECT @BatchQueuePageID='5acb8240-1288-e011-81e9-005056c00008',@BatchQueueJobID='1b2a5cbf-c1fd-42f4-8e3e-d1a96d73b4d8'

SELECT     dbo.pBatchQueueJobItem.BatchQueueJobItemID, dbo.pBatchQueueJobItem.BatchQueueJobID, dbo.pBatchQueuePage.BatchQueuePageTypeID, 
                      dbo.pBatchQueueForm.BatchQueueFormXml, dbo.pBatchQueueForm.BatchQueueFormID, dbo.pBatchQueueForm.BatchQueuePageID, 
                      dbo.pBatchQueueForm.BatchQueueFormSeq, dbo.pBatchQueueForm.BatchQueueFormSql, dbo.pBatchQueueForm.BatchQueueFormSPX, 
                      dbo.pBatchQueueJobItem.BatchQueueJobTable, dbo.pBatchQueueForm.BatchQueueFormPkName, dbo.pBatchQueueForm.BatchQueueFormName
FROM         dbo.pBatchQueuePage INNER JOIN
                      dbo.pBatchQueueForm ON dbo.pBatchQueuePage.BatchQueuePageID = dbo.pBatchQueueForm.BatchQueuePageID LEFT OUTER JOIN
                      dbo.pBatchQueueJobItem ON dbo.pBatchQueueForm.BatchQueuePageID = dbo.pBatchQueueJobItem.BatchQueuePageID
WHERE pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID 
ORDER BY pBatchQueueForm.BatchQueueFormSeq




GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialReplaceWithID UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200)



CREATE TABLE #ms(
	StyleMaterialSizeID  UNIQUEIDENTIFIER,
	BatchQueueJobID UNIQUEIDENTIFIER,
	MaterialSizeOldID UNIQUEIDENTIFIER,
	MaterialSizeNewID UNIQUEIDENTIFIER,
	MaterialSize NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 	
)


-- Delete from pBatchQueueStyleMaterialSizeTmp
DELETE pBatchQueueStyleMaterialSizeTmp
FROM pBatchQueueStyleMaterialSizeTmp a
	LEFT OUTER JOIN dbo.pMaterialSize b ON a.MaterialSizeOldID  =  b.MaterialSizeID
WHERE b.MaterialID = @MaterialID
	AND a.BatchQueueJobID = @BatchQueueJobID 
	AND b.MaterialSize IS NULL



INSERT INTO #ms ( StyleMaterialSizeID, BatchQueueJobID, MaterialSizeOldID, MaterialSizeNewID, MaterialSize)
SELECT NEWID() AS StyleMaterialSizeID, @BatchQueueJobId AS BatchQueueJobId,
	a.MaterialSizeID AS MaterialSizeOldID, NULL AS MaterialSizeNewID,  a.MaterialSize
FROM pMaterialSize a
	LEFT OUTER JOIN  pBatchQueueStyleMaterialSizeTmp b ON a.MaterialSizeID = b.MaterialSizeOldID
		AND b.BatchQueueJobID = @BatchQueueJobID
WHERE A.MaterialID = @MaterialID
	AND MaterialSizeOldID IS NULL 
	
	
UPDATE #ms
SET MaterialSizeNewID = b.MaterialSizeID
FROM #ms a
	INNER JOIN pMaterialSize b ON a.MaterialSize = b.MaterialSize
WHERE b.MaterialID = @MaterialReplaceWithID


INSERT INTO dbo.pBatchQueueStyleMaterialSizeTmp ( StyleMaterialSizeID, BatchQueueJobID, MaterialSizeOldID, MaterialSizeNewID)
SELECT  StyleMaterialSizeID, BatchQueueJobID, MaterialSizeOldID, MaterialSizeNewID FROM #ms


SELECT a.StyleMaterialSizeID, a.MaterialSizeOldID AS MaterialSizeID, a.MaterialSizeNewID, @MaterialReplaceWithID AS MaterialID,
	b.MaterialSize
FROM pBatchQueueStyleMaterialSizeTmp a 
	INNER JOIN dbo.pMaterialSize b WITH(NOLOCK) ON a.MaterialSizeOldID = b.MaterialSizeID
WHERE BatchQueueJobID = @BatchQueueJobID


DROP TABLE #ms




GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 



DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MaterialID  UNIQUEIDENTIFIER,
	@MaterialReplaceWithID  UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
	

--** Get SeasonYearID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT


--** Get MaterialID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialID OUTPUT



--** Get MaterialReplaceWithID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 4

SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialReplaceWithID OUTPUT




IF @SeasonYearID IS NOT NULL AND @MaterialID IS NOT NULL AND @MaterialReplaceWithID IS NOT NULL 
BEGIN 

	--** Get Styles 
	CREATE TABLE  #style(
		StyleID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3

	SET @sySQL = 'INSERT INTO #style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL


	CREATE TABLE #color (
		ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
		ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
	)
	
	--** Get all styleColors
	
	INSERT INTO #color (ColorCode, ColorName)
	SELECT DISTINCT d.ColorCode, d.ColorName
	FROM #style a
		INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleID = b.StyleID 
		INNER JOIN dbo.pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
		INNER JOIN dbo.pStyleColorway e ON e.StyleColorID =  b.StyleColorwayID
		INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = e.ColorPaletteID
	WHERE c.SeasonYearID = @SeasonYearID
		AND LEN(ISNULL(d.ColorCode,'') ) > 0 
		AND LEN(ISNULL(d.ColorName,'')) > 0


	DROP TABLE  #style


	--** Remove colors
	DELETE FROM pBatchQueueStyleMaterialColorTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND ColorCode + '//' + ColorName NOT IN  ( 
		SELECT ColorCode + '//' + ColorName FROM #color
	)

	--** Add colors
	INSERT INTO  pBatchQueueStyleMaterialColorTmp
	( StyleMaterialColorID , BatchQueueJobId, ColorCode, ColorName) 
	SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
	FROM #color
	WHERE ColorCode  + '//' + ColorName NOT IN (
		SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
	) 	

	DROP TABLE #color
	
	

	UPDATE dbo.pBatchQueueStyleMaterialColorTmp
	SET MaterialColorID = e.MaterialColorID
	FROM pBatchQueueStyleMaterialColorTmp a
		INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
		INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
			AND e.MaterialID = @MaterialReplaceWithID
		INNER JOIN dbo.pMaterialColorSeasonYear b ON b.MaterialColorID = e.MaterialColorID
			AND b.SeasonyearID = @SeasonyearID 
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND  a.MaterialColorID IS NULL
		
		
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialReplaceWithID  AS MaterialID
	FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
	WHERE a.BatchQueueJobID = @BatchQueueJobID
	

END
ELSE 
	SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialReplaceWithID  AS MaterialID
	FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
	WHERE 1 = 2 




GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_WarningMessage_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQ_WarningMessage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQ_WarningMessage_SELECT](
	@BatchQueueJobID UNIQUEIDENTIFIER, 
	@BatchQueuePageTypeID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@TeamID UNIQUEIDENTIFIER,
	@BatchQueueJobTable NVARCHAR(200),
	@sql NVARCHAR(MAX),
	@Parameters NVARCHAR(200),
	@Count INT 


IF @BatchQueuePageTypeID = 'E1C913C0-7D8C-E011-81E9-005056C00008'
BEGIN
	--** BatchQ 'Mass add materials to Style', Page = 'Batch Queue StyleMaterials'
	SELECT @BatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 4


	SET @sql = 'SELECT @pCount = COUNT(*) FROM ' + @BatchQueueJobTable 
	SET @Parameters  = '@pCount INT OUTPUT'
	EXEC sp_executesql @sql, @Parameters, 
		@pCount = @Count OUTPUT
	
	IF @Count > 10
		SELECT 'You have selected more than 10 styles to update, Want to continue?' AS WarningMsg
	ELSE	
		SELECT '' AS WarningMsg		
		
END
ELSE IF @BatchQueuePageTypeID = '44E5E4E3-DD70-E011-9039-8EF3DCCB61B3'
BEGIN
	--** BatchQ 'Mass add materials to Style', Page = 'Select multiple styles'
	SELECT 'You have selected over 50 styles.' AS WarningMsg		

END 
ELSE IF @BatchQueuePageTypeID = '1734DB07-DE70-E011-9039-8EF3DCCB61B6'
BEGIN
	--** Colorways 
	SELECT 'You have selected over 5 colours.' AS WarningMsg		
	
END 
ELSE IF @BatchQueuePageTypeID='d0c913c0-7d8c-e011-81e9-005056c00012'
BEGIN 
	--** Material Find Replace 
	SELECT @BatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3

	SET @sql = 'SELECT @pCount = COUNT(*) FROM ' + @BatchQueueJobTable 
	SET @Parameters  = '@pCount INT OUTPUT'
	EXEC sp_executesql @sql, @Parameters, 
		@pCount = @Count OUTPUT
	
	IF @Count > 10
		SELECT 'You have selected more than 10 styles to update, Want to continue?' AS WarningMsg
	ELSE	
		SELECT '' AS WarningMsg		

END 


GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialColors_Review_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialColors_Review_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@BBUsage NVARCHAR(200),
	@BBUsageID UNIQUEIDENTIFIER,
	@MaterialID  UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@BatchQueueID UNIQUEIDENTIFIER,
	@MaterialColorID UNIQUEIDENTIFIER
	

SELECT @BatchQueueID = BatchQueueID 
FROM pBatchQueueJob
WHERE BatchQueueJobID = @BatchQueueJobID

--** Get SeasonYearID
SELECT @syBatchQueueJobTable = BatchQueueJobTable
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT


--** Get MaterialID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialID OUTPUT



IF @BatchQueueID = '90000000-0000-0000-0000-000000000003'
BEGIN 


	--** Check usage
	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3


	SET @sySQL = 'SELECT  @pCustomID = CustomID FROM ' + @syBatchQueueJobTable 
		+ ' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40))  + ''' '
	SET @ParmDefinition = '@pCustomID UNIQUEIDENTIFIER OUTPUT'
	EXECUTE	sp_executesql @sySQL, @ParmDefinition,
		@pCustomID = @BBUsageID OUTPUT
		
	SELECT @BBUsage =  Custom FROM dbo.xCustom103 WITH(NOLOCK) WHERE CustomID = @BBUsageID	


	IF @SeasonYearID IS NOT NULL AND @MaterialID IS NOT NULL AND @BBUsage IS NOT NULL 
	BEGIN 

		--** Get Styles 
		CREATE TABLE  #style(
			StyleID UNIQUEIDENTIFIER
		)

		SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
		FROM pBatchQueueJobItem WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
			AND BatchQueueJobSeq = 4

		SET @sySQL = 'INSERT INTO #style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
		EXECUTE sp_executesql @sySQL


		CREATE TABLE #color (
			ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
			ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
		)
		
		--** Get all styleColors
		
		INSERT INTO #color (ColorCode, ColorName)
		SELECT DISTINCT d.ColorCode, d.ColorName
		FROM #style a
			INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleID = b.StyleID 
			INNER JOIN dbo.pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
			INNER JOIN dbo.pStyleColorway e ON e.StyleColorID =  b.StyleColorwayID
			INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = e.ColorPaletteID
		WHERE c.SeasonYearID = @SeasonYearID
			AND LEN(ISNULL(d.ColorCode,'') ) > 0 
			AND LEN(ISNULL(d.ColorName,'')) > 0


		DROP TABLE  #style


		--** Remove colors
		DELETE FROM pBatchQueueStyleMaterialColorTmp
		WHERE BatchQueueJobId = @BatchQueueJobId
		AND ColorCode + '//' + ColorName NOT IN  ( 
			SELECT ColorCode + '//' + ColorName FROM #color
		)

		--** Add colors
		INSERT INTO  pBatchQueueStyleMaterialColorTmp
		( StyleMaterialColorID , BatchQueueJobId, ColorCode, ColorName) 
		SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
		FROM #color
		WHERE ColorCode  + '//' + ColorName NOT IN (
			SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
			WHERE BatchQueueJobId = @BatchQueueJobId
		) 	

		DROP TABLE #color
		
		
		--** Check if there is onlyl 1 color available
		IF ( SELECT COUNT(*) FROM dbo.pMaterialColorSeasonYear 
		WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  ) = 1
		BEGIN
		
			SET @MaterialColorID = NULL
			
			SELECT @MaterialColorID = MaterialColorID 
			FROM dbo.pMaterialColorSeasonYear WITH(NOLOCK)
			WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  
		
			UPDATE pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = @MaterialColorID, Reviewed = 1
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND ISNULL(Reviewed,0) = 0 
	
		END
		ELSE 
			--** Default color pitching
			UPDATE dbo.pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = e.MaterialColorID
			FROM pBatchQueueStyleMaterialColorTmp a
				INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
				INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
					AND e.MaterialID = @MaterialID
				INNER JOIN dbo.pMaterialColorSeasonYear b ON b.MaterialColorID = e.MaterialColorID
					AND b.SeasonyearID = @SeasonyearID 
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND a.MaterialColorID IS NULL
				AND ISNULL(a.Reviewed,0) = 0
		
		
		SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE a.BatchQueueJobID = @BatchQueueJobID


	END
	ELSE 
		SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE 1 = 2 

END 
ELSE
BEGIN


	IF @SeasonYearID IS NOT NULL AND @MaterialID IS NOT NULL 
	BEGIN 

		--** Get Styles 
		CREATE TABLE  #tm890style(
			StyleID UNIQUEIDENTIFIER
		)

		SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
		FROM pBatchQueueJobItem WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
			AND BatchQueueJobSeq = 3


		SET @sySQL = 'INSERT INTO #tm890style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
		EXECUTE sp_executesql @sySQL


		CREATE TABLE #tmp263color (
			ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
			ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
		)
		
		--** Get all styleColors
		
		INSERT INTO #tmp263color (ColorCode, ColorName)
		SELECT DISTINCT d.ColorCode, d.ColorName
		FROM #tm890style a
			INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleID = b.StyleID 
			INNER JOIN dbo.pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
			INNER JOIN dbo.pStyleColorway e ON e.StyleColorID =  b.StyleColorwayID
			INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = e.ColorPaletteID
		WHERE c.SeasonYearID = @SeasonYearID
			AND LEN(ISNULL(d.ColorCode,'') ) > 0 
			AND LEN(ISNULL(d.ColorName,'')) > 0


		DROP TABLE  #tm890style


		--** Remove colors
		DELETE FROM pBatchQueueStyleMaterialColorTmp
		WHERE BatchQueueJobId = @BatchQueueJobId
		AND ColorCode + '//' + ColorName NOT IN  ( 
			SELECT ColorCode + '//' + ColorName FROM #tmp263color
		)

		--** Add colors
		INSERT INTO  pBatchQueueStyleMaterialColorTmp
		( StyleMaterialColorID , BatchQueueJobId, ColorCode, ColorName) 
		SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
		FROM #tmp263color
		WHERE ColorCode  + '//' + ColorName NOT IN (
			SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
			WHERE BatchQueueJobId = @BatchQueueJobId
		) 	

		DROP TABLE #tmp263color
		
		
		--** Check if there is onlyl 1 color available
		IF ( SELECT COUNT(*) FROM dbo.pMaterialColorSeasonYear 
		WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  ) = 1
		BEGIN
		
			SET @MaterialColorID = NULL
			
			SELECT @MaterialColorID = MaterialColorID 
			FROM dbo.pMaterialColorSeasonYear WITH(NOLOCK)
			WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  
		
			UPDATE pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = @MaterialColorID, Reviewed = 1
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND ISNULL(Reviewed,0) = 0 
	
		END
		ELSE 
			--** Default color pitching
			UPDATE dbo.pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = e.MaterialColorID
			FROM pBatchQueueStyleMaterialColorTmp a
				INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
				INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
					AND e.MaterialID = @MaterialID
				INNER JOIN dbo.pMaterialColorSeasonYear b ON b.MaterialColorID = e.MaterialColorID
					AND b.SeasonyearID = @SeasonyearID 
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND a.MaterialColorID IS NULL
				AND ISNULL(a.Reviewed,0) = 0
		
		
		SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE a.BatchQueueJobID = @BatchQueueJobID		
			

	END
	ELSE 
		SELECT a.*, NULL AS StyleNo, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE 1 = 2 


END


GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_ExtraData_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQJob_ExtraData_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_ExtraData_SELECT](
	@BatchQueueJobID UNIQUEIDENTIFIER
)
AS


DECLARE 
	@SeasonYear NVARCHAR(200),
	@SeasonTable NVARCHAR(200),
	@MaterialGroupTable NVARCHAR(200),
	@MaterialTable NVARCHAR(200), 
	@MaterialReplaceWithTable NVARCHAR(200), 
	@SQL NVARCHAR(MAX),
	@SeasonYearID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialReplaceWithID UNIQUEIDENTIFIER,
	@ParmDefinition NVARCHAR(500),
	@BatchQueueID UNIQUEIDENTIFIER,
	@MaterialCoreID UNIQUEIDENTIFIER

SELECT @BatchQueueID = BatchQueueID FROM dbo.pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID

	
IF @BatchQueueID = '90000000-0000-0000-0000-000000000003' --** Add Material Batchqueue
BEGIN 
	
	
	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SELECT @MaterialTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'


	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- ** Material selected
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialID OUTPUT


	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID

END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000012' --** Material Replace batch queue
BEGIN 
	
	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'


	SELECT @MaterialTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'

	SELECT @MaterialReplaceWithTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0003'

	
	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- ** Material 
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialID OUTPUT


	-- ** Material to replace with 
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialReplaceWithTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialReplaceWithID OUTPUT


	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID, 
	@MaterialReplaceWithID AS MaterialReplaceWithID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000010' --** Material Group batch queue
BEGIN 


	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SELECT @MaterialGroupTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'
	
	
		-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	-- ** Material Group
	SET @SQL = 'SELECT @pMaterialCoreID = MaterialCoreID FROM ' + @MaterialGroupTable
	SET @ParmDefinition = '@pMaterialCoreID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialCoreID = @MaterialCoreID OUTPUT

		
	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, MaterialCoreID
	FROM dbo.pMaterialCore a WITH(NOLOCK)
	WHERE MaterialCoreID = @MaterialCoreID
			
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000011' --** StyleColorway batch queue
BEGIN 

	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'



	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID
	
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000013' --** Add Material Batchqueue
BEGIN 
	
	
	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SELECT @MaterialTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'


	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- ** Material selected
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialID OUTPUT


	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID

END 


GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQPage_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQPage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQPage_SELECT](
@BatchQueuePageID UNIQUEIDENTIFIER,
@BatchQueueJobID UNIQUEIDENTIFIER
)
AS 

SELECT pBatchQueuePage.BatchQueuePageID, pBatchQueuePage.BatchQueuePageTypeID, pBatchQueuePage.BatchQueueID, 
	  pBatchQueuePage.BatchQueuePageOrder, pBatchQueuePage.CUser, pBatchQueuePage.CDate, pBatchQueuePage.MUser, 
	  pBatchQueuePage.MDate, pBatchQueuePageType.BatchQueuePageTypeName, pBatchQueuePageType.BatchQueuePageTypeDesc, 
	  pBatchQueuePageType.BatchQueuePageXmlSearch, pBatchQueuePageType.BatchQueuePageXmlForm, pBatchQueuePageType.BatchQueuePageXmlSelected,
	  pBatchQueuePageType.BatchQueuePageRecType, pBatchQueuePageType.BatchQueuePageRecMax, pBatchQueuePageType.BatchQueuePageSPX, 
	  pBatchQueuePageType.BatchQueuePageXmlGrid, pBatchQueuePageType.BatchQueuePageUrl, pBatchQueuePageType.BatchQueuePagePkID, 
	  pBatchQueueJobItem.BatchQueueJobItemID, pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, 
	  pBatchQueueJobItem.BatchQueueJobTable, pBatchQueuePageType.BatchQueueExecuteSPX, 
	  pBatchQueuePageType.BatchQueueLogicInsertSPX, pBatchQueuePageType.BatchQueuePageXmlGridAlternating,
	  pBatchQueuePageType.BatchQueueGridAlternatingName, pBatchQueuePageType.BatchQueueGridXMLThumbnail,
	  pBatchQueuePageType.BatchQueuePageXmlColorGrid
FROM  pBatchQueuePage INNER JOIN
	  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID INNER JOIN
	  pBatchQueueJobItem ON pBatchQueuePage.BatchQueuePageID = pBatchQueueJobItem.BatchQueuePageID
WHERE pBatchQueuePage.BatchQueuePageID = @BatchQueuePageID AND 
		pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID 





GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_SeasonYear_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQGrid_SeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_SeasonYear_SELECT]
(
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable varchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate datetime	,
	@ReturnSQLString INT = 0
)
AS 

BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE NOT EXISTS (SELECT * FROM ' +  @BatchQueueJobTable + ' WHERE ' + @BatchQueuePagePkName + ' = SqlBatchQ.' + @BatchQueuePagePkName + ')'

	DECLARE @tmpBatchQueueJobtable varchar(200),
		@tmpBatchQueuePagePkiName varchar(40),
		@BatchQueueIndex int, 
		@BatchQueueRowCount int

	SET @BatchQueueIndex = 1

		SET NOCOUNT ON
		BEGIN

			SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex,
			 pBatchQueuePageDep.BatchQueuePageDepID, pBatchQueuePageDep.BatchQueuePageID, pBatchQueuePageDep.BatchQueuePageRelationID, 
			  pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, pBatchQueueJobItem.BatchQueueJobTable, 
			  pBatchQueuePageType.BatchQueuePagePkID
			INTO #BatchQueueDep  
			FROM pBatchQueuePageDep INNER JOIN
			  pBatchQueueJobItem ON pBatchQueuePageDep.BatchQueuePageRelationID = pBatchQueueJobItem.BatchQueuePageID INNER JOIN
			  pBatchQueuePage ON pBatchQueueJobItem.BatchQueuePageID = pBatchQueuePage.BatchQueuePageID INNER JOIN
			  pBatchQueuePageType ON pBatchQueuePage.BatchQueuePageTypeID = pBatchQueuePageType.BatchQueuePageTypeID
			WHERE (pBatchQueueJobItem.BatchQueueJobID = @BatchQueueJobID) AND 
			  (pBatchQueuePageDep.BatchQueuePageID = @BatchQueuePageID) 

			SET @BatchQueueRowCount = (SELECT COUNT(*) FROM #BatchQueueDep)
				WHILE @BatchQueueIndex <= @BatchQueueRowCount 
					BEGIN

						SELECT @tmpBatchQueueJobtable = BatchQueueJobTable, @tmpBatchQueuePagePkiName = BatchQueuePagePkID 
							FROM #BatchQueueDep WHERE BatchQueueIndex = @BatchQueueIndex	

								SET @SQLString = @SQLString + ' AND EXISTS (SELECT * FROM ' + @tmpBatchQueueJobtable +
									' WHERE ' + @tmpBatchQueuePagePkiName + ' = SqlBatchQ.' + @tmpBatchQueuePagePkiName + ')'

						SET @BatchQueueIndex = @BatchQueueIndex + 1
					END

			DROP TABLE #BatchQueueDep

		SET NOCOUNT OFF
		END		
END	

BEGIN						
	EXEC (@SQLString + ' ORDER BY [YEAR], [Season] ') 					
END


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01586'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01586', GetDate())
END	

GO
