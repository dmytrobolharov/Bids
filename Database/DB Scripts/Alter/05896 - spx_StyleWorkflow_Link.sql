IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_Link]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_Link]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflow_Link]
(
	@WorkFlowId UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @SourceStyleID UNIQUEIDENTIFIER
	, @StyleSet INT
)
AS
BEGIN
	DECLARE @StyleWorkflowID UNIQUEIDENTIFIER
	SELECT @StyleWorkflowID = StyleWorkflowID FROM pStyleWorkflow WHERE StyleID = @SourceStyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkFlowId

	IF NOT EXISTS (SELECT * FROM pWorkFlowItemLinked WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkFlowItemID = @StyleWorkflowID)
	BEGIN
		INSERT INTO pWorkFlowItemLinked (WorkFlowItemID, StyleID, StyleSet)
		VALUES (@StyleWorkflowID, @StyleID, @StyleSet)
	END	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05896', GetDate())
GO
