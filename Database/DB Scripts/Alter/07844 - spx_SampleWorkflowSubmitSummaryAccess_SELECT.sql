/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]    Script Date: 06/03/2014 15:29:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitSummaryAccess_SELECT]    Script Date: 06/03/2014 15:29:30 ******/
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
	SELECT SampleWorkflowID FROM  pSampleRequestWorkflow WITH (NOLOCK) 
	INNER JOIN fnx_Permissions_GetStringProductTypePermissions(@TeamID, 5) access 
	ON access.ProductTypeId = pSampleWorkflow.SampleWorkflowID
	WHERE SampleRequestTradeID =  @SampleRequestTradeID
	AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
)
ORDER BY pSampleWorkflow.SampleWorkflowSort

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07844', GetDate())
GO