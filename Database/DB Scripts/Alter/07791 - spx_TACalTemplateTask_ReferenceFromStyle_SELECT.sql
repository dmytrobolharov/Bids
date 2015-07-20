/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromStyle_SELECT]    Script Date: 05/31/2014 23:55:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_ReferenceFromStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromStyle_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromStyle_SELECT]    Script Date: 05/31/2014 23:55:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromStyle_SELECT](
	@TACalTemplateTaskID uniqueidentifier
)

AS 


DECLARE @StyleFolderID integer
DECLARE @TACalTemplateId uniqueidentifier 

SELECT @StyleFolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Style Folder')

SELECT crt.TACalRefTaskId, 'Style' as RefType, sh.StyleNo, sh.Description, crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd 
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId 
Where crt.TACalTemplateTaskId=@TACalTemplateTaskID and cr.TACalReferenceTypeId = @StyleFolderID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07791', GetDate())
GO