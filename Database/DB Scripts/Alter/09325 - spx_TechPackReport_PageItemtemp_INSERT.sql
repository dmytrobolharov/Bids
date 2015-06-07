IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_PageItemtemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_PageItemtemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_PageItemtemp_INSERT]
(	
	@ReportTechpackID UNIQUEIDENTIFIER
	, @ReportPageID UNIQUEIDENTIFIER
	, @WorkflowItemID UNIQUEIDENTIFIER
	, @WorkflowID UNIQUEIDENTIFIER = NULL
	, @SeasonYearID UNIQUEIDENTIFIER = NULL
	, @StyleDevelopmentID UNIQUEIDENTIFIER = NULL
	, @StyleHeaderID UNIQUEIDENTIFIER = NULL
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @TechPackName NVARCHAR(200)
	, @TechPackFinal INT = NULL
	, @Sort INT
	, @StyleColorwaySeasonYearID UNIQUEIDENTIFIER
	, @IsTechPackOnTheFly INT = NULL
	, @SystemCultureId UNIQUEIDENTIFIER = NULL
	, @ReportTechpackFolderID UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	IF @IsTechPackOnTheFly = 1
		BEGIN
			INSERT INTO rReportStylePageItemTemp  (ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,
			    ReportTemplateName, ReportPageName , ReportPageDescription,
			    ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,
			    StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID, SystemCultureId)
			SELECT NEWID() AS ReportStylePageItemID, ReportPageID ,  @ReportTechpackID ,  ReportMapID ,  ReportPageTypeID ,
			    ReportTemplateName, ReportPageName , ReportPageDescription,
			    ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, @SeasonYearID, @StyleHeaderID,
			    @StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
			    @WorkflowItemID, @WorkflowID, @SystemCultureId
			FROM rReportStylePageItem WHERE ReportPageID= @ReportPageID
		END
	ELSE
		BEGIN
			INSERT INTO rReportStylePageItemTemp  (ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,
			    ReportTemplateName, ReportPageName , ReportPageDescription,
			    ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,
			    StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID, SystemCultureId)
			SELECT NEWID() AS ReportStylePageItemID, ReportTechPackPageID ,  @ReportTechpackID,  ReportMapID ,  ReportPageTypeID ,
				ReportTemplateName, ReportPageName , ReportPageDescription,
				ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, 0, @SeasonYearID, @StyleHeaderID,
				@StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
				@WorkflowItemID, @WorkflowID, @SystemCultureId
			FROM rReportTechPackPageItem WHERE ReportTechPackPageID = @ReportPageID AND ReportTechPackFolderID = @ReportTechpackFolderID
		END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09325', GetDate())
GO

