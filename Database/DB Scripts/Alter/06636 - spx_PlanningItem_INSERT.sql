IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_INSERT](
	@PlanningItemID uniqueidentifier,
	@PlanningID uniqueidentifier,
	@StyleID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@CreatedDate datetime,
	@CreatedBy nvarchar(200),
	@StyleBOMDimensionID UNIQUEIDENTIFIER = NULL
)

AS 

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER		
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID


-- if there is only one BOM for season year select this bom
IF @StyleBOMDimensionID IS NULL 
	AND (SELECT COUNT(*) FROM pWorkFlowItem wfi
		 INNER JOIN pStyleBOMDimension sbd ON wfi.WorkFlowItemID = sbd.WorkFlowItemID
		 WHERE wfi.StyleSeasonYearID = @StyleSeasonYearID) = 1
BEGIN
	SELECT @StyleBOMDimensionID = sbd.StyleBOMDimensionID FROM pWorkFlowItem wfi
	INNER JOIN pStyleBOMDimension sbd ON wfi.WorkFlowItemID = sbd.WorkFlowItemID
	WHERE wfi.StyleSeasonYearID = @StyleSeasonYearID
END


INSERT INTO pPlanningItem (PlanningItemID, PlanningID, StyleID, StyleSeasonYearID, StyleBOMDimensionID, CUser, CDate, MUser, MDate) 
VALUES (@PlanningItemID, @PlanningID, @StyleID, @StyleSeasonYearID, @StyleBOMDimensionID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06636', GetDate())
GO
