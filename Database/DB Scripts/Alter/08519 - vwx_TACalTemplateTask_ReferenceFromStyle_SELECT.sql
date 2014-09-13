/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]    Script Date: 08/01/2014 13:29:37 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]    Script Date: 08/01/2014 13:29:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]
AS
SELECT     crt.TACalRefTaskId, 'Style' AS RefType, sh.StyleID, tw.WorkflowId, ct.SeasonYearId, sh.StyleNo, sh.Description, sh.StyleType, sh.DivisionID, sh.SizeClass, 
                      sh.SizeRange, sh.StyleCategory, sh.IntroSeasonYearID, crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, 
                      crt.TaskRevisedEnd, crt.TACalTemplateTaskId
FROM         dbo.pTACalReferenceTask AS crt INNER JOIN
                      dbo.pTACalReference AS cr ON crt.TACalReferenceId = cr.TACalReferenceId INNER JOIN
                      dbo.pStyleHeader AS sh ON sh.StyleID = cr.ReferenceId INNER JOIN
                      dbo.pTACalTemplate AS ct ON ct.TACalTemplateId = cr.TACalTemplateId INNER JOIN
                      dbo.pTACalTemplateTask AS ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId INNER JOIN
                      dbo.pTATaskWorkflow AS tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId INNER JOIN
                      dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Style Folder')

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08519', GetDate())
GO