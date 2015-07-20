SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_TechPackReport_PageItemtemp_INSERT') 
DROP PROCEDURE spx_TechPackReport_PageItemtemp_INSERT
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_PageItemtemp_INSERT]
(
@ReportTechpackID UNIQUEIDENTIFIER,
@ReportPageID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@TechPackName NVARCHAR(200),
@Sort INT,
@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
@SystemCultureId uniqueidentifier = NULL,
@WorkflowItemID uniqueidentifier = NULL
) 
AS   

INSERT INTO rReportStylePageItemTemp (ReportStylePageItem, ReportPageID, ReportTechPackID, ReportMapID, ReportPageTypeID, 
                                      ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, 
                                      ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, 
                                      ReportSrmOn, StyleID, StyleSet, Sort, TechPackName, StyleColorwaySeasonYearID, 
                                      SystemCultureId, WorkFlowItemID) 
SELECT NEWID() AS ReportStylePageItem, ReportPageID, @ReportTechpackID AS RerportTechPackID, ReportMapID, ReportPageTypeID, 
       ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, 
       ReportPageActive, ReportPageFormat, ReportSrmOn, @StyleID AS StyleID, @StyleSet AS StyleSet, @Sort AS Sort, 
       @TechPackName AS TechPackName, @StyleColorwaySeasonYearID AS StyleColorwaySeasonYearID, @SystemCultureId, @WorkflowItemID
FROM rReportStylePageItem 
WHERE ReportPageID = @ReportPageID
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01712'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01712', GetDate())
	END
GO