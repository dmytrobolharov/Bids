DECLARE @ImageWorkflowTemplateItemID UNIQUEIDENTIFIER
SELECT @ImageWorkflowTemplateItemID = ImageWorkflowTemplateItemID 
FROM pImageWorkflowTemplateItem WHERE ImageWorkflowTemplateItemName = 'Image'

UPDATE pImageWorkflowTemplateItem
SET ImageWorkflowTemplateItemID = '10000000-0000-0000-0000-000000000000'
WHERE ImageWorkflowTemplateItemName = 'Image'

UPDATE pImageWorkflowTemplateEntry
SET ImageWorkflowTemplateItemID = '10000000-0000-0000-0000-000000000000'
WHERE ImageWorkflowTemplateItemID = @ImageWorkflowTemplateItemID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08435', GetDate())
GO
