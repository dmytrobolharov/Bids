IF NOT EXISTS(SELECT * FROM pStyleSKUTemplate WHERE StyleSKUTemplateID = '8a85191d-b237-4978-8ab2-78e93dc96838')
BEGIN
	INSERT pStyleSKUTemplate (StyleSKUTemplateID, TemplateName, FlashEditSchema, SearchSchema, GridSchema, Active) 
	VALUES (N'8a85191d-b237-4978-8ab2-78e93dc96838', N'Default', N'Style_SKUItem_BatchForm.xml', N'Style_SKUItem_Search.xml', N'Style_SKUItem_BatchGrid.xml', 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07000', GetDate())
GO
