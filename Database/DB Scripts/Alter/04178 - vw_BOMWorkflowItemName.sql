IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_BOMWorkflowItemName]'))
DROP VIEW [dbo].[vw_BOMWorkflowItemName]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_BOMWorkflowItemName]
AS
SELECT     dbo.pWorkFlowItem.WorkFlowItemName, dbo.pWorkFlowItem.StyleID, dbo.pWorkFlowItem.WorkFlowItemID, dbo.pWorkFlowItem.WorkflowID, 
                      dbo.pStyleBOMDimension.StyleBOMDimensionID, dbo.pWorkFlowItem.WorkflowItemTypeId
FROM         dbo.pWorkFlowItem INNER JOIN
                      dbo.pStyleBOMDimension ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pStyleBOMDimension.WorkFlowItemID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04178', GetDate())
GO