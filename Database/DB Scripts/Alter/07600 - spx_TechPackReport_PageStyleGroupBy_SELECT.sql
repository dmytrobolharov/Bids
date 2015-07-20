IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]
	@TechPackFolderId [uniqueidentifier]
WITH EXECUTE AS CALLER
AS

SELECT 
	CASE WHEN WorkFlowItemLinkedID IS NOT NULL THEN StyleHeaderID ELSE rReportStylePageItemTemp.StyleID END AS StyleID,  --replace StyleID for linked workflowitem
		SeasonYearID, TechPackFinal, TechPackName  
	FROM rReportStylePageItemTemp
		LEFT JOIN pWorkFlowItemLinked ON rReportStylePageItemTemp.StyleHeaderID = pWorkFlowItemLinked.StyleID AND rReportStylePageItemTemp.WorkflowItemID = pWorkFlowItemLinked.WorkFlowItemID
	WHERE ReportTechpackID = @TechPackFolderId
	GROUP BY CASE WHEN WorkFlowItemLinkedID IS NOT NULL THEN StyleHeaderID ELSE rReportStylePageItemTemp.StyleID END, 
		SeasonYearID, TechPackFinal, TechPackName 

/*
SELECT StyleID, SeasonYearID, TechPackFinal, TechPackName  FROM rReportStylePageItemTemp
	WHERE ReportTechpackID = @TechPackFolderId 
	GROUP BY StyleID, SeasonYearID, TechPackFinal, TechPackName 
*/

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07600', GetDate())
GO
