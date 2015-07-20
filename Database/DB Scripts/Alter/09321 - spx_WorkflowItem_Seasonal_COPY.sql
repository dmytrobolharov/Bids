/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Seasonal_COPY]    Script Date: 02/04/2015 16:08:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_Seasonal_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_COPY]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Seasonal_COPY]    Script Date: 02/04/2015 16:08:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_COPY]
	@WorkflowID UNIQUEIDENTIFIER,  
	@WorkFlowItemId UNIQUEIDENTIFIER,  
	@StyleID UNIQUEIDENTIFIER,  
	@CopyStyleID UNIQUEIDENTIFIER,  
	@StyleSet INT,  
	@CopyStyleSet INT,  
	@CUser NVARCHAR(100),  
	@CDate DATETIME	
AS
BEGIN
	
	if (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkflowID) = 1
	begin
		declare @StyleSeasonYears TABLE(
			ROW INT IDENTITY(1, 1),
			StyleSeasonYearID UNIQUEIDENTIFIER
		)
		
		INSERT INTO @StyleSeasonYears(StyleSeasonYearID)
		SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID
		
		declare @MasterID UNIQUEIDENTIFIER = NEWID(),
				@ROW INT = 1,
				@TOTAL INT = (SELECT COUNT(*) FROM @StyleSeasonYears)
				
		-- create a copy of workflow item for each season year in style
		while @ROW <= @TOTAL
		begin
			declare @StyleSeasonYearID UNIQUEIDENTIFIER = (SELECT StyleSeasonYearID FROM @StyleSeasonYears WHERE ROW = @ROW),
					@newWorkflowItemID UNIQUEIDENTIFIER = NEWID()
			
			exec spx_WorkflowItem_COPY
				@WorkflowID = @WorkflowID,  
				@WorkFlowItemId = @WorkFlowItemId,  
				@StyleID = @StyleID,  
				@CopyStyleID = @CopyStyleID,  
				@StyleSet = @StyleSet,  
				@CopyStyleSet = @CopyStyleSet,  
				@CUser = @CUser,  
				@CDate = @CDate,
				@NewWorkFlowItemId = @newWorkflowItemID,
				@StyleSeasonYearID = @StyleSeasonYearID
				
			UPDATE pWorkFlowItem SET WorkflowItemMasterID = @MasterID, StyleSeasonYearID = @StyleSeasonYearID
			WHERE WorkFlowItemID = @newWorkflowItemID
			
			set @ROW = @ROW + 1
		end
	end
	else
		exec spx_WorkflowItem_COPY
			@WorkflowID = @WorkflowID,  
			@WorkFlowItemId = @WorkFlowItemId,  
			@StyleID = @StyleID,  
			@CopyStyleID = @CopyStyleID,  
			@StyleSet = @StyleSet,  
			@CopyStyleSet = @CopyStyleSet,  
			@CUser = @CUser,  
			@CDate = @CDate			
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09321', GetDate())
GO
