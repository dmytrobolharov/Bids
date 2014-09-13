IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSKU_Header_SEL]'))
DROP VIEW [dbo].[vwx_StyleSKU_Header_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleSKU_Header_SEL]
AS
SELECT     wfi.WorkFlowItemID, ski.StyleSKUItemID, wfi.WorkFlowItemName, skt.TemplateName, wfi2.WorkFlowItemName AS BOMName, ws.WorkflowStatus, 
                      SUBSTRING(ISNULL(', ' + sbdt1.DimTypeName, '') + ISNULL(', ' + sbdt2.DimTypeName, '') + ISNULL(', ' + sbdt3.DimTypeName, ''), 2, 1000) AS Dimensions
FROM         dbo.pWorkFlowItem AS wfi INNER JOIN
                      dbo.pStyleSKUItem AS ski ON wfi.WorkFlowItemID = ski.WorkflowItemID INNER JOIN
                      dbo.pStyleSKUTemplate AS skt ON ski.StyleSKUTemplateID = skt.StyleSKUTemplateID INNER JOIN
                      dbo.pStyleBOMDimension AS sbd ON ski.StyleBOMDimensionID = sbd.StyleBOMDimensionID INNER JOIN
                      dbo.pWorkFlowItem AS wfi2 ON sbd.WorkFlowItemID = wfi2.WorkFlowItemID INNER JOIN
                      dbo.pWorkflowStatus AS ws ON wfi.WorkStatus = ws.WorkflowStatusID LEFT OUTER JOIN
                      dbo.pStyleBOMDimType AS sbdt1 ON ski.ItemDim1TypeID = sbdt1.DimTypeID LEFT OUTER JOIN
                      dbo.pStyleBOMDimType AS sbdt2 ON ski.ItemDim2TypeID = sbdt2.DimTypeID LEFT OUTER JOIN
                      dbo.pStyleBOMDimType AS sbdt3 ON ski.ItemDim3TypeID = sbdt3.DimTypeID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07003', GetDate())
GO
