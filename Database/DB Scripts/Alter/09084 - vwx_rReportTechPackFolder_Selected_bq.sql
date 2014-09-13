IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_rReportTechPackFolder_Selected_bq]'))
DROP VIEW [dbo].[vwx_rReportTechPackFolder_Selected_bq]
GO

CREATE VIEW [dbo].[vwx_rReportTechPackFolder_Selected_bq]
AS

SELECT ReportTechPackFolderID
	, ReportTechPackFolderName
	, ReportTechPackFormName
	, ReportTechPackGroup
	, ReportTechPackFinal
	, CDate
	, CUser
	, MDate
	, MUser
	, Sort
	, Active
FROM dbo.rReportTechPackFolder
WHERE Active = 1

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09084', GetDate())
GO