


CREATE PROCEDURE rpx_StyleColorGroups_PIVOT (
@StyleID NVARCHAR(50),
@StyleSet int,
@SeasonYearID NVARCHAR(50)= NULL
)

AS


BEGIN 

CREATE TABLE #tmpStyleColorwayGroups (
Rec_ID INT IDENTITY (1,1) ,
StyleColorID UNIQUEIDENTIFIER , 
StyleID UNIQUEIDENTIFIER ,
StyleSet INT,
StyleColorNo NVARCHAR(50) , 
StyleColorName NVARCHAR(200) ,
MainColor NVARCHAR(100),
SAPCode NVARCHAR(50) , 
PLMCode NVARCHAR(200)
)

IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
BEGIN 

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

	SELECT @StyleSeasonYearID  = StyleSeasonYearID 
	FROM pStyleSeasonYear
	WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID 

	INSERT INTO #tmpStyleColorwayGroups (StyleColorID , StyleID, StyleSet, StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)
	SELECT b.StyleColorID , b.StyleID, b.StyleSet, b.StyleColorNo, c.ColorName, c.ColorName, b.SAPCode, b.PLMCode 
	FROM pStyleColorwaySeasonYear a INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID
	INNER JOIN pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
	WHERE  a.StyleID = @StyleID
	AND a.StyleSeasonYearID = @StyleSeasonYearID
	AND b.StyleSet = @StyleSet 
	ORDER BY b.Sort, b.MainColor
END
ELSE 
BEGIN

	INSERT INTO #tmpStyleColorwayGroups (StyleColorID , StyleID, StyleSet, StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)
	SELECT StyleColorID , a.StyleID, a.StyleSet, StyleColorNo, b.ColorName AS StyleColorName, b.ColorName AS MainColor, SAPCode, PLMCode 
	FROM pStyleColorway a 
	INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE StyleID = @StyleID 
	--AND StyleSet = @StyleSet
	ORDER BY a.Sort, a.MainColor

END

CREATE TABLE #StyleColorValues (
Rec_ID INT IDENTITY (0,1) ,
StyleColorGroupID UNIQUEIDENTIFIER , 
StyleID UNIQUEIDENTIFIER ,
StyleSet INT,
ColorGroupID UNIQUEIDENTIFIER ,
ColorGroupName NVARCHAR(200) ,
StyleColorID  UNIQUEIDENTIFIER ,
StyleColorName NVARCHAR(200) ,
Quantity DECIMAL 
)

IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
BEGIN
    INSERT INTO #StyleColorValues (StyleColorGroupID, StyleID, StyleSet, ColorGroupID, 
	ColorGroupName, StyleColorID, StyleColorName, Quantity)
	SELECT     b.StyleColorGroupID, b.StyleID, b.StyleSet, b.ColorGroupID, 
	b.ColorGroupName, a.StyleColorID, a.StyleColorName, c.Quantity	
	FROM         #tmpStyleColorwayGroups AS a LEFT OUTER JOIN
						  pStyleColorGroup AS b ON a.StyleID = b.StyleID LEFT OUTER JOIN
						  pStyleColorGroupItem AS c ON c.StyleColorGroupID = b.StyleColorGroupID AND a.StyleColorID = c.StyleColorID
	WHERE     (a.StyleID = @StyleID) AND (a.StyleSet = @StyleSet) AND b.StyleID=@StyleID AND b.StyleSet = @StyleSet AND b.SeasonYearID = @SeasonYearID AND c.SeasonYearID = @SeasonYearID
	ORDER BY b.Sort, b.ColorGroupName
END
ELSE
BEGIN
    INSERT INTO #StyleColorValues (StyleColorGroupID, StyleID, StyleSet, ColorGroupID, 
	ColorGroupName, StyleColorID, StyleColorName, Quantity)
	SELECT     b.StyleColorGroupID, b.StyleID, b.StyleSet, b.ColorGroupID, 
	b.ColorGroupName, a.StyleColorID, a.StyleColorName, c.Quantity	
	FROM         #tmpStyleColorwayGroups  AS a LEFT OUTER JOIN
						  pStyleColorGroup AS b ON a.StyleID = b.StyleID LEFT OUTER JOIN
						  pStyleColorGroupItem AS c ON c.StyleColorGroupID = b.StyleColorGroupID AND a.StyleColorID = c.StyleColorID
	WHERE     (a.StyleID = @StyleID) AND (a.StyleSet = @StyleSet) AND b.StyleID=@StyleID AND b.StyleSet = @StyleSet 
	ORDER BY b.Sort, b.ColorGroupName
END

DECLARE @IntegerCount int

Select @IntegerCount = Count(distinct(StyleColorName)) from #StyleColorValues


SELECT
	Rec_ID % @IntegerCount AS [Column],
    Rec_ID / @IntegerCount AS [Row],
	ColorGroupName,
StyleColorName, Quantity
FROM #StyleColorValues


DROP TABLE #StyleColorValues
DROP TABLE #tmpStyleColorwayGroups

END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '004', GetDate())

GO
