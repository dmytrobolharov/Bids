/****** Object:  Table [dbo].[pMaterialTemplatePage]    Script Date: 04/17/2012 16:24:26 ******/
IF NOT EXISTS (SELECT * FROM pMaterialTemplatePage WHERE MaterialTemplatePageName = N'Color')
BEGIN
	INSERT [dbo].[pMaterialTemplatePage] ([MaterialTemplatePageID], [MaterialTemplatePageName], [MaterialTemplatePageDesc], [MaterialTemplatePageURL], [Active], [Sort], [CUser], [CDate], [MUser], [MDate]) VALUES (NEWID(), N'Color', NULL, N'Material_Color.aspx', 1, N'0', NULL, NULL, NULL, NULL)
END
	
IF NOT EXISTS (SELECT * FROM pMaterialTemplatePage WHERE MaterialTemplatePageName = N'Attachment')
BEGIN
	INSERT [dbo].[pMaterialTemplatePage] ([MaterialTemplatePageID], [MaterialTemplatePageName], [MaterialTemplatePageDesc], [MaterialTemplatePageURL], [Active], [Sort], [CUser], [CDate], [MUser], [MDate]) VALUES (NEWID(), N'Attachment', NULL, N'Material_Document_Edit.aspx', 1, N'2', NULL, NULL, NULL, NULL)
END
	
IF NOT EXISTS (SELECT * FROM pMaterialTemplatePage WHERE MaterialTemplatePageName = N'Image')
BEGIN
	INSERT [dbo].[pMaterialTemplatePage] ([MaterialTemplatePageID], [MaterialTemplatePageName], [MaterialTemplatePageDesc], [MaterialTemplatePageURL], [Active], [Sort], [CUser], [CDate], [MUser], [MDate]) VALUES (NEWID(), N'Image', NULL, N'Material_Image.aspx', 1, N'1', NULL, NULL, NULL, NULL)
END	
GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03370', GetDate())

GO