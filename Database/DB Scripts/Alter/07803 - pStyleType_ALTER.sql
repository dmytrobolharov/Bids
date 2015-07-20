   IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleType' and COLUMN_NAME = N'StyleSchemaImageSearch')
   BEGIN 			
		ALTER TABLE pStyleType ADD StyleSchemaImageSearch nvarchar(200) NULL
   END
   GO
   
   IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleType' and COLUMN_NAME = N'StyleSchemaImageSearch')
   BEGIN	   
	   Update pStyleType set StyleSchemaImageSearch = 'Image_StyleSearch_Apparel.xml' where StyleSchemaSearch = 'Style_Search_Apparel.xml'
	   Update pStyleType set StyleSchemaImageSearch = 'Image_StyleSearch_Accessory.xml' where StyleSchemaSearch = 'Style_Search_Accessory.xml'
	   Update pStyleType set StyleSchemaImageSearch = 'Image_SilhouetteSearch_Apparel.xml' where StyleSchemaSearch = 'Silhouette_Search_Apparel.xml'
	   Update pStyleType set StyleSchemaImageSearch = 'Image_SilhouetteSearch_Accessory.xml' where StyleSchemaSearch = 'Silhouette_Search_Accessory.xml'  
   END
   GO
   
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07803', GetDate())
GO
