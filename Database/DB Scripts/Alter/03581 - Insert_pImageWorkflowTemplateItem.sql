IF NOT EXISTS(SELECT * FROM pImageWorkflowTemplateItem WHERE LOWER(ImageWorkflowTemplateItemName) = 'image')
BEGIN
	INSERT INTO pImageWorkflowTemplateItem(ImageWorkflowTemplateItemID, ImageWorkflowTemplateItemName, ImageWorkflowTemplateItemDesc, 
				ImageWorkflowTemplateItemURL, Active, Sort)
	VALUES (NEWID(), 'Image', 'Image', 'Image_Edit.aspx', 1, '0001')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03581', GetDate())
GO