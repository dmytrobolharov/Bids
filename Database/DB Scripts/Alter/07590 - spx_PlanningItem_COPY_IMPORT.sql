IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_COPY_IMPORT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_COPY_IMPORT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_COPY_IMPORT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@PlanningItemID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @NewPlanningItemID UNIQUEIDENTIFIER = NEWID(),
			@StyleBOMDimensionID UNIQUEIDENTIFIER
	
	-- find BOM that was a copy of original BOM from pPlanningItem
	SELECT @StyleBOMDimensionID = sbd.StyleBOMDimensionID
	FROM pPlanningItem pli
	INNER JOIN pStyleBOMDimension msbd ON pli.StyleBOMDimensionID = msbd.StyleBOMDimensionID
	INNER JOIN pStyleBOMDimension sbd ON msbd.StyleBOMDimensionID = sbd.StyleBOMDimensionCopyMasterID
	WHERE pli.PlanningItemID = @PlanningItemID
		AND sbd.StyleID = @StyleID
	
	exec spx_PlanningItem_INSERT 
		@PlanningItemID = @NewPlanningItemID,
		@PlanningID = @PlanningID,
		@SeasonYearID = @SeasonYearID,
		@StyleID = @StyleID,
		@CreatedDate = @CDate,
		@CreatedBy = @CUser,
		@StyleBOMDimensionID = @StyleBOMDimensionID
		
	

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07590', GetDate())
GO
