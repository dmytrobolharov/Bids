/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Seasonal_DELETE]    Script Date: 02/04/2015 16:08:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_Seasonal_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Seasonal_DELETE]    Script Date: 02/04/2015 16:08:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_DELETE]
	@WorkflowID UNIQUEIDENTIFIER,
	@WorkflowItemID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@SeasonYearID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	
	-- for seasonal workflow items - remove all items that are linked by the same WorkflowItemMasterID
	if (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkFlowId) = 1
	begin
		declare @WorkflowItems TABLE(
			ROW INT IDENTITY(1, 1),
			WorkflowItemID UNIQUEIDENTIFIER
		)
		IF(@WorkflowID='40000000-0000-0000-0000-000000000080')
	begin
		INSERT INTO @WorkflowItems(WorkflowItemID)
		SELECT  @WorkflowItemID 
	end
	else
	begin
		INSERT INTO @WorkflowItems(WorkflowItemID)
		SELECT wfi2.WorkflowItemID FROM pWorkFlowItem wfi1
		INNER JOIN pWorkFlowItem wfi2 ON wfi1.WorkflowItemMasterID = wfi2.WorkflowItemMasterID
		WHERE wfi1.WorkFlowItemID = @WorkflowItemID AND wfi2.WorkflowID = @WorkflowID
	end
		
		
		declare @ROW INT = 1,
				@TOTAL INT = (SELECT COUNT(*) FROM @WorkflowItems)
		while @ROW <= @TOTAL
		begin
			declare @rmWorkflowItemID UNIQUEIDENTIFIER = (SELECT WorkflowItemID FROM @WorkflowItems WHERE ROW = @ROW)
			
			exec spx_WorkflowItem_DELETE 
				@WorkFlowId = @WorkflowID,
				@WorkFlowItemId = @rmWorkflowItemID,
				@StyleId = @StyleID,
				@StyleSet = @StyleSet
			
			set @ROW = @ROW + 1
		end
	end
	else
		exec spx_WorkflowItem_DELETE 
			@WorkFlowId = @WorkflowID,
			@WorkFlowItemId = @WorkflowItemID,
			@StyleId = @StyleID,
			@StyleSet = @StyleSet
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09323', GetDate())
GO