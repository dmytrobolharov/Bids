/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_SELECT_API]    Script Date: 01/17/2014 14:23:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowStatus_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowStatus_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_SELECT_API]    Script Date: 01/17/2014 14:23:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleWorkflowStatus_SELECT_API](
	@StyleWorkflowID UNIQUEIDENTIFIER
	
)
AS

SELECT wi.WorkFlowID, pWorkflow.Workflow as Name,ws.WorkflowStatus, ws.WorkflowStatusImage, Users.FirstName +' '+Users.LastName as UserName, WorkDue from pStyleWorkflow wi
INNER JOIN pWorkflow on pWorkflow.WorkflowID = wi.WorkflowID
LEFT JOIN Users on Users.UserId = wi.WorkAssignedTo
INNER JOIN pWorkflowStatus ws on ws.WorkflowStatusID = wi.WorkStatus
WHERE wi.StyleWorkflowID=@StyleWorkflowID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06947', GetDate())
GO