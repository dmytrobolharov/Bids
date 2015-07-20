/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentWorkflow_Info_SELECT]    Script Date: 08/09/2014 21:26:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentWorkflow_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentWorkflow_Info_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentWorkflow_Info_SELECT]    Script Date: 08/09/2014 21:26:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SourcingCommitmentWorkflow_Info_SELECT]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FolderID INTEGER
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER = NULL
	SELECT @FolderID = PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')
	
	SELECT @TACalTemplateID = cr.TACalTemplateId FROM pTACalReference cr
	INNER JOIN pTACalReferenceTask crt ON cr.TACalReferenceId = crt.TACalReferenceId
	INNER JOIN pTACalTemplateTask tt on tt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder='SOURCING COMMITMENT'
	WHERE ReferenceId = @SourcingCommitmentItemID AND cr.TACalReferenceTypeId = @FolderID
	
	IF @TACalTemplateID IS NOT NULL
	BEGIN
		SELECT sci.SourcingCommitmentItemID, sh.SourcingHeaderID, sh.SourcingType, sh.seasonYearId, 
		sth.StyleID, sth.DivisionID, sth.StyleType, 
		tt.TaskPlanStart AS WorkStart, tt.TaskPlanEnd AS WorkDue, sci.ActualStart, sci.ActualEnd, sci.WorkAssignedTo,
		sci.StyleQuoteItemStatusId AS WorkStatus, stat.Custom AS WorkStatusName,
		'~/System/Icons/' + ISNULL(stat.CustomIcon, 'icon_ball_gray.gif') AS StatusIconURL,
		'Sourcing_StylePage_CommitmentEdit.aspx' AS WorkflowPageURL,
		ug.UserID, ug.FullName, @TACalTemplateID AS CalendarID 
		FROM pSourcingCommitmentItem sci
		INNER JOIN pStyleQuoteItemStatus stat ON stat.CustomKey = sci.StyleQuoteItemStatusId
		INNER JOIN pSourcingHeader sh ON sh.SourcingHeaderID = sci.SourcingHeaderID 
		INNER JOIN pStyleHeader sth ON sci.StyleID = sth.StyleID 
		INNER JOIN pTACalReference cr ON cr.ReferenceId = sci.SourcingCommitmentItemID AND cr.TACalReferenceTypeId = @FolderID AND cr.TACalTemplateId = @TACalTemplateID
		INNER JOIN pTACalReferenceTask crt ON cr.TACalReferenceId = crt.TACalReferenceId
		INNER JOIN pTACalTemplateTask tt on tt.TACalTemplateTaskId = crt.TACalTemplateTaskId
		INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder='SOURCING COMMITMENT'
		LEFT JOIN vwx_UserGroupDropDown_SEL ug ON sci.WorkAssignedTo = ug.UserID
		WHERE sci.SourcingCommitmentItemID = @SourcingCommitmentItemID
	END
	ELSE
	BEGIN
		SELECT sci.SourcingCommitmentItemID, sh.SourcingHeaderID, sh.SourcingType, sh.seasonYearId, 
		sth.StyleID, sth.DivisionID, sth.StyleType, 
		sci.WorkStart, sci.WorkDue, sci.ActualStart, sci.ActualEnd, sci.WorkAssignedTo,
		sci.StyleQuoteItemStatusId AS WorkStatus, stat.Custom AS WorkStatusName,
		'~/System/Icons/' + ISNULL(stat.CustomIcon, 'icon_ball_gray.gif') AS StatusIconURL,
		'Sourcing_StylePage_CommitmentEdit.aspx' AS WorkflowPageURL,
		ug.UserID, ug.FullName, @TACalTemplateID AS CalendarID 
		FROM pSourcingCommitmentItem sci
		INNER JOIN pStyleQuoteItemStatus stat ON stat.CustomKey = sci.StyleQuoteItemStatusId
		INNER JOIN pSourcingHeader sh ON sh.SourcingHeaderID = sci.SourcingHeaderID 
		INNER JOIN pStyleHeader sth ON sci.StyleID = sth.StyleID 
		LEFT JOIN vwx_UserGroupDropDown_SEL ug ON sci.WorkAssignedTo = ug.UserID
		WHERE sci.SourcingCommitmentItemID = @SourcingCommitmentItemID
	END
   
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08698', GetDate())
GO
