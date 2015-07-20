/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]    Script Date: 06/17/2014 16:25:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]    Script Date: 06/17/2014 16:25:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT] (
@SampleRequestTradeID uniqueidentifier, 
@TeamID uniqueidentifier 
)
AS 

SELECT SampleWorkflowID, GroupName, GroupID, SampleWorkflow
FROM  pSampleWorkflow WITH (NOLOCK)
WHERE SampleWorkflowID IN 
(
	SELECT sw.SampleWorkflowID FROM  pSampleRequestWorkflow srw
	INNER JOIN pSampleWorkflow sw ON sw.SampleWorkflowID = srw.SampleWorkflowID 
	INNER JOIN pStyleHeader sh ON sh.StyleID = srw.StyleID 
	INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access 
	ON access.WorkflowId = sw.SampleWorkflowGUID AND access.ProductTypeID = sh.StyleType 
	WHERE SampleRequestTradeID =  @SampleRequestTradeID
	AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
)
ORDER BY pSampleWorkflow.SampleWorkflowSort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08034', GetDate())
GO
