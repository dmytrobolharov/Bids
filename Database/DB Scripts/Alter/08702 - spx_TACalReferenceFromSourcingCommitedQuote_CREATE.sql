/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSourcingCommitedQuote_CREATE]    Script Date: 08/09/2014 18:14:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromSourcingCommitedQuote_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromSourcingCommitedQuote_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSourcingCommitedQuote_CREATE]    Script Date: 08/09/2014 18:14:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_TACalReferenceFromSourcingCommitedQuote_CREATE](
	@CommitmentID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(100),
	@CDate DATETIME
)

AS 
BEGIN
	DECLARE @FolderID INTEGER
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER

	SELECT @FolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')
	-- Getting the Calendar ID for parent quote
	SELECT @TACalTemplateID = cr.TACalTemplateId FROM pSourcingCommitmentItem sci
	INNER JOIN pTACalReference cr ON cr.TACalReferenceTypeId = @FolderID AND cr.ReferenceId = sci.StyleQuoteItemID
	INNER JOIN pTACalReferenceTask crt ON cr.TACalReferenceId = crt.TACalReferenceId
	INNER JOIN pTACalTemplateTask tt ON tt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId AND tw.WorkflowFolder = 'SOURCING QUOTATION' 
	WHERE sci.SourcingCommitmentItemID = @CommitmentID

	IF @TACalTemplateID IS NOT NULL
	BEGIN
		EXEC spx_TACalReferenceFromSourcingCommitment_CREATE @CommitmentID, @TACalTemplateID, @CUser, @CDate	
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08702', GetDate())
GO
