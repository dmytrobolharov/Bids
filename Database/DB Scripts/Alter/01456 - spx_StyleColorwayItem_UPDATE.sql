IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayItem_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorwayItem_UPDATE]
GO 


CREATE PROCEDURE [dbo].[spx_StyleColorwayItem_UPDATE]  (
	@MaterialColorID UNIQUEIDENTIFIER,
	@StyleMaterialID UNIQUEIDENTIFIER = NULL,
	@StyleColorItemID UNIQUEIDENTIFIER = NULL,	
	@StyleID UNIQUEIDENTIFIER = NULL,
	@StyleSet INT = 1,
	@SeasonYearID UNIQUEIDENTIFIER = NULL,
	@AllColor INT = 0,
	@MUser NVARCHAR(200),
	@MDate DATETIME ,
	@ChangeTransID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@NoApplicableColor INT = 0
) 
AS 


--*** Check for the "No applicable" 
--*** Burberry logic 

IF @NoApplicableColor = 1
BEGIN
	DECLARE 
		@MaterialID  UNIQUEIDENTIFIER,
		@MaterialSeasonYearID UNIQUEIDENTIFIER
	
	SET @MaterialColorID =  NULL
	
	--** Verify that the color exists in Burberry's main colorpalette
	IF NOT EXISTS (SELECT * FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001'
		AND ColorPaletteID = '00000000-0000-0000-0000-000000000001' )
		RETURN 

	SELECT @MaterialID = a.MaterialID 
	FROM dbo.pStyleMaterials a WITH (NOLOCK)
	WHERE a.StyleMaterialID = @StyleMaterialID
	
	--**  Check for material/seasaonYear
	SELECT @MaterialSeasonYearID=MaterialSeasonYearID   
	FROM pMaterialSeasonYear WITH (NOLOCK)
	WHERE MaterialID = @MaterialID
	AND SeasonYearID = @SeasonYearID
	
	IF @MaterialSeasonYearID IS NULL
	BEGIN 
		SET @MaterialSeasonYearID = NEWID()
		INSERT INTO dbo.pMaterialSeasonYear(
			MaterialSeasonYearID ,SeasonYearID, MaterialID ,CUser ,CDate )
		VALUES (
			@MaterialSeasonYearID, @SeasonYearID, @MaterialID,@MUser, @MDate )
	END 


	--*** Check if the materialcolor exists ? 	
	SELECT @MaterialColorID = MaterialColorID FROM pMaterialColor WITH (NOLOCK) 
	WHERE MaterialID=@MaterialID
		AND ColorPaletteID = '00000000-0000-0000-0000-000000000001' 
		
	IF @MaterialColorID IS NULL
	BEGIN 
		SET @MaterialColorID =  NEWID()
		--** Add color to the material 
		EXECUTE spx_Material_Color_INSERT
			@MaterialColorID = @MaterialColorID,
			@MaterialID=@MaterialID,
			@ColorPaletteID= '00000000-0000-0000-0000-000000000001',
			@CUser = @MUser,
			@CDate = @MDate
	END 
	
	--** Check for the color in a Material/SeasonYear
	IF NOT EXISTS ( SELECT * FROM dbo.pMaterialColorSeasonYear 
		WHERE MaterialColorID = @MaterialColorID AND SeasonYearID = @SeasonYearID)
	BEGIN
		EXECUTE spx_MaterialColorSeasonYear_INSERT
			@MaterialID = @MaterialID,
			@MaterialColorID = @MaterialColorID,
			@SeasonYearID  = @SeasonYearID,
			@TeamID = @ChangeTransID,
			@CUser = @MUser,
			@CDate = @MDate
		
	END 
END 


DECLARE 
	@ChangeLogID UNIQUEIDENTIFIER,
	@BeforeValue UNIQUEIDENTIFIER,
	@BeforeText NVARCHAR(400),
	@AfterValue UNIQUEIDENTIFIER,
	@AfterText NVARCHAR(400),
	@ROWID INT,
	@TOTAL INT,
	@MultiDimension INT,
	@StyleColorID UNIQUEIDENTIFIER
	
