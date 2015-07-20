/****** Object:  View [dbo].[vwx_LineFolderReport_SEL]    Script Date: 04/17/2013 10:51:27 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderReport_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderReport_SEL]
GO

/****** Object:  View [dbo].[vwx_LineFolderReport_SEL]    Script Date: 04/17/2013 10:51:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_LineFolderReport_SEL]
AS
SELECT     lf.LineFolderID, lf.LineSubFolder1, lf.LineFolderDescription, sy.Season, lf.LineSubFolder6, lf.CDate, sy.Year, lf.CUser, lf.MDate, lf.LineFolderDivisionID, 
                      dv.Custom AS Division
FROM         dbo.pLineFolder AS lf LEFT OUTER JOIN
                      dbo.pSeasonYear AS sy ON lf.SeasonYearID = sy.SeasonYearID LEFT OUTER JOIN
                      dbo.iCustom1 AS dv ON dv.CustomID = lf.LineFolderDivisionID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05585', GetDate())
GO
