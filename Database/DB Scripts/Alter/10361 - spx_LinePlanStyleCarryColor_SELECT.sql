IF OBJECT_ID(N'[dbo].[spx_LinePlanStyleCarryColor_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanStyleCarryColor_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanStyleCarryColor_SELECT](
	@LinePlanID UNIQUEIDENTIFIER,
	@StyleID	UNIQUEIDENTIFIER, 
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@LinePlanItemID UNIQUEIDENTIFIER, 
	@TeamID UNIQUEIDENTIFIER,
	@AllowColorAllocation INT
)
AS


DECLARE 
	@ColorLinePlanRangeID UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID1 UNIQUEIDENTIFIER, 
	@LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID3 UNIQUEIDENTIFIER, 
	@LinePlanAttributeItemID4 UNIQUEIDENTIFIER,
	@Index INT


--** LinePlan Hierarchy index 
SELECT @Index =  COUNT(*) 
FROM dbo.pLinePlanTemplateItem a WITH(NOLOCK)
	INNER JOIN pLinePlanTemplate b WITH(NOLOCK) ON b.LinePlanTemplateID = a.LinePlanTemplateID
	INNER JOIN dbo.pLinePlan c WITH(NOLOCK) ON c.LinePlanTemplateID =  b.LinePlanTemplateID
WHERE c.LinePlanID = @LinePlanID


SELECT 
	@LinePlanAttributeItemID1 = LinePlanAttributeItemID1, 
	@LinePlanAttributeItemID2 = LinePlanAttributeItemID2,
	@LinePlanAttributeItemID3 = LinePlanAttributeItemID3, 
	@LinePlanAttributeItemID4 = LinePlanAttributeItemID4
FROM pLinePlanRange WITH(NOLOCK) WHERE LinePlanRangeID = @LinePlanRangeID 


IF @Index = 4
BEGIN
	SELECT @ColorLinePlanRangeID = LinePlanRangeID 
	FROM pLinePlanRange WITH(NOLOCK)
	WHERE  LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
END 
ELSE
BEGIN
	SELECT @ColorLinePlanRangeID = LinePlanRangeID 
	FROM pLinePlanRange WITH(NOLOCK)
	WHERE  LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
END 


CREATE TABLE #tmpColor (
	ROW_ID INT IDENTITY (1,1),
	ColorPaletteID UNIQUEIDENTIFIER,
	ColorType NVARCHAR(5),
	ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
	ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
	Custom_ColorType NVARCHAR(5)
)



INSERT INTO #tmpColor (ColorType , ColorCode, ColorName, Custom_ColorType)
SELECT DISTINCT 'R' AS ColorType, c.ColorCode, c.ColorName, 'C' 
FROM pStyleColorwaySeasonYear a WITH(NOLOCK)
	INNER JOIN pStyleColorway b WITH(NOLOCK) ON  a.StyleColorwayID  = b.StyleColorID
	LEFT OUTER JOIN pColorPalette c WITH(NOLOCK) ON c.ColorPaletteID  = b.ColorPaletteID 
WHERE a.StyleID = @StyleID






DECLARE 
	@ROW_ID INT,
	@TOTAL INT,
	@ColorCode NVARCHAR(200),
	@ColorName NVARCHAR(200),
	@ColorPaletteID UNIQUEIDENTIFIER 

SET @ROW_ID  = 1 
SELECT @TOTAL = COUNT(*) FROM  #tmpColor

WHILE @ROW_ID <= @TOTAL 
BEGIN
	
	SELECT @ColorCode = ColorCode, @ColorName = ColorName FROM #tmpColor WHERE ROW_ID = @ROW_ID
	
	SET @ColorPaletteID =  NULL 
	
	SELECT TOP 1 @ColorPaletteID = b.ColorPaletteID 
	FROM pStyleColorwaySeasonYear a WITH(NOLOCK)
		INNER JOIN pStyleColorway b WITH(NOLOCK) ON a.StyleColorwayID  = b.StyleColorID
		LEFT OUTER JOIN pColorPalette c WITH(NOLOCK) ON c.ColorPaletteID  = b.ColorPaletteID 
	WHERE a.StyleID = @StyleID
		AND ColorCode = @ColorCode
		AND ColorName = @ColorName 
	
	IF @ColorPaletteID IS NULL
		DELETE FROM #tmpColor WHERE ROW_ID = @ROW_ID
	ELSE 
		UPDATE #tmpColor set ColorPaletteID = @ColorPaletteID WHERE ROW_ID = @ROW_ID
	
	SET @ROW_ID = @ROW_ID + 1
END 


INSERT INTO #tmpColor (ColorPaletteID, ColorType, Custom_ColorType )
SELECT a.ColorPaletteID, 'F' AS ColorType , 'N' AS Custom_ColorType
FROM pLinePlanColorItem a WITH(NOLOCK)
	INNER JOIN pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID =  b.ColorPaletteID
WHERE  LinePlanRangeID = @ColorLinePlanRangeID 
AND ISNULL (b.ColorName,'') +  ISNULL (b.ColorCode,'')  NOT IN ( 
	SELECT ISNULL (ColorName,'') +  ISNULL (ColorCode,'') FROM #tmpColor  
)


IF @AllowColorAllocation = 0 
BEGIN

	INSERT INTO #tmpColor (ColorPaletteID, ColorType, Custom_ColorType)
	SELECT a.ColorPaletteID, 'F' AS ColorType , 'N' AS Custom_ColorType
	FROM dbo.pLinePlanColorItemTemp a WITH(NOLOCK)
	WHERE a.LinePlanColorGroupID = @LinePlanItemID
		AND a.TeamID = @TeamID 
	
END 


SELECT b.*, a.ColorType, a.Custom_ColorType,
	   dbo.fnx_GetStreamingColorImageHTML(b.ColorFolderID, b.ColorPaletteID, 20, 'border="0"') AS ColorUrl, 
	   0 AS Units, 0 AS StyleColorDelivery1, 0 AS StyleColorDelivery2, 0 AS StyleColorDelivery3,
	   1 AS StyleColorDelivery4, 0 AS StyleColorDelivery5				
FROM #tmpColor a
INNER JOIN pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID 
ORDER BY b.ColorName, b.ColorCode

DROP TABLE  #tmpColor


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10361', GetUTCDate())
GO
