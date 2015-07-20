UPDATE pTATaskWorkflow
SET WorkflowId = mtp.MaterialTemplatePageID
FROM pTATaskWorkflow tw INNER JOIN pMaterialTemplatePage mtp 
ON tw.WorkflowName = mtp.MaterialTemplatePageName
WHERE WorkflowFolder = 'MATERIAL'

GO

UPDATE pTATaskWorkflow
SET WorkflowId = itp.ImageWorkflowTemplateItemID
FROM pTATaskWorkflow tw INNER JOIN pImageWorkflowTemplateItem itp
ON tw.WorkflowName = itp.ImageWorkflowTemplateItemName
WHERE WorkflowFolder = 'IMAGE'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08567', GetDate())
GO
