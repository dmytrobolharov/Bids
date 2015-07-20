/****** Object:  View [dbo].[vwx_SourcingCommitmentWorkflowItem_TACalendar_SEL]    Script Date: 08/09/2014 15:11:19 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingCommitmentWorkflowItem_TACalendar_SEL]'))
DROP VIEW [dbo].[vwx_SourcingCommitmentWorkflowItem_TACalendar_SEL]
GO

/****** Object:  View [dbo].[vwx_SourcingCommitmentWorkflowItem_TACalendar_SEL]    Script Date: 08/09/2014 15:11:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_SourcingCommitmentWorkflowItem_TACalendar_SEL]
AS
SELECT SourcingCommitmentItemID, StyleQuoteItemStatusId, stat.Custom AS WorkStatusName, WorkAssignedTo,
ISNULL(stat.CustomIcon, 'icon_ball_gray.gif') AS WorkflowStatusImage,
'Commitment' AS WorkflowName,
cal.TaskPlanStart, cal.TaskPlanEnd, cal.TaskRevisedlStart AS RevisedStart, cal.TaskRevisedEnd AS RevisedEnd, 
sci.ActualStart, sci.ActualEnd, cal.TACalTemplateId AS CalendarID, sci.MUser, sci.MDate
FROM pSourcingCommitmentItem sci
LEFT OUTER JOIN pStyleQuoteItemStatus stat ON stat.CustomKey = sci.StyleQuoteItemStatusId
LEFT OUTER JOIN 
(
	SELECT ref.TACalTemplateId, ref.ReferenceId, ref.TACalReferenceTypeId, tt.TaskAssignedToId, tt.TaskPlanStart, tt.TaskPlanEnd,
	task.TaskRevisedlStart, task.TaskRevisedEnd
	FROM pTACalReference ref
	INNER JOIN pTACalReferenceTask task ON task.TACalReferenceId = ref.TACalReferenceId
	INNER JOIN pTACalTemplateTask tt ON task.TACalTemplateTaskId = tt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder='SOURCING COMMITMENT'
) AS cal ON cal.TACalReferenceTypeId = 19 AND cal.ReferenceId = sci.SourcingCommitmentItemID 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08704', GetDate())
GO
