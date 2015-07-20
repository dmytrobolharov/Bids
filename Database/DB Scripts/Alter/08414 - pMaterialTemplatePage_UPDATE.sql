-- update Material Workflows to be statically known (as in styles)
UPDATE mtp SET 
	MaterialTemplatePageID = 
	CASE mtp.MaterialTemplatePageName
		WHEN 'Attributes' THEN '10000000-0000-0000-0000-000000000000'
		WHEN 'Color' THEN '20000000-0000-0000-0000-000000000000'
		WHEN 'Image' THEN '30000000-0000-0000-0000-000000000000'
		WHEN 'Attachment' THEN '40000000-0000-0000-0000-000000000000'
		WHEN '3D Files' THEN '40000000-0000-0000-0000-000000000020'
	END
FROM pMaterialTemplatePage mtp
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08414', GetDate())
GO
