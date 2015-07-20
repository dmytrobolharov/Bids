IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowSharedAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowSharedAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowSharedAgent_SELECT]
(@StyleID uniqueidentifier,
@TradePartnerID uniqueidentifier)
AS 

DECLARE @COUNTWF INTEGER
SELECT @COUNTWF=COUNT(*) FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId AND WorkflowID='70000000-0000-0000-0000-000000000001'

IF @COUNTWF > 0 
 BEGIN
	;WITH sw AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY WorkflowID ORDER BY WorkSort) AS RowNo
		FROM pStyleWorkflow 
		WHERE StyleID = @StyleID AND StyleSet = 1
	) 
    SELECT '70000000-0000-0000-0000-000000000001' AS MAP, 'Style Header' AS MapDetail, '00' AS WorkSort, '70000000-0000-0000-0000-000000000001' AS WorkflowID
    UNION
	SELECT Mapping.Map, Mapping.MapDetail, pStyleWorkflow.WorkSort, pStyleWorkflow.WorkflowID
	FROM  sw pStyleWorkflow WITH (NOLOCK) INNER JOIN
		Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map
	WHERE pStyleWorkflow.RowNo = 1
		AND MAP IN (
			SELECT WorkflowId FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)
		AND Map <> '70000000-0000-0000-0000-000000000001'	
	ORDER BY WorkSort, WorkflowID	
 END
ELSE
BEGIN
	;WITH sw AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY WorkflowID ORDER BY WorkSort) AS RowNo
		FROM pStyleWorkflow 
		WHERE StyleID = @StyleID AND StyleSet = 1
	) 
	SELECT Mapping.Map, Mapping.MapDetail
	FROM sw pStyleWorkflow WITH (NOLOCK) 
	INNER JOIN Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map
	WHERE pStyleWorkflow.RowNo = 1
		AND MAP IN (
			SELECT WorkflowId FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)		
	ORDER BY pStyleWorkflow.WorkSort, pStyleWorkflow.WorkflowID
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06726', GetDate())
GO
