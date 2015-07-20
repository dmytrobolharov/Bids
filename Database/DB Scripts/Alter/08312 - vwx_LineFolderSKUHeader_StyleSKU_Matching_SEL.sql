IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderSKUHeader_StyleSKU_Matching_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderSKUHeader_StyleSKU_Matching_SEL]
GO

CREATE VIEW [dbo].[vwx_LineFolderSKUHeader_StyleSKU_Matching_SEL]
AS
SELECT DISTINCT 
  ssh.StyleSKUItemID, ssh.WorkflowItemID, ssh.StyleSKUTemplateID, ssh.StyleBOMDimensionID, ssh.ItemDim1TypeID, ssh.ItemDim2TypeID, ssh.ItemDim3TypeID, 
  ssh.PlanningID, lfsh.LineFolderSKUHeaderID, wfi.WorkFlowItemName, wfi.StyleID, ssh.LineFolderSKUHeaderID AS StyleSKUHeaderID
FROM dbo.pStyleSKUItem AS ssh 
	INNER JOIN dbo.pWorkFlowItem AS wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID 
	INNER JOIN dbo.pStyleSeasonYear AS ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN dbo.pLineFolderSKUHeaderDimType AS lfshdt
		INNER JOIN pLineFolderSKUHeader lfsh 
		INNER JOIN pLineFolder lf ON lfsh.LineFolderID = lf.LineFolderID 
			ON lfshdt.LineFolderSKUHeaderID = lfsh.LineFolderSKUHeaderID 
			ON lfshdt.DimTypeID IN (ssh.ItemDim1TypeID, ssh.ItemDim2TypeID, ssh.ItemDim3TypeID) 
			AND (ssh.LineFolderSKUHeaderID = lfsh.LineFolderSKUHeaderID 
				OR (ssh.LineFolderSKUHeaderID IS NULL AND ssh.PlanningSKUHeaderID IS NULL))
			AND ssh.StyleSKUTemplateID = lfsh.StyleSKUTemplateID 
			AND ssy.SeasonYearID = lf.SeasonYearID





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08312', GetDate())
GO
