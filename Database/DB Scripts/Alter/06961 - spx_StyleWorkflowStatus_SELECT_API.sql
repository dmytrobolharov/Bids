/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_SELECT_API]    Script Date: 01/20/2014 14:24:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowStatus_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowStatus_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_SELECT_API]    Script Date: 01/20/2014 14:24:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_StyleWorkflowStatus_SELECT_API](
	@StyleWorkflowID UNIQUEIDENTIFIER
	
)
AS

SELECT wi.WorkFlowID, pWorkflow.Workflow as Name,ws.WorkflowStatus, ws.WorkflowStatusImage, Users.FirstName +' '+Users.LastName as UserName, WorkDue,stt.IsSilhouette from pStyleWorkflow wi
INNER JOIN pWorkflow on pWorkflow.WorkflowID = wi.WorkflowID
LEFT JOIN Users on Users.UserId = wi.WorkAssignedTo
INNER JOIN pWorkflowStatus ws on ws.WorkflowStatusID = wi.WorkStatus
INNER JOIN pStyleHeader sh on sh.StyleID = wi.StyleID
INNER JOIN pStyleType st on st.StyleTypeID = sh.StyleType
INNER JOIN pStyleTypeTemplate stt on stt.StyleTypeTemplateID = st.StyleTypeTemplateID
WHERE wi.StyleWorkflowID=@StyleWorkflowID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06961', GetDate())
GO