IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_PredefinedTechPack_Add_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Control_PredefinedTechPack_Add_INSERT]
(
	@ReportTechPackFolderID UNIQUEIDENTIFIER
	, @ReportFormName NVARCHAR(255)
	, @ReportPageSort INT
)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM rReportTechPackPageItem WHERE ReportTechPackFolderID=@ReportTechPackFolderID AND ReportFormName = @ReportFormName)
		INSERT INTO rReportTechPackPageItem
		SELECT TOP 1
			NEWID()
			, @ReportTechPackFolderID
			, ReportPageTypeID
			, ReportTemplateName
			, ReportPageName
			, ReportPageDescription
			, ReportServerType
			, ReportFormName
			, ReportPageURL
			, ReportPKIField
			, ReportPageActive
			, ReportPageFormat
			, 1
			, RIGHT('00' + CAST(@ReportPageSort AS NVARCHAR(3)), 3)
			, CASE WHEN ReportMapID IN ('40000000-0000-0000-0000-000000000050', '40000000-0000-0000-0000-000000000080', '80000000-0000-0000-0000-000000000008', '40000000-0000-0000-0000-000000000018') THEN ReportMapID ELSE NULL END
			, 0
			, ReportMapID
		FROM rReportStylePageItem
		WHERE ReportFormName = @ReportFormName
	ELSE
		UPDATE rReportTechPackPageItem
		SET ReportPageSort = RIGHT('00' + CAST(@ReportPageSort AS NVARCHAR(3)), 3)
		WHERE ReportTechPackFolderID=@ReportTechPackFolderID AND ReportFormName = @ReportFormName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08257', GetDate())
GO                      