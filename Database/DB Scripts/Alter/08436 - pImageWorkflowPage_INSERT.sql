INSERT INTO pImageWorkflowPage(
	ImageID, ImageWorkflowTemplateEntryID, ImageWorkflowTemplateItemID,
	WorkStart, WorkDue, WorkAssignedTo, WorkStatus,
	Sort, CUser, CDate, MUser, MDate)
SELECT i.ImageID, iwte.ImageWorkflowTemplateEntryID, iwte.ImageWorkflowTemplateItemID,
	NULL, NULL, NULL, 6,
	iwte.Sort, 'SYSTEM', GETDATE(), 'SYSTEM', GETDATE()
FROM pImage i
INNER JOIN pImageWorkflowTemplateEntry iwte ON i.ImageWorkflowTemplateID = iwte.ImageWorkflowTemplateID
LEFT JOIN pImageWorkflowPage iwp ON i.ImageID = iwp.ImageID 
	AND iwte.ImageWorkflowTemplateItemID = iwp.ImageWorkflowTemplateItemID
WHERE iwp.ImageWorkflowPageID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08436', GetDate())
GO
