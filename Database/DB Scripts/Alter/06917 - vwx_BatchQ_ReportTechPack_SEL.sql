IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ReportTechPack_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_ReportTechPack_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_ReportTechPack_SEL] 
AS 

SELECT a.ReportTechPackFolderID, a.ReportTechPackFolderName 
FROM dbo.rReportTechPackFolder a WITH(NOLOCK) 
WHERE a.Active = 1 
	--AND a.IsSample = 0



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06917', GetDate())
GO
