IF NOT EXISTS(SELECT * FROM pImageType WHERE ImageType = 'Trade Partner')
BEGIN
INSERT INTO [pImageType]
           ([ImageTypeID]
           ,[ImageClass]
           ,[ImageType]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate]
           ,[Active]
           ,[ImageSchema]
           ,[ImageSearchSchema]
           ,[ImagePrintSchema]
           ,[ImageIDSchema]
           ,[ImageOrder]
           ,[ImageItemSchema]
           ,[ImageCode])
     VALUES
           ('031454fa-d2d6-44aa-b1a4-4540c547ee89'
           ,'C'
           ,'Trade Partner'
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,1
           ,'Image_Default.xml'
           ,'Image_Search_Default.xml'
           ,'Image_Default.xml'
           ,'Image_ID.xml'
           ,'0005'
           ,'Image_Item_Default.xml'
           ,NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06307', GetDate())
GO
