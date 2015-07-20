/****** Object:  StoredProcedure [dbo].[spx_SourcingQuoteItemTACalendar_SEL]    Script Date: 08/07/2014 18:31:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuoteItemTACalendar_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuoteItemTACalendar_SEL]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuoteItemTACalendar_SEL]    Script Date: 08/07/2014 18:31:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_SourcingQuoteItemTACalendar_SEL] (
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@TACalTemplateID UNIQUEIDENTIFIER = NULL
	)
AS
BEGIN
	
	DECLARE @FolderID INTEGER

	SELECT @FolderID = PermissionFolderTypeId 
	FROM sPermissionFolderType 
	WHERE LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')
	
	SELECT StyleQuoteItemID, StyleQuoteItemStatusId AS WorkStatus, stat.Custom AS WorkStatusName, WorkAssignedTo,
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
	) AS cal ON cal.TACalReferenceTypeId = @FolderID AND cal.ReferenceId = sqi.StyleQuoteItemID AND (cal.TACalTemplateId = @TACalTemplateID OR @TACalTemplateID IS NULL)
	WHERE StyleQuoteItemID = @StyleQuoteItemID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08613', GetDate())
GO
