/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowScheduleAccess_SELECT]    Script Date: 06/17/2014 16:16:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowScheduleAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowScheduleAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowScheduleAccess_SELECT]    Script Date: 06/17/2014 16:16:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowScheduleAccess_SELECT]
(@StyleID uniqueidentifier,
@StyleSet nvarchar(10),
@StyleColorID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@TeamId uniqueidentifier 
)
AS 

SELECT
	pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleWorkflowID, 
	pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.StyleID, 
	pSampleRequestWorkflow.StyleColorID, pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.Status, 
	pSampleRequestWorkflow.Submit, pSampleRequestWorkflow.TechPackID, pSampleRequestWorkflow.StartDate, 
	pSampleRequestWorkflow.DueDate, pSampleRequestWorkflow.EndDate, pSampleWorkflow.SampleWorkflow, 
	pSampleWorkflow.SampleWorkflowSort, pSampleWorkflow.GroupName, pSampleRequestWorkflow.AssignedTo, 
	pSampleRequestWorkflow.SubmitDays, pSampleRequestWorkflow.ResubmitDays
FROM  pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
	pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
	pStyleHeader ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID INNER JOIN 
	fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access 
	ON access.ProductTypeId = pSampleWorkflow.SampleWorkflowID AND access.ProductTypeID = pStyleHeader.StyleType 
WHERE (pSampleRequestWorkflow.StyleID = @StyleID) AND (pSampleRequestWorkflow.StyleSet = @StyleSet) 
AND (pSampleRequestWorkflow.StyleColorID = @StyleColorID) AND (pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID)
AND (access.PermissionView = 1 OR access.PermissionRoleId = 3) 
ORDER BY pSampleWorkflow.SampleWorkflowSort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08033', GetDate())
GO
