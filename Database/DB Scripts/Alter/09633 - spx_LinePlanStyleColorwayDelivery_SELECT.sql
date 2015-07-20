IF OBJECT_ID(N'[dbo].[spx_LinePlanStyleColorwayDelivery_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanStyleColorwayDelivery_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanStyleColorwayDelivery_SELECT]  (
@LinePlanID nVARCHAR(40),
@LinePlanRangeID nVARCHAR(40), 
@LinePlanRangeTypeID nVARCHAR(40), 
@ColorPaletteID nVARCHAR(40),
@ColorStatusID nVARCHAR(5)
)
AS 

DECLARE @strQuery nVARCHAR(4000)


SET @strQuery = 'SELECT a.StyleColorID, a.ColorPaletteID, a.SAPCode, a.StyleSet, a.StyleColorNo + ''- '' + a.StyleColorName AS ColorName,   
	a.MainColor, a.Sort, a.Version, a.CDate, a.CUser, a.PLMCode, b.StyleNo, b.Description, 
	COALESCE(sc.Custom, b.SizeClass) AS SizeClass, COALESCE(sr.SizeRangeCode, b.SizeRange) AS SizeRange, 
	b.StyleNo + ''- '' + b.Description AS StyleDescription, b.StyleID, 
	c.ColorFolderID, d.StyleColorDelivery1, d.StyleColorDelivery2, d.StyleColorDelivery3, d.StyleColorDelivery4,
	d.StyleColorStatus, d.CustomField1,
	d.StyleColorwaySeasonYearID, d.StyleSeasonYearID, d.Units, d.ColorType, d.SampleStatus
FROM pStyleColorway a WITH (NOLOCK) 
INNER JOIN  pColorPalette c WITH (NOLOCK) ON a.ColorPaletteID = c.ColorPaletteID 
INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID
INNER JOIN pStyleColorwaySeasonYear d WITH  (NOLOCK) ON d.StyleColorwayID  = a.StyleColorID
LEFT JOIN pSizeClass sc ON sc.Custom = b.SizeClass
LEFT JOIN pSizeRange sr ON sr.SizeRangeCode = b.SizeRange
WHERE b.StyleID IN (
		SELECT StyleID FROM pLinePlanItem 
		WHERE CAST(LinePlanRangeID AS nVARCHAR(40)) = ''' +  @LinePlanRangeID +  ''' 
		AND CAST(StyleID AS nVARCHAR(40)) <> ''00000000-0000-0000-0000-000000000000'' 
		AND CAST(LinePlanRangeTypeID AS nVARCHAR(40)) = ''' +  @LinePlanRangeTypeID +  ''' 
) 
AND d.StyleSeasonYearID IN (
	SELECT StyleSeasonYearID FROM pStyleSeasonYear 
	WHERE LinePlanItemID  IN  ( 
		select LinePlanItemID 
		from pLinePlanItem
		WHERE LinePlanRangeID  = ''' +  @LinePlanRangeID +  ''' 
		AND StyleId  <> ''00000000-0000-0000-0000-000000000000'' 
	)
)
'


IF @ColorPaletteID <> ''
BEGIN
	SET @strQuery = @strQuery + ' AND CAST(a.ColorPaletteID AS nVARCHAR(40)) = ''' + @ColorPaletteID + ''''
END
IF @ColorStatusID <> ''
BEGIN
	SET @strQuery = @strQuery + ' AND CAST(d.StyleColorStatus AS nVARCHAR(5)) = ''' + @ColorStatusID + ''''
END


SET @strQuery = @strQuery + ' ORDER BY b.StyleNo, a.Sort, a.StyleColorName '

print @strQuery
EXEC (@strQuery)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09633', GetDate())
GO
