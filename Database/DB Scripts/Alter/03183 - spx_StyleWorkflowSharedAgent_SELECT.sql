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
    (SELECT '70000000-0000-0000-0000-000000000001' AS MAP, 'Style Header' AS MapDetail, '99' AS WorkSort, '70000000-0000-0000-0000-000000000001' AS WorkflowID	)
    UNION
   ( SELECT Mapping.Map, Mapping.MapDetail, pStyleWorkflow.WorkSort, dbo.pStyleWorkflow.WorkflowID	
	FROM  pStyleWorkflow WITH (NOLOCK) INNER JOIN
		Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map
	WHERE     (pStyleWorkflow.StyleID = @StyleID) AND 
	(MAP IN (SELECT WorkflowId FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)) 
	AND pStyleWorkflow.StyleSet = 1)
	ORDER BY WorkSort, WorkflowID	
 END
ELSE
BEGIN
  SELECT Mapping.Map, Mapping.MapDetail
	FROM  pStyleWorkflow WITH (NOLOCK) INNER JOIN
		Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map
	WHERE     (pStyleWorkflow.StyleID = @StyleID) AND 
	(MAP IN (SELECT WorkflowId FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)) 
	AND pStyleWorkflow.StyleSet = 1
	ORDER BY pStyleWorkflow.WorkSort, dbo.pStyleWorkflow.WorkflowID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03183', GetDate())

GO





