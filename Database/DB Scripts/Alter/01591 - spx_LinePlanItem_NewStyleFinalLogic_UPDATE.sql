IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanItem_NewStyleFinalLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanItem_NewStyleFinalLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItem_NewStyleFinalLogic_UPDATE](
	@StyleID UNIQUEIDENTIFIER,
	@LinePlanID UNIQUEIDENTIFIER,
	@LinePlanItemID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@AllowColorAllocation INT,
	@AllowMaterialAllocation INT
)
AS


DECLARE 
	@Override NVARCHAR(200),
	@SqlString NVARCHAR(MAX),
	@LinePlanRangeID UNIQUEIDENTIFIER

SELECT @Override = RTRIM(LTRIM(ISNULL([Override],''))) FROM dbo.sOverrideSPX WITH(NOLOCK) WHERE OriginalSPX = 'spx_LinePlanBusinessItemNew_INSERT'
IF @Override IS NULL OR LEN(@Override) = 0  SET @Override = 'spx_LinePlanBusinessItemNew_INSERT'

SET @SqlString = @Override + ' ' + 
	'@StyleID=''' + CAST(@StyleID AS NVARCHAR(40))  + ''', ' + 
	'@LinePlanItemID=''' + CAST(@LinePlanItemID  AS NVARCHAR(40))+ ''' ' 
EXEC sp_executesql @SqlString

SET @Override =  NULL 
SELECT @Override = RTRIM(LTRIM(ISNULL([Override],'')))  FROM dbo.sOverrideSPX WITH(NOLOCK) WHERE OriginalSPX = 'spx_LinePlanStyleDelivery_Logic_UPDATE'
IF @Override IS NULL OR LEN(@Override) = 0  SET @Override =  'spx_LinePlanStyleDelivery_Logic_UPDATE'

SET @SqlString = @Override + ' ' + 
	'@StyleID=''' + CAST(@StyleID AS NVARCHAR(40))  + ''', ' + 
	'@LinePlanID=''' + CAST(@LinePlanID AS NVARCHAR(40)) + ''', ' + 
	'@LinePlanItemID=''' + CAST(@LinePlanItemID  AS NVARCHAR(40))+ ''' ' 
EXEC sp_executesql @SqlString


--**** Allocate Material
DECLARE @MaterialID  UNIQUEIDENTIFIER 
SELECT @MaterialID = MaterialID FROM dbo.pStyleHeader WITH(NOLOCK) WHERE StyleID = @StyleID 

IF @MaterialID IS NOT NULL
BEGIN 


	DECLARE @pLinePlanMaterialRangeID UNIQUEIDENTIFIER
	EXEC spx_LinePlanMaterialRange_SELECT	
		@LinePlanItemID = @LinePlanItemID,
		@LinePlanMaterialRangeID = @pLinePlanMaterialRangeID OUTPUT 	


	SET @Override =  NULL 
	SELECT @Override = RTRIM(LTRIM(ISNULL([Override],''))) FROM dbo.sOverrideSPX WITH(NOLOCK) WHERE OriginalSPX = 'spx_LinePlanMaterial_INSERT'	
	IF @Override IS NULL OR LEN(@Override) = 0  SET @Override = 'spx_LinePlanMaterial_INSERT'
	SET @SqlString = @Override + ' ' + 
		'@LinePlanID=''' + CAST(@LinePlanID AS NVARCHAR(40)) + ''', ' + 
		'@MaterialID=''' + CAST(@MaterialID AS NVARCHAR(40)) + ''', ' + 
		'@CreatedBy=''' +  @MUser + ''', ' + 
		'@CreatedDate=''' + CONVERT( NVARCHAR(40),@MDate, 20)  + ''' ' 
	EXEC sp_executesql @SqlString


	SET @Override =  NULL 
	SELECT @Override = RTRIM(LTRIM(ISNULL([Override],''))) FROM dbo.sOverrideSPX WITH(NOLOCK) WHERE OriginalSPX = 'spx_LinePlanMaterialItem_INSERT'	
	IF @Override IS NULL OR LEN(@Override) = 0 SET @Override = 'spx_LinePlanMaterialItem_INSERT'
	SET @SqlString = @Override + ' ' + 
		'@LinePlanID=''' + CAST(@LinePlanID AS NVARCHAR(40)) + ''', ' + 
		'@LinePlanRangeId=''' + CAST(@pLinePlanMaterialRangeID AS NVARCHAR(40)) + ''', ' + 
		'@MaterialID=''' + CAST(@MaterialID AS NVARCHAR(40)) + ''', ' + 
		'@CUser=''' +  @MUser + ''', ' + 
		'@CDate=''' + CONVERT( NVARCHAR(40),@MDate, 20)  + ''' ' 
	EXEC sp_executesql @SqlString

END 



--*******  Allocate Colors 
DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER

SELECT @StyleSeasonYearID  = StyleSeasonYearID FROM dbo.pStyleSeasonYear WITH(NOLOCK)
WHERE LinePlanItemID = @LinePlanItemID 

IF @StyleSeasonYearID IS NOT NULL 
BEGIN


	DECLARE @pLinePlanColorRangeID UNIQUEIDENTIFIER
	EXEC spx_LinePlanColorRange_SELECT	
		@LinePlanItemID = @LinePlanItemID,
		@LinePlanColorRangeID = @pLinePlanColorRangeID OUTPUT 	


	CREATE TABLE #color(
		ROWID INT IDENTITY(1,1),
		ColorPaletteID UNIQUEIDENTIFIER,
		ColorFolderID UNIQUEIDENTIFIER,
		ColorCode NVARCHAR(200),
		ColorName NVARCHAR(200)
	)

	INSERT INTO #color (ColorPaletteID,ColorFolderID, ColorCode, ColorName )
	SELECT b.ColorPaletteID, c.ColorFolderID, c.ColorCode, c.ColorName
	FROM dbo.pStyleColorwaySeasonYear a WITH(NOLOCK)
		INNER JOIN dbo.pStyleColorway b WITH(NOLOCK) ON a.StyleColorwayID =  b.StyleColorID
		INNER JOIN dbo.pColorPalette c WITH(NOLOCK) ON c.ColorPaletteID =  b.ColorPaletteID
	WHERE StyleSeasonYearID = @StyleSeasonYearID


	DECLARE 
		@ROWID INT,
		@TOTAL INT,
		@ColorPaletteID UNIQUEIDENTIFIER,
		@ColorFolderID UNIQUEIDENTIFIER,
		@ColorCode NVARCHAR(200),
		@ColorName NVARCHAR(200),
		@tmpColorPaletteID UNIQUEIDENTIFIER

	SET @ROWID = 1 
	SELECT @TOTAL = COUNT(*) FROM #color 

	WHILE @ROWID <= @TOTAL 
	BEGIN 
		SELECT @ColorPaletteID = ColorPaletteID, @ColorFolderID = ColorFolderID,
		@ColorCode = ColorCode, @ColorName = ColorName,
		@tmpColorPaletteID = NULL 
		FROM #color WHERE ROWID = @ROWID

		-- Check for colorCode
		SELECT TOP 1 @tmpColorPaletteID = a.ColorPaletteID
		FROM dbo.pLinePlanColor a WITH(NOLOCK)
			INNER JOIN dbo.pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID =  b.ColorPaletteID 
		WHERE a.LinePlanID = @LinePlanID 
			AND b.ColorCode = @ColorCode 
			AND b.ColorName = @ColorName

		IF @tmpColorPaletteID IS NULL 
		BEGIN
			-- insert 
			INSERT INTO pLinePlanColor (LinePlanId, ColorFolderId, ColorPaletteID, CUser, CDate, MUser, MDate)
			VALUES (@LinePlanID, @ColorFolderID, @ColorPaletteID, @MUSer, @MDate, @MUSer, @MDate )

			SET @tmpColorPaletteID = @ColorPaletteID
		END 

		IF NOT EXISTS ( SELECT  * FROM dbo.pLinePlanColorItem a WITH(NOLOCK)
				INNER JOIN dbo.pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID
				WHERE a.LinePlanRangeID = @pLinePlanColorRangeID
				AND b.ColorCode = @ColorCode
				AND b.ColorName = @ColorName )
		BEGIN 

			INSERT INTO pLinePlanColorItem (LinePlanId, LinePlanRangeID, ColorPaletteID, CUser, CDate, MUser, MDate)
			VALUES (@LinePlanID, @pLinePlanColorRangeID, @tmpColorPaletteID, @MUSer, @MDate, @MUSer, @MDate)			

		END 

		SET @ROWID = @ROWID + 1 
	END  --while


END 


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01591'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01591', GetDate())
END	

GO

