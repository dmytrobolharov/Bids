

/****** Object:  StoredProcedure [dbo].[spx_MaterialColorSeasonYear_Logic_INSERT]    Script Date: 10/15/2010 11:11:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialColorSeasonYear_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialColorSeasonYear_Logic_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_MaterialColorSeasonYear_Logic_INSERT]    Script Date: 10/15/2010 11:11:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_MaterialColorSeasonYear_Logic_INSERT](
@SeasonYearID UNIQUEIDENTIFIER,
@MaterialColorID UNIQUEIDENTIFIER,
@MaterialID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200), 
@CDate NVARCHAR(200)
)
AS


--******************************************************************
--** Add colors to the Lineplan using this material
--***
DECLARE @ROWID INT
DECLARE @TOTAL INT 
DECLARE @LinePlanID UNIQUEIDENTIFIER 
DECLARE @ColorName NVARCHAR(200)
DECLARE @ColorCode NVARCHAR(200)
DECLARE @ColorPaletteID UNIQUEIDENTIFIER 
DECLARE @ColorFolderID UNIQUEIDENTIFIER 

SELECT @ColorCode = b.ColorCode, @ColorName =  b.ColorName,
@ColorPaletteID = b.ColorPaletteID, @ColorFolderID = b.ColorFolderID
FROM pMaterialColor a
INNER JOIN  pColorPalette b On a.ColorPaletteID = b.ColorPaletteID
WHERE a.MaterialColorID = @MaterialColorID 

--***
--** Get LinePlans
--***

CREATE TABLE #lp (
ROWID INT IDENTITY(1,1),
LinePlanID UNIQUEIDENTIFIER
)

INSERT INTO #lp ( LinePlanID) 
SELECT b.LinePlanID
FROM pLinePlanMaterial a
INNER JOIN pLinePlan b ON a.LinePlanID = b.LinePlanID 
INNER JOIN pSeasonYear c ON c.Season = b.Season AND c.Year = b.Year 
WHERE a.MaterialID = @MaterialID 
AND c.SeasonYearID = @SeasonYearID 


SET @ROWID = 1 
SELECT @TOTAL = COUNT(*) FROM #lp

WHILE @ROWID <= @TOTAL 
BEGIN

	SELECT @LinePlanID = LinePlanID  FROM #lp WHERE ROWID = @ROWID 

	--*** Check if the colorExist 
	IF ( SELECT COUNT(*) FROM pLinePlanColor a
	INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
	WHERE a.LinePlanID = @LinePlanID
	AND b.ColorCode = @ColorCode ) = 0
	BEGIN
		--** Insert color to LinePlancolor	

		DECLARE @LinePlanColorID UNIQUEIDENTIFIER 
		SET @LinePlanColorID = NEWID()

		INSERT INTO pLinePlanColor ( LinePlanColorID , LinePlanID, ColorFolderID, ColorPaletteID, CUser, CDate, MUser, MDate )
		VALUES ( @LinePlanColorID, @LinePlanID, @ColorFolderID, @ColorPaletteID, @CUser, @CDate, @CUser, @CDate ) 

	END 

	SET @ROWID = @ROWID + 1

END 

DROP TABLE #lp


CREATE TABLE #lpm(
ROWID INT IDENTITY(1,1),
LinePlanRangeID UNIQUEIDENTIFIER, 
LinePlanID UNIQUEIDENTIFIER, 
LinePlanTemplateID  UNIQUEIDENTIFIER, 
LinePlanAttributeItemID1 UNIQUEIDENTIFIER,
LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
LinePlanAttributeItemID3 UNIQUEIDENTIFIER,
LinePlanAttributeItemID4 UNIQUEIDENTIFIER,
TemplateIndex INT ,
LinePlanAttributeText1 NVARCHAR(200),
LinePlanAttributeText2 NVARCHAR(200),
LinePlanAttributeText3 NVARCHAR(200),
LinePlanAttributeText4 NVARCHAR(200)
) 


INSERT INTO #lpm(LinePlanRangeID, LinePlanID, LinePlanAttributeItemID1,LinePlanAttributeItemID2,
LinePlanAttributeItemID3, LinePlanAttributeItemID4, LinePlanTemplateID, TemplateIndex,
LinePlanAttributeText1, LinePlanAttributeText2, LinePlanAttributeText3, LinePlanAttributeText4 
 )
SELECT a.LinePlanRangeID, a.LinePlanID, d.LinePlanAttributeItemID1,d.LinePlanAttributeItemID2, 
d.LinePlanAttributeItemID3, d.LinePlanAttributeItemID4, b.LinePlanTemplateID, 0 AS TemplateIndex, 
d.LinePlanAttributeText1, d.LinePlanAttributeText2, d.LinePlanAttributeText3, d.LinePlanAttributeText4 
FROM pLinePlanMaterialItem a
INNER JOIN pLinePlan b ON a.LinePlanID = b.LinePlanID 
INNER JOIN pSeasonYear c ON c.Season = b.Season AND c.Year = b.Year 
INNER JOIN pLinePlanRange d ON d.LinePlanRangeID = a.LinePlanRangeID
WHERE c.SeasonYearID = @SeasonYearID -- '5DDEE199-BF0F-4D0E-B49E-6345D209A8CD'
AND a.MaterialID = @MaterialID -- '1A810752-F967-4C6A-A90F-4EED8DE6B16A' 



--SELECT * FROM #lpm


DECLARE @LinePlanRangeID UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID1 UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID2 UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID3 UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID4 UNIQUEIDENTIFIER
DECLARE @LinePlanTemplateID  UNIQUEIDENTIFIER
DECLARE @LinePlanRangeColorID UNIQUEIDENTIFIER	
DECLARE @TemplateIndex INT 

SET @ROWID = 1 
SELECT @TOTAL = COUNT(*) FROM #lpm

WHILE @ROWID <= @TOTAL
BEGIN 

	SELECT @LinePlanRangeID = LinePlanRangeID, @LinePlanID = LinePlanID, 
	@LinePlanAttributeItemID1 = LinePlanAttributeItemID1, @LinePlanAttributeItemID2 = LinePlanAttributeItemID2, 
	@LinePlanAttributeItemID3 = LinePlanAttributeItemID3, @LinePlanAttributeItemID4 = LinePlanAttributeItemID4,
	@LinePlanTemplateID = LinePlanTemplateID, @TemplateIndex  = TemplateIndex 
	FROM #lpm 
	WHERE ROWID = @ROWID
	
	SET @LinePlanRangeColorID = NULL
	
	IF @TemplateIndex = 0 
	BEGIN
			SELECT @TemplateIndex = COUNT(*) FROM pLinePlanTemplateItem WHERE LinePlanTemplateID = @LinePlanTemplateID 
			
			UPDATE #lpm SET TemplateIndex = @TemplateIndex 
			WHERE LinePlanTemplateID = @LinePlanTemplateID 
	END 
	
		
	IF @TemplateIndex = 3 
	BEGIN
		SELECT @LinePlanRangeColorID = LinePlanRangeID 
		FROM pLinePlanRange
		WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
		AND LinePlanID = @LinePlanID
		
	END 		
	ELSE IF  @TemplateIndex = 4
	BEGIN 
		SELECT @LinePlanRangeColorID = LinePlanRangeID 
		FROM pLinePlanRange
		WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
		AND LinePlanID = @LinePlanID
	END
	 
		
	--SELECT @LinePlanRangeColorID as LinePlanRangeColorID, @LinePlanID as LinePlanID
	
	IF @LinePlanRangeColorID IS NOT NULL
	BEGIN
		IF ( SELECT COUNT(*) FROM pLinePlanColorItem a
			INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
			WHERE LinePlanRangeID = @LinePlanRangeColorID 
			AND a.LinePlanID = @LinePlanID
			AND b.ColorCode = @ColorCode ) = 0
		BEGIN
			INSERT INTO pLinePlanColorItem ( LinePlanColorItemID, LinePlanRangeID , LinePlanID, ColorPaletteID, CUser, CDate, MUser, MDate, Change, Active)
			VALUES ( NEWID(), @LinePlanRangeColorID , @LinePlanID,@ColorPaletteID, @CUser, @CDate, @CUser, @CDate, 1, 1 )
		END 
	END 

	SET @ROWID = @ROWID + 1
END 

DROP TABLE #lpm


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '607', GetDate())
GO

