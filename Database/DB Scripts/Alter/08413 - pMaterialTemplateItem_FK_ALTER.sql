-- recreate foreign key to cascade on update, 
-- so pMaterialTemplatePage primary key changes will be propogated to pMaterialTemplateItem
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pMaterialTemplateItem_pMaterialTemplatePage]') AND parent_object_id = OBJECT_ID(N'[dbo].[pMaterialTemplateItem]'))
ALTER TABLE [dbo].[pMaterialTemplateItem] DROP CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplatePage]
GO

ALTER TABLE [dbo].[pMaterialTemplateItem]  WITH CHECK ADD  CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplatePage] FOREIGN KEY([MaterialTemplatePageID])
REFERENCES [dbo].[pMaterialTemplatePage] ([MaterialTemplatePageID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pMaterialTemplateItem] CHECK CONSTRAINT [FK_pMaterialTemplateItem_pMaterialTemplatePage]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08413', GetDate())
GO
