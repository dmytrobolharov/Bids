IF NOT EXISTS (SELECT * FROM pMaterialTemplatePage WHERE MaterialTemplatePageName = 'Attributes')
BEGIN
INSERT INTO pMaterialTemplatePage
           ([MaterialTemplatePageID]
           ,[MaterialTemplatePageName]
           ,[MaterialTemplatePageDesc]
           ,[MaterialTemplatePageURL]
           ,[Active]
           ,[Sort]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate])
     VALUES
           (NEWID()
           ,'Attributes'
           ,NULL
           ,'Material_Edit.aspx'
           ,1
           ,'4'
           ,NULL
           ,NULL
           ,NULL
           ,NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07966', GetDate())
GO