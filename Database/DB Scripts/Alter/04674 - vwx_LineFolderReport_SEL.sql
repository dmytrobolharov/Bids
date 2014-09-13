IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderReport_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderReport_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_LineFolderReport_SEL]
AS
SELECT
	lf.LineFolderID
	, lf.LineSubFolder1
	, lf.LineFolderDescription
	, sy.Season
	, lf.LineSubFolder6
	, lf.CDate
	, sy.Year
	, lf.CUser
	, lf.MDate
FROM
	dbo.pLineFolder AS lf
	LEFT OUTER JOIN dbo.pSeasonYear AS sy ON lf.SeasonYearID = sy.SeasonYearID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04674', GetDate())
GO
