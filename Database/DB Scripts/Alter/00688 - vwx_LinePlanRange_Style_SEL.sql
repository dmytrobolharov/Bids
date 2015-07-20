IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanRange_Style_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_LinePlanRange_Style_SEL]
GO

CREATE VIEW dbo.vwx_LinePlanRange_Style_SEL
AS

SELECT a.LinePlanRangeID, a.StyleID, b.MaterialCoreID, b.StyleNo, b.Description,  c.StyleSeasonYearID, d.Season, d.Year
FROM pLinePlanItem a WITH (NOLOCK)
	INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID =  b.StyleID 
	INNER JOIN pStyleSeasonYear c WITH (NOLOCK) ON c.LinePlanItemID = a.LinePlanItemID
	INNER JOIN pSeasonYear d WITH (NOLOCK) ON d.SeasonYearID = c.SeasonYearID 
WHERE a.StyleID <> '00000000-0000-0000-0000-000000000000'



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '688', GetDate())
GO
