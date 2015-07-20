/****** Object:  StoredProcedure [dbo].[spx_WorkflowItemFromSilho_Seasonal_COPY]    Script Date: 10/03/2013 14:47:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItemFromSilho_Seasonal_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItemFromSilho_Seasonal_COPY]
GO
/****** Object:  StoredProcedure [dbo].[spx_WorkflowItemFromSilho_Seasonal_COPY]    Script Date: 10/03/2013 14:47:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_WorkflowItemFromSilho_Seasonal_COPY]
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
	DECLARE @StyleSeasonYearID uniqueidentifier	
		
		
		SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID and SeasonYearID in (select  ssy.SeasonYearID from pStyleSeasonYear ssy  inner join pWorkFlowItem wfi on wfi.StyleSeasonYearID= ssy.StyleSeasonYearID WHERE wfi.WorkFlowItemID=@WorkFlowItemId)
		
		declare @MasterID UNIQUEIDENTIFIER = NEWID()
				
		-- create a copy of workflow item for each season year in style
		
		declare @newWorkflowItemID UNIQUEIDENTIFIER = NEWID()
			
			exec spx_WorkflowItem_COPY
				@WorkflowID = @WorkflowID,  
				@WorkFlowItemId = @WorkFlowItemId,  
				@StyleID = @StyleID,  
				@CopyStyleID = @CopyStyleID,  
				@StyleSet = @StyleSet,  
				@CopyStyleSet = @CopyStyleSet,  
				@CUser = @CUser,  
				@CDate = @CDate,
				@NewWorkFlowItemId = @newWorkflowItemID
				
			UPDATE pWorkFlowItem SET WorkflowItemMasterID = @MasterID, StyleSeasonYearID = @StyleSeasonYearID
			WHERE WorkFlowItemID = @newWorkflowItemID
			
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
VALUES ('DB_Version', '0.5.0000', '06423', GetDate())
GO