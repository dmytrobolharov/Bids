IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningSKUHeader_StyleSKU_Matching_SEL]'))
DROP VIEW [dbo].[vwx_PlanningSKUHeader_StyleSKU_Matching_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningSKUHeader_StyleSKU_Matching_SEL]
AS
SELECT DISTINCT 
  ssh.StyleSKUItemID, ssh.WorkflowItemID, ssh.StyleSKUTemplateID, ssh.StyleBOMDimensionID, ssh.ItemDim1TypeID, ssh.ItemDim2TypeID, ssh.ItemDim3TypeID, 
  ssh.PlanningID, ssh.LineFolderSKUHeaderID, wfi.WorkFlowItemName, psh.PlanningSKUHeaderID, wfi.StyleID
FROM dbo.pStyleSKUItem AS ssh 
	INNER JOIN dbo.pWorkFlowItem AS wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID 
	INNER JOIN dbo.pStyleSeasonYear AS ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN dbo.pPlanningSKUHeaderDimType AS pshdt
		INNER JOIN pPlanningSKUHeader psh ON pshdt.PlanningSKUHeaderID = psh.PlanningSKUHeaderID ON pshdt.DimTypeID IN (ssh.ItemDim1TypeID, ssh.ItemDim2TypeID, ssh.ItemDim3TypeID) 
			AND (ssh.PlanningSKUHeaderID = psh.PlanningSKUHeaderID OR ssh.PlanningSKUHeaderID IS NULL)
			AND ssh.StyleSKUTemplateID = psh.StyleSKUTemplateID 
			AND ssy.SeasonYearID = psh.SeasonYearID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07987', GetDate())
GO
