UPDATE pColorType SET ColorPaletteSchemaImageSearch='Image_ColorPaletteSearch_CompanyLibrary.xml' WHERE ColorTypeID = 0
GO

UPDATE pColorType SET ColorPaletteSchemaImageSearch='Image_ColorPaletteSearch_Seasonal.xml' WHERE ColorTypeID = 1
GO

UPDATE pColorType SET ColorPaletteSchemaImageSearch='Image_ColorPaletteSearch_Trim.xml' WHERE ColorTypeID = 2
GO

UPDATE pColorType SET ColorPaletteSchemaImageSearch='Image_ColorPaletteSearch_Textile.xml' WHERE ColorTypeID = 3
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09333', GetDate())
GO
