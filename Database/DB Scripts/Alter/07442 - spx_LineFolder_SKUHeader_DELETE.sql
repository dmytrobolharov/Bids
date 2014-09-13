IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeader_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeader_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeader_DELETE]
	@LineFolderSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @WorkflowItems AS TABLE(
		ROWID INT IDENTITY(1, 1), 
		WorkflowItemID UNIQUEIDENTIFIER,
		WorkflowID UNIQUEIDENTIFIER,
		StyleID UNIQUEIDENTIFIER,
		StyleSet INT)
		
	INSERT INTO @WorkflowItems(WorkflowItemID, WorkflowID, StyleID, StyleSet)
	SELECT skh.WorkFlowItemID, wfi.WorkflowID, wfi.StyleID, wfi.StyleSet
	FROM pStyleSKUItem skh 
	INNER JOIN pWorkFlowItem wfi ON skh.WorkflowItemID = wfi.WorkFlowItemID
	WHERE LineFolderSKUHeaderID = @LineFolderSKUHeaderID
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @WorkflowItems)
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @WorkflowItemID UNIQUEIDENTIFIER,
				@WorkflowID UNIQUEIDENTIFIER,
				@StyleID UNIQUEIDENTIFIER,
				@StyleSet INT
				
		SELECT @WorkflowItemID = WorkflowItemID,
			@WorkflowID = WorkflowID,
			@StyleID = StyleID,
			@StyleSet = StyleSet
		FROM @WorkflowItems WHERE ROWID = @ROW
		
		EXEC spx_WorkflowItem_Seasonal_DELETE
			@WorkflowID = @WorkflowID,
			@WorkflowItemID = @WorkflowItemID,			
			@StyleID = @StyleID,
			@StyleSet = @StyleSet
	
		SET @ROW = @ROW + 1
	END
	
	EXEC spx_LineFolder_SKUHeader_REMOVE @LineFolderSKUHeaderID = @LineFolderSKUHeaderID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07442', GetDate())
GO
