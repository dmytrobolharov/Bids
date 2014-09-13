IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_TechPackConfig_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_TechPackConfig_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Control_TechPackConfig_SELECT]
	@DivisionID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT
		CASE WHEN t.ReportTechPackFolderID IS NULL THEN t.StyleTypeDescription ELSE t.ReportTechPackFolderName END AS Name
		, t.StyleTypeID
		, t.ReportTechPackFolderID
		, t.StyleTypeDescription
		, t.ReportTechPackFolderName
		, ISNULL(Availible, 0) AS Availible
	FROM (
		SELECT st.StyleTypeID, st.StyleTypeDescription, rtpf.ReportTechPackFolderID, rtpf.ReportTechPackFolderName, st.StyleTypeOrder, rtpf.Sort, tpc.Availible
		FROM pControlPredefinedTechPackConfig tpc
			INNER JOIN pStyleType st ON tpc.StyleTypeID = st.StyleTypeID
			INNER JOIN rReportTechPackFolder rtpf ON tpc.ReportTechPackFolderID = rtpf.ReportTechPackFolderID
		WHERE tpc.DivisionID = @DivisionID
		UNION
		SELECT st.StyleTypeID, st.StyleTypeDescription, NULL AS ReportTechPackFolderID, NULL AS ReportTechPackFolderName, st.StyleTypeOrder, NULL AS Sort, NULL AS Availible
		FROM pControlPredefinedTechPackConfig tpc
			INNER JOIN pStyleType st ON tpc.StyleTypeID = st.StyleTypeID
		WHERE tpc.DivisionID = @DivisionID
	) t
	ORDER BY StyleTypeOrder, StyleTypeDescription, Sort, ReportTechPackFolderName
	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08320', GetDate())
GO
