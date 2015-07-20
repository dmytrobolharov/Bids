/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSourcingQuote_CREATE]    Script Date: 08/06/2014 12:12:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromSourcingQuote_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromSourcingQuote_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromSourcingQuote_CREATE]    Script Date: 08/06/2014 12:12:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_TACalReferenceFromSourcingQuote_CREATE](
	@TACalTemplateID UNIQUEIDENTIFIER,
	@QuoteItemID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(100),
	@CDate DATETIME
)

AS 

DECLARE @FolderID INTEGER
DECLARE @TACalReferenceId UNIQUEIDENTIFIER = NEWID()

SELECT @FolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')

--add TACAlReference to current quote
INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @QuoteItemID, @CUser, @CDate, @CUser, @CDate, 1)

INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
SELECT @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
FROM pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
WHERE tw.WorkflowFolder='SOURCING QUOTATION' AND tt.TACalTemplateId=@TACalTemplateId AND tt.New=1 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08587', GetDate())
GO
