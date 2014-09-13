IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_PredefinedTechPack_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_PredefinedTechPack_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Style_PredefinedTechPack_SELECT]
(
	@Active INT
	, @ReportTechPackGroup INT
	, @StyleID UNIQUEIDENTIFIER
)
AS
BEGIN
	DECLARE @DivisionID UNIQUEIDENTIFIER
	DECLARE @StyleTypeID INT
	
	SELECT @DivisionID = DivisionID, @StyleTypeID = StyleType
	FROM pStyleHeader
	WHERE StyleID = @StyleID
	
	SELECT
		rtpf.ReportTechPackFolderID
		, rtpf.ReportTechPackFolderName
		, rtpf.ReportTechPackGroup
		, rtpf.Sort
		, rtpf.Active
	FROM
		rReportTechPackFolder rtpf
		INNER JOIN pControlPredefinedTechPackConfig tpc ON rtpf.ReportTechPackFolderID = tpc.ReportTechPackFolderID
	WHERE
		rtpf.Active = @Active
		AND rtpf.ReportTechPackGroup = @ReportTechPackGroup
		AND tpc.Availible = 1
		AND tpc.DivisionID = @DivisionID
		AND tpc.StyleTypeID = @StyleTypeID
	ORDER BY Sort
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08321', GetDate())
GO
