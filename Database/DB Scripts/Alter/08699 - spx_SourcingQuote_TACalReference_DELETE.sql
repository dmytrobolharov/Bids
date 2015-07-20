/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_TACalReference_DELETE]    Script Date: 08/09/2014 17:58:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_TACalReference_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_TACalReference_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_TACalReference_DELETE]    Script Date: 08/09/2014 17:58:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingQuote_TACalReference_DELETE]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@TACalTemplateID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @FolderID INTEGER
	SELECT @FolderID = PermissionFolderTypeId 
	FROM sPermissionFolderType 
	WHERE LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')
	
	DECLARE @TACalReferenceID UNIQUEIDENTIFIER
	
	SELECT @TACalReferenceID = cr.TACalReferenceId FROM pTACalReference cr
	INNER JOIN pTACalReferenceTask crt ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pTACalTemplateTask ctt ON crt.TACalTemplateTaskId = ctt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON ctt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder = 'SOURCING QUOTATION'
	WHERE ReferenceId = @StyleQuoteItemID AND cr.TACalReferenceTypeId = @FolderID AND cr.TACalTemplateId = @TACalTemplateID
	
	DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceID
	DELETE FROM pTACalReference WHERE TACalReferenceId = @TACalReferenceID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08699', GetDate())
GO