CREATE TABLE #tmp(
	ROWID INT IDENTITY(1,1),
	StyleColorItemID UNIQUEIDENTIFIER,
	MaterialColorID UNIQUEIDENTIFIER,
	ColorName NVARCHAR(200),
	ColorCode NVARCHAR(200),
	MultiDimension INT,
	StyleMaterialID UNIQUEIDENTIFIER,
	StyleColorID UNIQUEIDENTIFIER
)


IF @AllColor = 1 
BEGIN 

	IF @SeasonYearID IS NULL 

		INSERT INTO #tmp( StyleColorItemID ,MaterialColorID ,
				  ColorName ,ColorCode, MultiDimension, StyleMaterialID, StyleColorID)
		SELECT a.StyleColorItemID, a.MaterialColorID, 
			ISNULL(c.ColorName,''), ISNULL(c.ColorCode,''),  e.MultiDimension,  a.StyleMaterialID, a.StyleColorID
		FROM dbo.pStyleColorwayItem a WITH (NOLOCK)
			INNER JOIN dbo.pStyleMaterials d WITH (NOLOCK) ON d.StyleMaterialID = a.StyleMaterialID
			INNER JOIN dbo.pMaterial e WITH (NOLOCK) ON e.MaterialID  =  d.MaterialID
			LEFT OUTER JOIN pMaterialColor b WITH (NOLOCK) ON a.MaterialColorID =  b.MaterialColorID
			LEFT OUTER JOIN dbo.pColorPalette c WITH (NOLOCK) ON	c.ColorPaletteID =  b.ColorPaletteID
		WHERE a.StyleMaterialID = @StyleMaterialID 
			AND a.StyleID = @StyleID 
			AND a.StyleSet = @StyleSet 
			
	ELSE 
		INSERT INTO #tmp( StyleColorItemID ,MaterialColorID ,
				  ColorName ,ColorCode, MultiDimension, StyleMaterialID, StyleColorID)
		SELECT a.StyleColorItemID, a.MaterialColorID, 
			ISNULL(c.ColorName,''), ISNULL(c.ColorCode,''),  e.MultiDimension,  a.StyleMaterialID, a.StyleColorID
		FROM dbo.pStyleColorwayItem a WITH (NOLOCK)
			INNER JOIN dbo.pStyleSeasonYear x ON x.StyleID = a.StyleID	
				AND x.SeasonYearID = @SeasonYearID
			INNER JOIN dbo.pStyleColorwaySeasonYear y ON y.StyleColorwayID  =  a.StyleColorID 
				AND y.StyleSeasonYearID = x.StyleSeasonYearID			
			INNER JOIN dbo.pStyleMaterials d WITH (NOLOCK) ON d.StyleMaterialID = a.StyleMaterialID
			INNER JOIN dbo.pMaterial e WITH (NOLOCK) ON e.MaterialID  =  d.MaterialID
			LEFT OUTER JOIN pMaterialColor b WITH (NOLOCK) ON a.MaterialColorID =  b.MaterialColorID
			LEFT OUTER JOIN dbo.pColorPalette c WITH (NOLOCK) ON	c.ColorPaletteID =  b.ColorPaletteID
		WHERE a.StyleMaterialID = @StyleMaterialID 
			AND a.StyleID = @StyleID 
			AND a.StyleSet = @StyleSet 	
		
END 
ELSE
BEGIN 

	INSERT INTO #tmp( StyleColorItemID ,MaterialColorID ,ColorName ,ColorCode,MultiDimension, StyleMaterialID, StyleColorID)
	SELECT a.StyleColorItemID, a.MaterialColorID,ISNULL(c.ColorName,''), ISNULL(c.ColorCode,''), e.MultiDimension,  a.StyleMaterialID, a.StyleColorID
	FROM dbo.pStyleColorwayItem a WITH (NOLOCK)
		INNER JOIN dbo.pStyleMaterials d WITH (NOLOCK) ON d.StyleMaterialID = a.StyleMaterialID
		INNER JOIN dbo.pMaterial e WITH (NOLOCK) ON e.MaterialID  =  d.MaterialID
		LEFT OUTER JOIN pMaterialColor b WITH (NOLOCK) ON a.MaterialColorID =  b.MaterialColorID
		LEFT OUTER JOIN dbo.pColorPalette c WITH (NOLOCK) ON	c.ColorPaletteID =  b.ColorPaletteID
	WHERE a.StyleColorItemID = @StyleColorItemID
	
