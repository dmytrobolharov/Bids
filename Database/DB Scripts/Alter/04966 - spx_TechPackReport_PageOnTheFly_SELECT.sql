IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_PageOnTheFly_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_PageOnTheFly_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TechPackReport_PageOnTheFly_SELECT]
	@TechPackFolderId [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
SELECT ReportStylePageItemTempID, ReportStylePageItemID, ReportPageID, ReportTechpackID, ReportMapID, ReportPageTypeID, WorkflowItemID, WorkflowID, 
      ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, 
      ReportPageFormat, ReportSrmOn, SeasonYearID, StyleDevelopmentID, StyleHeaderID, StyleID, StyleSet, Sort, TechPackName, TechPackFinal, Variation, StyleColorwaySeasonYearID
FROM rReportStylePageItemTemp
WHERE ReportTechpackID = @TechPackFolderId 
ORDER BY CAST(Sort AS INT), StyleSet
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04966', GetDate())
GO
