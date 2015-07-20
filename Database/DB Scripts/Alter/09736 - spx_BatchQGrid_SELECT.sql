/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_SELECT]    Script Date: 2/13/2015 4:41:13 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_SELECT]    Script Date: 2/13/2015 4:41:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_SELECT]
(
	@BatchQueuePagePkName nvarchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable nvarchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate datetime	,
	@ReturnSQLString INT  = 0
)
AS 

BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	DECLARE @GridSql NVARCHAR(MAX)
	
	-- If we click on the Add Colorways to Styles -> Select a colour palette... we should use this query but not the view
	-- so we do some replace actions below this query
	-- We need to search Season and Year fields, but we cannot include them into query because
	-- we will have more rows then we need when we do not search
    -- So I replace ColorSubFolder2 and ColorSubFolder3 to c.Season and c.Year below this query
    
	SET @GridSql = 'SELECT    DISTINCT a.ColorFolderID, a.ColorFolderDescription, a.ColorSubFolder1,
           a.ColorSubFolder4, a.ColorSubFolder5, a.ColorSubFolder6, a.ColorSubFolder7, 
           a.ColorSubFolder8, a.ColorSubFolder9, a.CUser, a.CDate, a.MUser, a.MDate, a.MChange, a.Active,
           a.StyleColorway, a.SystemServerStorageID, a.ColorTypeID, a.ColorTypeSort
	FROM       dbo.pColorFolder a
		LEFT join pColorFolderSeasonYear b on a.ColorFolderID = b.ColorFolderID
		LEFT join pSeasonYear c on b.SeasonYearID = c.SeasonYearID 
	WHERE     a.Active = 1'
	
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,' SELECT  * FROM vwx_BatchQ_ColorFolder_SEL WHERE',@GridSql + ' AND ')
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,' SELECT  * FROM vwx_BatchQ_ColorFolder_SEL',@GridSql + ' ')
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,'ColorSubFolder2','c.Season')
	SET @BatchQueueGridSql = REPLACE(@BatchQueueGridSql,'ColorSubFolder3','c.Year')
	
	-- Adding 'active-only' mode for Single Material pages
	
	IF CHARINDEX(' FROM vwx_BatchQ_MaterialSeasonalImage_SEL', @BatchQueueGridSql) > 0
	BEGIN
		IF CHARINDEX(' WHERE ', @BatchQueueGridSql) > 0
		SET @BatchQueueGridSql = @BatchQueueGridSql + ' AND Active = 1'
	ELSE
		SET @BatchQueueGridSql = @BatchQueueGridSql + ' WHERE Active = 1'
	END
	
	IF CHARINDEX(N' FROM  vwx_BatchQ_MaterialCore_SEL', @BatchQueueGridSql) > 0
	BEGIN
		IF CHARINDEX(' WHERE ', @BatchQueueGridSql) > 0
		SET @BatchQueueGridSql = @BatchQueueGridSql + ' AND Active = 1'
	ELSE
		SET @BatchQueueGridSql = @BatchQueueGridSql + ' WHERE Active = 1'
	END
	
	-- generate all missing relationship level
	IF CHARINDEX(N' FROM  vwx_TradePartnerRelationshipLevels_SEL', @BatchQueueGridSql) > 0
	BEGIN
		EXEC spx_TradePartner_RelationshipLevels_INSERT
	END
	
	SET @SQLString = 'SELECT * FROM (' + @BatchQueueGridSql + ') AS SqlBatchQ WHERE NOT EXISTS (SELECT * FROM pBatchQueueJobItemRecord WHERE BatchQueuePagePki = SqlBatchQ.' + @BatchQueuePagePkName + ' AND BatchQueueJobItemId = ''' + CAST(@BatchQueueJobItemId AS NVARCHAR(50)) + ''')'

	

	DECLARE @tmpBatchQueueJobtable nvarchar(200),
		@tmpBatchQueuePagePkiName nvarchar(40),
		@tmpBatchQueueJobItemID UNIQUEIDENTIFIER,
		@BatchQueueIndex int, 
		@BatchQueueRowCount int

	SET @BatchQueueIndex = 1

		SET NOCOUNT ON
		BEGIN
			 
			SELECT IDENTITY(INT, 1,1) AS BatchQueueIndex,
			 pBatchQueuePageDep.BatchQueuePageDepID, pBatchQueuePageDep.BatchQueuePageID, pBatchQueuePageDep.BatchQueuePageRelationID, 
			  pBatchQueueJobItem.BatchQueueJobID, pBatchQueueJobItem.BatchQueueJobSeq, pBatchQueueJobItem.BatchQueueJobTable, 
			  pBatchQueuePageType.BatchQueuePagePkID, pBatchQueueJobItem.BatchQueueJobItemID
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
										
				SELECT @tmpBatchQueueJobtable = BatchQueueJobTable, @tmpBatchQueuePagePkiName = BatchQueuePagePkID, @tmpBatchQueueJobItemID = BatchQueueJobItemID 
					FROM #BatchQueueDep WHERE BatchQueueIndex = @BatchQueueIndex	
					
						SET @SQLString = @SQLString + ' AND EXISTS (SELECT * FROM pBatchQueueJobItemRecord ' +
							' WHERE BatchQueuePagePki = SqlBatchQ.' + @tmpBatchQueuePagePkiName + ' AND BatchQueueJobItemId = ''' + CAST(@tmpBatchQueueJobItemID AS NVARCHAR(50)) + ''')'
				
				
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


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09736', GetDate())
GO
