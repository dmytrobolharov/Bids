/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowItemStatus_SELECT_API]    Script Date: 01/17/2014 14:24:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowItemStatus_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowItemStatus_SELECT_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowItemStatus_SELECT_API]    Script Date: 01/17/2014 14:24:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleWorkflowItemStatus_SELECT_API](
	@WorkflowItemID UNIQUEIDENTIFIER
	
)
AS

SELECT wi.workflowID, wi.WorkFlowItemID, wi.WorkFlowItemName as Name, ws.WorkflowStatus, ws.WorkflowStatusImage, Users.FirstName +' '+Users.LastName as UserName, WorkDue from pWorkflowItem wi
LEFT JOIN Users on Users.UserId = wi.WorkAssignedTo
INNER JOIN pWorkflowStatus ws on ws.WorkflowStatusID = wi.WorkStatus
WHERE wi.WorkFlowItemID=@WorkflowItemID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06948', GetDate())
GO