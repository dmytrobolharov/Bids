/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitment_WorkflowTACalendar_UPDATE]    Script Date: 08/11/2014 23:24:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_WorkflowTACalendar_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_WorkflowTACalendar_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitment_WorkflowTACalendar_UPDATE]    Script Date: 08/11/2014 23:24:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_SourcingCommitment_WorkflowTACalendar_UPDATE]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER,
	@TACalTemplateID UNIQUEIDENTIFIER = NULL,
	@WorkAssignedTo INT = NULL,
	@RevisedStart DATETIME = NULL,
	@RevisedEnd DATETIME = NULL,
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN
	
	DECLARE @FolderID INTEGER
	SELECT @FolderID = PermissionFolderTypeId 
	FROM sPermissionFolderType 
	WHERE LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')
	
	IF @WorkAssignedTo IS NOT NULL
	BEGIN
		UPDATE pSourcingCommitmentItem SET WorkAssignedTo = @WorkAssignedTo, MUser = @MUser, MDate = @MDate 
		WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
	END
	
	IF @TACalTemplateID IS NOT NULL
	BEGIN
		
		DECLARE @TACalRefTaskID UNIQUEIDENTIFIER
		
		SELECT @TACalRefTaskID = rt.TACalRefTaskId FROM pTACalReferenceTask rt
		INNER JOIN pTACalReference ref ON ref.TACalReferenceId = rt.TACalReferenceId
		INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = rt.TACalTemplateTaskId
		INNER JOIN pTATaskWorkflow tw ON ctt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder = 'SOURCING COMMITMENT' 
		WHERE ref.ReferenceId = @SourcingCommitmentItemID AND ref.TACalReferenceTypeId = @FolderID AND ref.TACalTemplateId = @TACalTemplateID
		
		UPDATE pTACalReferenceTask SET TaskRevisedlStart = @RevisedStart, MUser = @MUser, MDate = @MDate 
		WHERE TACalRefTaskId = @TACalRefTaskID

		UPDATE pTACalReferenceTask SET TaskRevisedEnd = @RevisedEnd, MUser = @MUser, MDate = @MDate 
		WHERE TACalRefTaskId = @TACalRefTaskID
	END
	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08746', GetDate())
GO
