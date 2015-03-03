IF OBJECT_ID(N'[dbo].[spx_StyleWorkflow_COUNT_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleWorkflow_COUNT_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflow_COUNT_SELECT] ( 
	@StyleID AS UNIQUEIDENTIFIER,
	@WorkFlowID As UNIQUEIDENTIFIER
)
AS 

BEGIN
	SELECT COUNT(*) FROM pStyleWorkFlow WHERE StyleID = @StyleID AND WorkflowID = @WorkFlowID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09219', GetDate())
GO