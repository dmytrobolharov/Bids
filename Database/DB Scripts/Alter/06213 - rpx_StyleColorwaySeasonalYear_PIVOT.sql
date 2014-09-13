IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]
GO

CREATE PROCEDURE [dbo].[rpx_StyleColorwaySeasonalYear_PIVOT]
(
	@StyleId NVARCHAR(50)
	,@SeasonYearID NVARCHAR(50) = NULL
)

AS


SELECT
	 b.StyleColorName
	,b.StyleColorNo
	,c.[Status]
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery1) as StyleColorDelivery1
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery2) as StyleColorDelivery2
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery3) as StyleColorDelivery3
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery4) as StyleColorDelivery4
FROM pStyleColorwaySeasonYear AS a
	INNER JOIN pStyleColorway AS b ON a.StyleColorwayID = b.StyleColorID
	LEFT OUTER JOIN pStyleColorwayStatus AS c ON a.StyleColorStatus = c.StatusID
	INNER JOIN pStyleSeasonYear d ON a.StyleSeasonYearID = d.StyleSeasonYearID
WHERE d.SeasonYearID = @SeasonYearID
	AND b.StyleID = @StyleId
		
UNION

SELECT
	 b.ColorName AS StyleColorName
	,b.ColorCode AS StyleColorNo
	,c.[Status]
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery1) as StyleColorDelivery1
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery2) as StyleColorDelivery2
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery3) as StyleColorDelivery3
	,dbo.fnx_int2StrDelivery(a.StyleColorDelivery4) as StyleColorDelivery4
FROM pStyleColorwaySeasonYear AS a
	INNER JOIN pColorPalette AS b ON a.ColorPaletteID = b.ColorPaletteID
	LEFT OUTER JOIN pStyleColorwayStatus AS c ON a.StyleColorStatus = c.StatusID
	INNER JOIN pStyleSeasonYear d ON a.StyleSeasonYearID = d.StyleSeasonYearID
WHERE d.SeasonYearID = @SeasonYearID
	AND a.StyleID = @StyleId 
	AND a.StyleColorwayID IS NULL
ORDER BY StyleColorNo -- make ordering consistent with seasonal colorway page

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06213', GetDate())
GO
