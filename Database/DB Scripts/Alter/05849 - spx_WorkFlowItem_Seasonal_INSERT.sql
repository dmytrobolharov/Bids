/****** Object:  StoredProcedure [dbo].[spx_WorkFlowItem_INSERT]    Script Date: 06/12/2013 10:47:28 ******/
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
	@CreatedDate DATETIME)
AS 

-- for seasonal workflows insert workflow items for every style season year
if (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkflowID) = 1
begin

	declare @StyleSeasonYears TABLE(
		ROW INT IDENTITY(1, 1),
		StyleSeasonYearID UNIQUEIDENTIFIER)
	INSERT INTO @StyleSeasonYears(StyleSeasonYearID)
	SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID
	
	declare @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @StyleSeasonYears),
			@MasterID UNIQUEIDENTIFIER = NEWID();
			
	while @ROW <= @TOTAL
	begin
		declare @NewWorkflowItemID UNIQUEIDENTIFIER = NEWID(),
				@StyleSeasonYearID UNIQUEIDENTIFIER = (SELECT StyleSeasonYearID FROM @StyleSeasonYears WHERE ROW = @ROW)
		
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
		
		set @ROW = @ROW + 1
	end
	
end
else -- for non-seasonal workflows - call the original procedure
	exec spx_WorkFlowItem_INSERT
		@WorkFlowItemId  = @WorkFlowItemId,
		@WorkflowID = @WorkflowID,
		@WorkflowItemTypeId = @WorkflowItemTypeId,
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@WorkFlowItemName = @WorkFlowItemName,
		@CreatedBy = @CreatedBy,
		@CreatedDate = @CreatedDate

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05849', GetDate())
GO
