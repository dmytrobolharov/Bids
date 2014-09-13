IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_linePlanItemStyleColor_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_linePlanItemStyleColor_SEL]
GO


CREATE VIEW [dbo].[vwx_linePlanItemStyleColor_SEL]
AS

SELECT TOP (100) PERCENT 
	'<a href="#" onclick=javascript:window.open(''../Style/Style_Redirect.aspx?SID=' + LOWER(CAST(b.StyleID AS NVARCHAR(40)))  + ''',''' + REPLACE (CAST(b.StyleID AS NVARCHAR(40)), '-', '') + 
	''',''width=10,height=10,toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes'')>  
	<img border="0" src="../System/Icons/icon_next.gif" ></a>'
	as GotoStyle,
	'<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(d.ColorFolderID, 
	'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(d.ColorPaletteID, 
	'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, e.LinePlanRangeID, a.StyleColorwaySeasonYearID, 
	a.StyleColorStatus, f.StyleNo, d.ColorCode, d.ColorName, e.LinePlanRangeTypeID, f.Description, ISNULL(a.Units,0) AS Units, a.SampleStatus, 
	a.StyleColorDelivery1, 
	CASE 
		WHEN a.StyleColorDelivery1 = 1 THEN 0 
		ELSE a.StyleColorDelivery2 
	END AS StyleColorDelivery2, 
	CASE 
		WHEN a.StyleColorDelivery1 = 1 OR a.StyleColorDelivery2 = 1 THEN 0 
		ELSE a.StyleColorDelivery3 
	END AS StyleColorDelivery3, 
	CASE
		WHEN a.StyleColorDelivery1 = 1 OR a.StyleColorDelivery2 = 1 OR a.StyleColorDelivery3 = 1 THEN 0 
		ELSE 1 
	END AS StyleColorDelivery4, 
	a.CustomField1, a.ColorType, 
	h.AttributeName, c.SeasonYearID, c.StyleID, 
	f.MaterialNo, f.MaterialName, b.SAPCode, b.PLMCode, f.CustomField14, 
	/*
	a.CustomField2, a.CustomField3, a.CustomField4, a.CustomField5, 
	a.CustomField6, a.GlobalBuy, a.RecommendedBuy, a.StyleColorDelivery5, a.CustomField7,
	a.Custom_ColorType,
	*/
	a.Locked 
FROM dbo.pStyleColorwaySeasonYear AS a 
	INNER JOIN dbo.pStyleColorway AS b ON b.StyleColorID = a.StyleColorwayID 
	INNER JOIN dbo.pStyleSeasonYear AS c ON c.StyleSeasonYearID = a.StyleSeasonYearID 
	INNER JOIN dbo.pColorPalette AS d ON d.ColorPaletteID = b.ColorPaletteID 
	INNER JOIN dbo.pLinePlanItem AS e ON e.LinePlanItemID = c.LinePlanItemID 
	INNER JOIN dbo.pStyleHeader AS f ON f.StyleID = b.StyleID 
	LEFT OUTER JOIN dbo.pLinePlanStyleAttributeItem AS g ON g.LinePlanStyleAttributeItemID = e.LinePlanStyleAttributeItemID 
	LEFT OUTER JOIN dbo.pLinePlanStyleAttribute AS h ON h.LinePlanStyleAttributeID = g.LineplanStyleAttributeID
ORDER BY f.StyleNo




GO

