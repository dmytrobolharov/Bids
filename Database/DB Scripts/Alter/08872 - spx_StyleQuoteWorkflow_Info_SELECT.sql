/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]    Script Date: 08/17/2014 15:33:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteWorkflow_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]    Script Date: 08/17/2014 15:33:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_StyleQuoteWorkflow_Info_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	DECLARE @FolderID INTEGER
	
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER = NULL
	DECLARE @TACalTemplateName NVARCHAR(200) = ''
	DECLARE @TACalRefTaskID UNIQUEIDENTIFIER = NULL
	
	SELECT @FolderID = PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')
	
	SELECT @TACalTemplateID = cr.TACalTemplateId, @TACalTemplateName = ct.TACalTemplateName, @TACalRefTaskID = crt.TACalRefTaskId
	FROM pTACalReference cr 
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	LEFT JOIN pTACalReferenceTask crt
		INNER JOIN pTACalTemplateTask tt ON tt.TACalTemplateTaskId = crt.TACalTemplateTaskId
		INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId AND tw.WorkflowFolder='SOURCING QUOTATION'
	ON cr.TACalReferenceId = crt.TACalReferenceId
	WHERE ReferenceId = @StyleQuoteItemID AND cr.TACalReferenceTypeId = @FolderID
	
	IF @TACalRefTaskID IS NOT NULL
	BEGIN
		SELECT sqi.StyleQuoteItemID, sh.SourcingHeaderID, sh.SourcingType, sh.seasonYearId, 
		sth.StyleID, sth.DivisionID, sth.StyleType, 
		tt.TaskPlanStart AS WorkStart, tt.TaskPlanEnd AS WorkDue, sqi.ActualStart, sqi.ActualEnd, sqi.WorkAssignedTo,
		sqi.StyleQuoteItemStatusId AS WorkStatus, stat.Custom AS WorkStatusName,
		'~/System/Icons/' + ISNULL(stat.CustomIcon, 'icon_ball_gray.gif') AS StatusIconURL,
		'Sourcing_StylePage_QuotationEdit.aspx' AS WorkflowPageURL,
		ug.UserID, ug.FullName, @TACalTemplateID AS CalendarID, @TACalTemplateName AS CalendarName, @TACalRefTaskID AS ReferenceTaskID
		FROM pStyleQuoteItem sqi
		INNER JOIN pStyleQuoteItemStatus stat ON stat.CustomKey = sqi.StyleQuoteItemStatusId
		INNER JOIN pSourcingHeader sh ON sh.SourcingHeaderID = sqi.SourcingHeaderID 
		INNER JOIN pStyleHeader sth ON sqi.StyleID = sth.StyleID 
		INNER JOIN pTACalReference cr ON cr.ReferenceId = sqi.StyleQuoteItemID AND cr.TACalReferenceTypeId = @FolderID AND cr.TACalTemplateId = @TACalTemplateID
		INNER JOIN pTACalReferenceTask crt ON cr.TACalReferenceId = crt.TACalReferenceId
		INNER JOIN pTACalTemplateTask tt on tt.TACalTemplateTaskId = crt.TACalTemplateTaskId
		INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder='SOURCING QUOTATION'
		LEFT JOIN vwx_UserGroupDropDown_SEL ug ON sqi.WorkAssignedTo = ug.UserID
		WHERE StyleQuoteItemID = @StyleQuoteItemID
	END
	ELSE
	BEGIN
		SELECT sqi.StyleQuoteItemID, sh.SourcingHeaderID, sh.SourcingType, sh.seasonYearId, 
		sth.StyleID, sth.DivisionID, sth.StyleType, 
		sqi.WorkStart, sqi.WorkDue, sqi.ActualStart, sqi.ActualEnd, sqi.WorkAssignedTo,
		sqi.StyleQuoteItemStatusId AS WorkStatus, stat.Custom AS WorkStatusName,
		'~/System/Icons/' + ISNULL(stat.CustomIcon, 'icon_ball_gray.gif') AS StatusIconURL,
		'Sourcing_StylePage_QuotationEdit.aspx' AS WorkflowPageURL,
		ug.UserID, ug.FullName, @TACalTemplateID AS CalendarID, @TACalTemplateName AS CalendarName, @TACalRefTaskID AS ReferenceTaskID
		FROM pStyleQuoteItem sqi
		INNER JOIN pStyleQuoteItemStatus stat ON stat.CustomKey = sqi.StyleQuoteItemStatusId
		INNER JOIN pSourcingHeader sh ON sh.SourcingHeaderID = sqi.SourcingHeaderID 
		INNER JOIN pStyleHeader sth ON sqi.StyleID = sth.StyleID 
		LEFT JOIN vwx_UserGroupDropDown_SEL ug ON sqi.WorkAssignedTo = ug.UserID
		WHERE StyleQuoteItemID = @StyleQuoteItemID
	END
   
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08872', GetDate())
GO
