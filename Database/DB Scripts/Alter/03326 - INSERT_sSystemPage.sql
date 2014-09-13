SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--These INSERTS are lookup value, ideally depending upon the page which requires Wiki these scripts should be generated
--Color lookup
IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Library_RGB.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Library_RGB.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
GO

--Material lookup
IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Material_Color_Select.aspx')
	BEGIN
		INSERT INTO [sSystemPage](MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Material_Color_Select.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Material'))
	END
GO

--Style lookup
IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorGroup.aspx')
	BEGIN
		INSERT INTO [sSystemPage](MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorGroup.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03326'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03326', GetDate())
END

GO