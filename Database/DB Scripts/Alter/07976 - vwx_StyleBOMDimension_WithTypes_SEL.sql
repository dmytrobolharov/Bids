IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleBOMDimension_WithTypes_SEL]'))
DROP VIEW [dbo].[vwx_StyleBOMDimension_WithTypes_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleBOMDimension_WithTypes_SEL]
AS

SELECT sbd.StyleBOMDimensionID, wfi.WorkFlowItemName, wfi.StyleSeasonYearID
FROM dbo.pStyleBOMDimension AS sbd
INNER JOIN dbo.pWorkFlowItem AS wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
WHERE (sbd.ItemDim1TypeId <> '00000000-0000-0000-0000-000000000000')
	OR (sbd.ItemDim2TypeId <> '00000000-0000-0000-0000-000000000000')
	OR (sbd.ItemDim3TypeId <> '00000000-0000-0000-0000-000000000000')


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07976', GetDate())
GO
