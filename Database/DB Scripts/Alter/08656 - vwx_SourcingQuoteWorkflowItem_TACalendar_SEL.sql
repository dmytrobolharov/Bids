/****** Object:  View [dbo].[vwx_SourcingQuoteWorkflowItem_TACalendar_SEL]    Script Date: 08/08/2014 16:46:20 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingQuoteWorkflowItem_TACalendar_SEL]'))
DROP VIEW [dbo].[vwx_SourcingQuoteWorkflowItem_TACalendar_SEL]
GO

/****** Object:  View [dbo].[vwx_SourcingQuoteWorkflowItem_TACalendar_SEL]    Script Date: 08/08/2014 16:46:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SourcingQuoteWorkflowItem_TACalendar_SEL]
AS
SELECT StyleQuoteItemID, StyleQuoteItemStatusId, stat.Custom AS WorkStatusName, WorkAssignedTo,
ISNULL(stat.CustomIcon, 'icon_ball_gray.gif') AS WorkflowStatusImage,
'Quotation' AS WorkflowName,
cal.TaskPlanStart, cal.TaskPlanEnd, cal.TaskRevisedlStart AS RevisedStart, cal.TaskRevisedEnd AS RevisedEnd, 
sqi.ActualStart, sqi.ActualEnd, cal.TACalTemplateId AS CalendarID, sqi.MUser, sqi.MDate
FROM pStyleQuoteItem sqi
LEFT OUTER JOIN pStyleQuoteItemStatus stat ON stat.CustomKey = sqi.StyleQuoteItemStatusId
LEFT OUTER JOIN 
(
	SELECT ref.TACalTemplateId, ref.ReferenceId, ref.TACalReferenceTypeId, tt.TaskAssignedToId, tt.TaskPlanStart, tt.TaskPlanEnd,
	task.TaskRevisedlStart, task.TaskRevisedEnd
	FROM pTACalReference ref
	INNER JOIN pTACalReferenceTask task ON task.TACalReferenceId = ref.TACalReferenceId 
	INNER JOIN pTACalTemplateTask tt ON task.TACalTemplateTaskId = tt.TACalTemplateTaskId 
) AS cal ON cal.TACalReferenceTypeId = 19 AND cal.ReferenceId = sqi.StyleQuoteItemID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08656', GetDate())
GO

