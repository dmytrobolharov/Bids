IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_Drop_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_Drop_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_PlanningColor_Drop_UPDATE] (
	@PlanningColorID UNIQUEIDENTIFIER
	, @DropStatus INT
	, @DropBy NVARCHAR(200)
	, @DropDate DATETIME
	)
AS
BEGIN
	UPDATE pPlanningColor SET
	PlanningColorDrop = @DropStatus
	, PlanningColorDropDate = @DropDate
	, PlanningColorDropUser = @DropBy
	WHERE PlanningColorID = @PlanningColorID
	
	UPDATE sb SET
	ItemDim1Active = 1 - @DropStatus, sb.ItemDim2Active = 1 - @DropStatus, sb.ItemDim3Active = 1 - @DropStatus
	FROM pStyleBOMDimensionItem sb
	INNER JOIN pPlanningItem pli ON sb.StyleID = pli.StyleID
	INNER JOIN pWorkFlowItem wfi ON sb.WorkFlowItemID = wfi.WorkFlowItemID
		AND pli.StyleSeasonYearID = wfi.StyleSeasonYearID
	INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (ItemDim1Id, ItemDim2Id, ItemDim3Id)
	INNER JOIN pPlanningColor pc ON pli.PlanningID = pc.PlanningID
	WHERE pc.ColorPaletteID = sc.ColorPaletteID AND pc.PlanningColorID = @PlanningColorID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07323', GetDate())
GO
