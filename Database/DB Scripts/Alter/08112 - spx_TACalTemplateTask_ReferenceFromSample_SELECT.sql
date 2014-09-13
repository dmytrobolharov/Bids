/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromSample_SELECT]    Script Date: 06/27/2014 16:10:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_ReferenceFromSample_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromSample_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromSample_SELECT]    Script Date: 06/27/2014 16:10:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromSample_SELECT](
	@TACalTemplateTaskID uniqueidentifier
)

AS 


DECLARE @StyleFolderID integer
DECLARE @TACalTemplateId uniqueidentifier 

SELECT @StyleFolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Sample Folder')

SELECT crt.TACalRefTaskId, 'Sample Request' as RefType, sh.styleID, tw.WorkflowId, ct.SeasonYearId, sh.StyleNo, sh.Description, crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd 
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pSampleRequestBOMTrade srb ON srb.SampleRequestTradeID = cr.ReferenceId
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
INNER JOIN pStyleHeader sh ON sh.StyleID = srb.StyleID
Where crt.TACalTemplateTaskId=@TACalTemplateTaskID and cr.TACalReferenceTypeId = @StyleFolderID
UNION
SELECT crt.TACalRefTaskId, 'Sample Request' as RefType, sh.styleID, tw.WorkflowId, ct.SeasonYearId, sh.StyleNo, sh.Description, crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd 
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pSampleRequestTrade sr ON sr.SampleRequestTradeID = cr.ReferenceId
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
INNER JOIN pStyleHeader sh ON sh.StyleID = sr.StyleID
Where crt.TACalTemplateTaskId=@TACalTemplateTaskID and cr.TACalReferenceTypeId = @StyleFolderID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08112', GetDate())
GO