IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUPlan_DimTypes_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUPlan_DimTypes_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUPlan_DimTypes_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT DISTINCT sbdt.DimTypeID, sbdt.DimTypeName
	FROM pPlanningItem pi
	INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleBOMDimension sbd ON pi.StyleBOMDimensionID = sbd.StyleBOMDimensionID
	CROSS APPLY (VALUES (sbd.ItemDim1TypeId),
						(sbd.ItemDim2TypeId),
						(sbd.ItemDim3TypeId)) 
					   V(ItemDimTypeID)
	INNER JOIN pStyleBOMDimType sbdt ON V.ItemDimTypeID = sbdt.DimTypeID
	WHERE pi.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07190', GetDate())
GO
