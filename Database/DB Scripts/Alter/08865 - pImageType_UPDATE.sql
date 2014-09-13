UPDATE pImageType
SET ImagePrintSchema = 
	CASE
		WHEN ImageType = 'Trade Partner' THEN 'Image_Default_Print.xml'
		WHEN ImageType = 'Style' THEN 'Image_Style_Print.xml'
		WHEN ImageType = 'Construction' THEN 'Image_Construction_Print.xml'
		WHEN ImageType = 'Sketch' THEN 'Image_Sketch_Print.xml'
		WHEN ImageType = 'Concept' THEN 'Image_Concept_Print.xml'
		WHEN ImageType = 'Artwork' THEN 'Image_Artwork_Print.xml'
		WHEN ImageType = 'Material' THEN 'Image_Material_Print.xml'
	END
WHERE ImageType IN ('Trade Partner', 'Style', 'Construction', 'Sketch', 'Concept', 'Artwork', 'Material')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08865', GetDate())
GO
