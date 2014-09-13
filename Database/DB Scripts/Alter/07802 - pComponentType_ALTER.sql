    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pComponentType' and COLUMN_NAME = N'ComponentSchemaImageSearch')
    BEGIN 			
        ALTER TABLE pComponentType ADD ComponentSchemaImageSearch nvarchar(200) NULL
   END
   GO
   
   IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pComponentType' and COLUMN_NAME = N'ComponentSchemaImageSearch')
   BEGIN	   
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Wovens.xml' where ComponentSearchSchema = 'Material_Search_Wovens.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Knits.xml' where ComponentSearchSchema = 'Material_Search_Knits.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Yarns.xml' where ComponentSearchSchema = 'Material_Search_Yarns.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Other.xml' where ComponentSearchSchema = 'Material_Search_Other.xml'		   
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Interlining.xml' where ComponentSearchSchema = 'Material_Search_Interlining.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Thread.xml' where ComponentSearchSchema = 'Material_Search_Thread.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Artwork.xml' where ComponentSearchSchema = 'Material_Search_Artwork.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Embroidery.xml' where ComponentSearchSchema = 'Material_Search_Embroidery.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Trimming.xml' where ComponentSearchSchema = 'Material_Search_Trimming.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Labels.xml' where ComponentSearchSchema = 'Material_Search_Labels.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Packaging.xml' where ComponentSearchSchema = 'Material_Search_Packaging.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Zippers.xml' where ComponentSearchSchema = 'Material_Search_Zippers.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearch_Lining.xml' where ComponentSearchSchema = 'Material_Search_Lining.xml'
	   
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Wovens.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Wovens.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Knits.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Knits.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Yarns.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Yarns.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Other.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Other.xml'		   
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Interlining.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Interlining.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Thread.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Thread.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Artwork.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Artwork.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Embroidery.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Embroidery.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Trimming.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Trimming.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Labels.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Labels.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Packaging.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Packaging.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Zippers.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Zippers.xml'
	   Update pComponentType set ComponentSchemaImageSearch = 'Image_MaterialSearchSourced_Lining.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Lining.xml'
   END
   GO
   
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07802', GetDate())
GO
