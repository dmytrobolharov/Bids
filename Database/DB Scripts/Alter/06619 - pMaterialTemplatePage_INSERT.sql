IF NOT EXISTS (SELECT * FROM pMaterialTemplatePage WHERE MaterialTemplatePageName = N'3D Files')
BEGIN
	INSERT pMaterialTemplatePage (MaterialTemplatePageID, MaterialTemplatePageName, MaterialTemplatePageDesc, MaterialTemplatePageURL, Active, Sort, CUser, CDate, MUser, MDate) 
	VALUES (NEWID(), N'3D Files', NULL, N'Material_3DFiles.aspx', 1, N'3', NULL, NULL, NULL, NULL)
END	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06619', GetDate())
GO