END



-- Update Colorchips
UPDATE pStyleColorwayItem SET 
	MaterialColorID = @MaterialColorID,
	MUser = @MUser,
	MDate = @MDate
FROM pStyleColorwayItem 
	INNER JOIN #tmp ON 	pStyleColorwayItem.StyleColorItemID = #tmp.StyleColorItemID


----*** Check MultiMaterials
--SET @ROWID = 1
--SELECT @TOTAL =  COUNT(*) FROM #tmp

--WHILE @ROWID <= @TOTAL 
--BEGIN
--	SELECT @MultiDimension = MultiDimension,  @StyleMaterialID = StyleMaterialID, @StyleColorID = StyleColorID
--	FROM #tmp WHERE ROWID = @ROWID

--	IF @MultiDimension =  1
--	BEGIN 
--		-- Update subComponents using the default color combination 
		
--		UPDATE dbo.pStyleColorwayItem
--		SET MaterialColorID = d.MaterialColorId
--		FROM dbo.pStyleColorwayItem 
--			INNER JOIN dbo.pStyleMaterials  b ON pStyleColorwayItem.StyleMaterialID =  b.StyleMaterialID 
--			INNER JOIN pMaterialLinkColorway c ON c.MaterialColorID = @MaterialColorID -- parent color
--			INNER JOIN dbo.pMaterialLinkColorwayItem  d ON d.MaterialLinkColorwayID = c.MaterialLinkColorwayID
--				AND d.MaterialLinkID = b.MaterialLinkID
--		WHERE b.MultiMaterialParentID = @StyleMaterialID -- StyleMaterial Parent
--		AND pStyleColorwayItem.StyleColorID = @StyleColorID -- Style Colorway
	
--	END 

--	SET @ROWID = @ROWID + 1 
--END 






--****
--** Insert Log 
--****
IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
BEGIN 

	--Get New value 
	SELECT @AfterValue = a.MaterialColorID, @AfterText = '(' + ISNULL(b.ColorCode,'') + ') ' + ISNULL(b.ColorName,'')
	FROM dbo.pMaterialColor a WITH (NOLOCK)  
		INNER JOIN dbo.pColorPalette b WITH (NOLOCK)  ON b.ColorPaletteID =  a.ColorPaletteID
	WHERE a.MaterialColorID = @MaterialColorID

	IF @AfterValue IS NULL	
		SET @AfterText = NULL
		

	SET @ROWID = 1
	SELECT @TOTAL = COUNT(*) FROM #tmp 

	WHILE @ROWID <= @TOTAL	
	BEGIN

		SET @ChangeLogID =  NEWID()	
		
		SELECT @StyleColorItemID = StyleColorItemID,
			@BeforeValue = MaterialColorID,
			@BeforeText = '(' + ColorCode + ') ' + ColorName 
		FROM #tmp WHERE ROWID = @ROWID 
		
		IF @BeforeValue IS NULL 
			SET @BeforeText = NULL


		--** Log change
		INSERT INTO pChangeLog ( 
			ChangeLogID
			,ChangeTransID
			,ChangeTableID
			,ChangeTablePKID
			,ChangeUserID
			,ChangeUserName
			,changedate
			,ChangeSort
		)
		VALUES(
			@ChangeLogID
			,@ChangeTransID
			,'00000001-C1CC-DF11-AF06-005056C00008'
			,@StyleColorItemID 
			,@ChangeTransUserID
			,@MUser
			,@MDate
			,'0000'
		)
		
		INSERT INTO pChangeLogItem(
			ChangeLogItemID
			,ChangeTransID
			,ChangeLogID
			,ChangeFieldName
			,ChangeFieldAlias
			,ChangeBeforeValue
			,ChangeAfterValue
			,ChangeBeforeText
			,ChangeAfterText
			,ChangeSort)
		VALUES (
			NEWID()
			,@ChangeTransID
			,@ChangeLogID
			,'MaterialColorID'
			,'MaterialColorID'
			,@BeforeValue
			,@Aftervalue
			,@BeforeText
			,@AfterText
			,'0001')
				

		SET @ROWID = @ROWID + 1 
	END 

END 


	
DROP TABLE #tmp


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01456', GetDate())
GO


