IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItem_Seasonal_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItem_Seasonal_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_WorkFlowItem_Seasonal_INSERT](
	@WorkFlowItemId UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@WorkflowItemTypeId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkFlowItemName NVARCHAR(100),
	@CreatedBy NVARCHAR(100),
	@CreatedDate DATETIME,
	@SeasonYearID UNIQUEIDENTIFIER = NULL,
	@UpdateSQL NVARCHAR(MAX) = '')
AS 

-- for seasonal workflows insert workflow items for every style season year
if (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkflowID) = 1
begin

	declare @StyleSeasonYears TABLE(
		ROW INT IDENTITY(1, 1),
		SeasonYearID UNIQUEIDENTIFIER,
		StyleSeasonYearID UNIQUEIDENTIFIER)
	INSERT INTO @StyleSeasonYears(StyleSeasonYearID, SeasonYearID)
	SELECT StyleSeasonYearID, SeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID
	
	declare @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @StyleSeasonYears),
			@MasterID UNIQUEIDENTIFIER = NEWID();
			
	while @ROW <= @TOTAL
	begin
		declare @NewWorkflowItemID UNIQUEIDENTIFIER = NEWID(),
				@CurrentSeasonYearID UNIQUEIDENTIFIER,
				@StyleSeasonYearID UNIQUEIDENTIFIER
				
		SELECT @StyleSeasonYearID = StyleSeasonYearID, @CurrentSeasonYearID = SeasonYearID FROM @StyleSeasonYears WHERE ROW = @ROW
		if @CurrentSeasonYearID = @SeasonYearID SET @NewWorkflowItemID = @WorkFlowItemId
		
		exec spx_WorkFlowItem_INSERT
			@WorkFlowItemId  = @NewWorkflowItemID,
			@WorkflowID = @WorkflowID,
			@WorkflowItemTypeId = @WorkflowItemTypeId,
			@StyleID = @StyleID,
			@StyleSet = @StyleSet,
			@WorkFlowItemName = @WorkFlowItemName,
			@CreatedBy = @CreatedBy,
			@CreatedDate = @CreatedDate,
			@StyleSeasonYearID = @StyleSeasonYearID
			
		UPDATE pWorkFlowItem SET WorkflowItemMasterID = @MasterID
		WHERE WorkFlowItemID = @NewWorkflowItemID
		
		exec spx_WorkflowItem_Logic_UPDATE @WorkflowItemID = @NewWorkflowItemID, @UpdateSQL = @UpdateSQL
		
		set @ROW = @ROW + 1
	end
	
end
else -- for non-seasonal workflows - call the original procedure
begin
	exec spx_WorkFlowItem_INSERT
		@WorkFlowItemId  = @WorkFlowItemId,
		@WorkflowID = @WorkflowID,
		@WorkflowItemTypeId = @WorkflowItemTypeId,
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@WorkFlowItemName = @WorkFlowItemName,
		@CreatedBy = @CreatedBy,
		@CreatedDate = @CreatedDate
		
	exec spx_WorkflowItem_Logic_UPDATE @WorkflowItemID = @NewWorkflowItemID, @UpdateSQL = @UpdateSQL
end


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07007', GetDate())
GO
