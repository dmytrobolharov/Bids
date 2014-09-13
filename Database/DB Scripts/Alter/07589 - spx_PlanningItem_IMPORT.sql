IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_IMPORT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_IMPORT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_IMPORT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@PlanningItemID UNIQUEIDENTIFIER,
	@NewPlanningItemID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @StyleID UNIQUEIDENTIFIER,
			@StyleBOMDimensionID UNIQUEIDENTIFIER,
			@StyleSeasonYearID UNIQUEIDENTIFIER
			
	SELECT @StyleID = StyleID, @StyleBOMDimensionID = StyleBOMDimensionID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

	-- carry over style
	IF @StyleSeasonYearID IS NULL
	BEGIN
		DECLARE @Sort INT = (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID)
		EXEC spx_StyleSeasonYearTrans_INSERT @StyleID, @SeasonYearID, @CUser, @CDate, 
											 NULL, NULL, NULL, @Sort
											 
		SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
	END

	-- Get the copy of corresponding BOM from new season year
	SELECT @StyleBOMDimensionID = msbd.StyleBOMDimensionID 
	FROM pStyleBOMDimension sbd
	INNER JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
	INNER JOIN pWorkFlowItem mwfi ON wfi.WorkflowItemMasterID = mwfi.WorkflowItemMasterID	
	INNER JOIN pStyleBOMDimension msbd ON mwfi.WorkFlowItemID = msbd.WorkFlowItemID
	WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID AND mwfi.StyleSeasonYearID = @StyleSeasonYearID

	INSERT INTO pPlanningItem (PlanningItemID, PlanningID, StyleID, StyleSeasonYearID, StyleBOMDimensionID, CUser, CDate, MUser, MDate) 
	VALUES (@NewPlanningItemID, @PlanningID, @StyleID, @StyleSeasonYearID, @StyleBOMDimensionID, @CUser, @CDate, @CUser, @CDate)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07589', GetDate())
GO
