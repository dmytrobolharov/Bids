IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_BOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_BOM_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_BOM_SELECT]
	@PlanningItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT pi.StyleBOMDimensionID, V.*, sbdt.DimTypeName FROM pPlanningItem pi
	INNER JOIN pStyleBOMDimension sbd ON pi.StyleBOMDimensionID = sbd.StyleBOMDimensionID
	CROSS APPLY (VALUES (sbd.ItemDim1TypeId, 1),
						(sbd.ItemDim2TypeId, 2),
						(sbd.ItemDim3TypeId, 3))
					  V (DimTypeID, DimNo)
	INNER JOIN pStyleBOMDimType sbdt ON v.DimTypeID = sbdt.DimTypeID
	WHERE pi.PlanningItemID = @PlanningItemID
	ORDER BY V.DimNo
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07556', GetDate())
GO
