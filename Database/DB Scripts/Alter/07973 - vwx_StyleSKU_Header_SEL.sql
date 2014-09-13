IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSKU_Header_SEL]'))
DROP VIEW [dbo].[vwx_StyleSKU_Header_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleSKU_Header_SEL]
AS
SELECT wfi.WorkFlowItemID,
	ski.StyleSKUItemID,
	wfi.WorkFlowItemName,
	skt.TemplateName,
	wfi2.WorkFlowItemName AS BOMName,
	ws.WorkflowStatus,
	ws.WorkflowStatusImage,
	SUBSTRING(ISNULL(', ' + sbdt1.DimTypeName, '') + ISNULL(', ' + sbdt2.DimTypeName, '') + ISNULL(', ' + sbdt3.DimTypeName, ''), 2, 1000) AS Dimensions,
	PlanningName,
	ski.PlanningSKUHeaderID,
	wfi.StyleID,
	ski.ItemDim1TypeID, 
	ski.ItemDim2TypeID, 
	ski.ItemDim3TypeID
FROM dbo.pWorkFlowItem AS wfi
INNER JOIN dbo.pStyleSKUItem AS ski ON wfi.WorkFlowItemID = ski.WorkflowItemID
LEFT JOIN pPlanningSKUHeader psh ON ski.PlanningSKUHeaderID = psh.PlanningSKUHeaderID
LEFT JOIN pPlanning p ON psh.PlanningID = p.PlanningID
INNER JOIN dbo.pStyleSKUTemplate AS skt ON ski.StyleSKUTemplateID = skt.StyleSKUTemplateID
INNER JOIN dbo.pStyleBOMDimension AS sbd ON ski.StyleBOMDimensionID = sbd.StyleBOMDimensionID
INNER JOIN dbo.pWorkFlowItem AS wfi2 ON sbd.WorkFlowItemID = wfi2.WorkFlowItemID
LEFT OUTER JOIN dbo.pWorkflowStatus AS ws ON wfi.WorkStatus = ws.WorkflowStatusID
LEFT OUTER JOIN dbo.pStyleBOMDimType AS sbdt1 ON ski.ItemDim1TypeID = sbdt1.DimTypeID
LEFT OUTER JOIN dbo.pStyleBOMDimType AS sbdt2 ON ski.ItemDim2TypeID = sbdt2.DimTypeID
LEFT OUTER JOIN dbo.pStyleBOMDimType AS sbdt3 ON ski.ItemDim3TypeID = sbdt3.DimTypeID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07973', GetDate())
GO
