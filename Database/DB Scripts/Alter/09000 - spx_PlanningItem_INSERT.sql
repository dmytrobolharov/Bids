IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_PlanningItem_INSERT]    Script Date: 08/26/2014 12:18:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_PlanningItem_INSERT](
	@PlanningItemID uniqueidentifier,
	@PlanningID uniqueidentifier,
	@StyleID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@CreatedDate datetime,
	@CreatedBy nvarchar(200),
	@StyleBOMDimensionID UNIQUEIDENTIFIER = NULL,
	@PlanningItemDrop nvarchar(5) = NULL
)

AS 

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER		
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

IF @StyleSeasonYearID IS NULL
BEGIN
	DECLARE @Sort INT = (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID)
	EXEC spx_StyleSeasonYearTrans_INSERT @StyleID, @SeasonYearID, @CreatedBy, @CreatedDate, 
										 NULL, NULL, NULL, @Sort
										 
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
	
	IF @StyleBOMDimensionID IS NOT NULL
	BEGIN
		SELECT @StyleBOMDimensionID = sbd2.StyleBOMDimensionID 
		FROM pStyleBOMDimension sbd1
			INNER JOIN pWorkFlowItem wfi1 ON sbd1.WorkFlowItemID = wfi1.WorkFlowItemID
			INNER JOIN pWorkFlowItem wfi2 ON wfi1.WorkflowItemMasterID = wfi2.WorkflowItemMasterID AND wfi2.StyleSeasonYearID = @StyleSeasonYearID
			INNER JOIN pStyleBOMDimension sbd2 ON wfi2.WorkFlowItemID = sbd2.WorkFlowItemID
		WHERE sbd1.StyleBOMDimensionID = @StyleBOMDimensionID
	END
										 
END



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
	
IF @PlanningItemDrop IS NULL
BEGIN
	INSERT INTO pPlanningItem (PlanningItemID, PlanningID, StyleID, StyleSeasonYearID, StyleBOMDimensionID, CUser, CDate, MUser, MDate) 
	VALUES (@PlanningItemID, @PlanningID, @StyleID, @StyleSeasonYearID, @StyleBOMDimensionID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
END
ELSE
BEGIN
	INSERT INTO pPlanningItem (PlanningItemID, PlanningID, StyleID, StyleSeasonYearID, StyleBOMDimensionID, CUser, CDate, MUser, MDate, PlanningItemDrop) 
	VALUES (@PlanningItemID, @PlanningID, @StyleID, @StyleSeasonYearID, @StyleBOMDimensionID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @PlanningItemDrop)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09000', GetDate())
GO