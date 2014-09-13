IF NOT EXISTS(SELECT * FROM pApplicationConnectionSetting WHERE ApplicationConnectionName = 'Toolkit')
BEGIN 
	INSERT INTO [dbo].[pApplicationConnectionSetting] ([ApplicationConnectionName], [ApplicationConnectionXML], [ApplicationConnectionXMLEdit])
	VALUES ('Toolkit', 'ApplicationSetting_Toolkit.xml', 'ApplicationSetting_Toolkit_Edit.xml')
END
GO

IF NOT EXISTS(SELECT * FROM pApplicationConnectionSetting WHERE ApplicationConnectionName = 'Design Suite')
BEGIN 
	INSERT INTO [dbo].[pApplicationConnectionSetting] ([ApplicationConnectionName], [ApplicationConnectionXML], [ApplicationConnectionXMLEdit])
	VALUES ('Design Suite', 'ApplicationSetting_DesignSuite.xml', 'ApplicationSetting_DesignSuite_Edit.xml')
END
GO

IF NOT EXISTS(SELECT * FROM pApplicationConnectionSetting WHERE ApplicationConnectionName = 'Mobility')
BEGIN 
	INSERT INTO [dbo].[pApplicationConnectionSetting] ([ApplicationConnectionName], [ApplicationConnectionXML], [ApplicationConnectionXMLEdit])
	VALUES ('Mobility', 'ApplicationSetting_Mobility.xml', 'ApplicationSetting_Mobility_Edit.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08679', GetDate())
GO