IF NOT EXISTS(SELECT * FROM information_schema.columns c WHERE c.table_name = 'pImageType' AND c.column_name = 'ImageColorSchema')
	ALTER TABLE pImageType ADD ImageColorSchema NVARCHAR(200)
GO

UPDATE pImageType SET ImageColorSchema = REPLACE(ImageSchema, 'Image_', 'Image_Color_')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09927', GetDate())
GO
