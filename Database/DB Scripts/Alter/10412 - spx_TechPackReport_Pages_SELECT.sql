IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_Pages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_Pages_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_Pages_SELECT]
	@TechPackFolderId [uniqueidentifier],
	@StyleId [uniqueidentifier],
	@ReportPageBySet [int]
WITH EXECUTE AS CALLER
AS
SELECT * FROM (
SELECT dbo.rReportTechPackPageItem.ReportTechPackPageID, dbo.rReportTechPackPageItem.ReportTechPackFolderID, dbo.rReportTechPackPageItem.ReportPageTypeID, 
      dbo.rReportTechPackPageItem.ReportTemplateName, dbo.rReportTechPackPageItem.ReportPageName, dbo.rReportTechPackPageItem.ReportPageDescription, 
      dbo.rReportTechPackPageItem.ReportServerType, dbo.rReportTechPackPageItem.ReportFormName, dbo.rReportTechPackPageItem.ReportPageURL, 
      dbo.rReportTechPackPageItem.ReportPKIField, dbo.rReportTechPackPageItem.ReportPageActive, 
      dbo.rReportTechPackPageItem.ReportPageFormat, dbo.rReportTechPackPageItem.ReportPageSort, dbo.rReportTechPackPageItem.ReportMapID, 
      dbo.pWorkFlowItem.StyleID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pWorkFlowItem.WorkFlowItemID, dbo.pWorkflowItemType.WorkflowItemTypeId,
      dbo.pWorkFlowItem.WorkflowID
FROM  dbo.pWorkFlowItem INNER JOIN
      dbo.pWorkflowItemType ON dbo.pWorkFlowItem.WorkflowItemTypeId = dbo.pWorkflowItemType.WorkflowItemTypeId RIGHT OUTER JOIN
      dbo.rReportTechPackPageItem ON dbo.pWorkflowItemType.MapId = dbo.rReportTechPackPageItem.ReportMapID
WHERE (dbo.pWorkFlowItem.StyleID = @StyleID) 
		AND (dbo.rReportTechPackPageItem.ReportTechPackFolderID = @TechPackFolderId)
		AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet 		
UNION 
/* select linked workflowitems */
SELECT dbo.rReportTechPackPageItem.ReportTechPackPageID, dbo.rReportTechPackPageItem.ReportTechPackFolderID, dbo.rReportTechPackPageItem.ReportPageTypeID, 
      dbo.rReportTechPackPageItem.ReportTemplateName, dbo.rReportTechPackPageItem.ReportPageName, dbo.rReportTechPackPageItem.ReportPageDescription, 
      dbo.rReportTechPackPageItem.ReportServerType, dbo.rReportTechPackPageItem.ReportFormName, dbo.rReportTechPackPageItem.ReportPageURL, 
      dbo.rReportTechPackPageItem.ReportPKIField, dbo.rReportTechPackPageItem.ReportPageActive, 
      dbo.rReportTechPackPageItem.ReportPageFormat, dbo.rReportTechPackPageItem.ReportPageSort, dbo.rReportTechPackPageItem.ReportMapID, 
      dbo.pWorkFlowItem.StyleID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pWorkFlowItem.WorkFlowItemID, dbo.pWorkflowItemType.WorkflowItemTypeId,
      dbo.pWorkFlowItem.WorkflowID
FROM  dbo.pWorkFlowItem INNER JOIN
      dbo.pWorkFlowItemLinked ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pWorkFlowItemLinked.WorkFlowItemID INNER JOIN
      dbo.pWorkflowItemType ON dbo.pWorkFlowItem.WorkflowItemTypeId = dbo.pWorkflowItemType.WorkflowItemTypeId RIGHT OUTER JOIN
      dbo.rReportTechPackPageItem ON dbo.pWorkflowItemType.MapId = dbo.rReportTechPackPageItem.ReportMapID
WHERE (dbo.pWorkFlowItemLinked.StyleID = @StyleID) 
		AND (dbo.rReportTechPackPageItem.ReportTechPackFolderID = @TechPackFolderId)
		AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet 		
UNION      
SELECT ReportTechPackPageID, ReportTechPackFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, 
     ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportPageSort, ReportMapID,
     NULL AS StyleID, NULL AS WorkflowItemName, ReportTechPackPageID AS WorkflowItemID, NULL AS WorkflowItemTypeID,
     ReportTechPackPageID AS WorkflowItemID
FROM  dbo.rReportTechPackPageItem
WHERE (ReportTechPackFolderID = @TechPackFolderId) AND ReportMapID IS NULL
		AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet
) tmpTable 
ORDER BY ReportPageSort


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10412', GetDate())
GO
