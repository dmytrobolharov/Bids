IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_ItemColor_DROP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_ItemColor_DROP]
GO


CREATE PROCEDURE [dbo].[spx_PlanningColor_ItemColor_DROP]
	@PlanningItemID UNIQUEIDENTIFIER,
	@PlanningColorID UNIQUEIDENTIFIER
AS
BEGIN
	
	UPDATE sb SET
		sb.ItemDim1Active = CASE WHEN sc.StyleColorID = ItemDim1Id THEN 0 ELSE sb.ItemDim1Active END, 
		sb.ItemDim2Active = CASE WHEN sc.StyleColorID = ItemDim2Id THEN 0 ELSE sb.ItemDim2Active END, 
		sb.ItemDim3Active = CASE WHEN sc.StyleColorID = ItemDim3Id THEN 0 ELSE sb.ItemDim3Active END
	FROM pPlanningItem pli 
		INNER JOIN pStyleBOMDimensionItem sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionID
		INNER JOIN pPlanningColor pc ON pli.PlanningID = pc.PlanningID
		INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (ItemDim1Id, ItemDim2Id, ItemDim3Id)
	WHERE pc.ColorPaletteID = sc.ColorPaletteID
		AND pc.PlanningColorID = @PlanningColorID
		AND pli.PlanningItemID = @PlanningItemID
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07522', GetDate())
GO
