IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_rReportTechPackFolder_bq]'))
DROP VIEW [dbo].[vwx_rReportTechPackFolder_bq]
GO

CREATE VIEW [dbo].[vwx_rReportTechPackFolder_bq]
AS
SELECT * FROM  rReportTechPackFolder WHERE active=1 --And issample =0 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06920', GetDate())
GO
