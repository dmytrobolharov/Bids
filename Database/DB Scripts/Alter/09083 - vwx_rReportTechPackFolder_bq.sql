IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_rReportTechPackFolder_bq]'))
DROP VIEW [dbo].[vwx_rReportTechPackFolder_bq]
GO


CREATE VIEW [dbo].[vwx_rReportTechPackFolder_bq]
AS

SELECT rtpf.*
	, cptpc.DivisionID AS CustomID
	, st.StyleTypeRepId
FROM rReportTechPackFolder rtpf
INNER JOIN pControlPredefinedTechPackConfig cptpc 
	ON rtpf.ReportTechPackFolderID = cptpc.ReportTechPackFolderID
INNER JOIN pStyleType st ON cptpc.StyleTypeID = st.StyleTypeID
WHERE rtpf.Active = 1 AND cptpc.Availible = 1 --And issample =0 



GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09083', GetDate())
GO