
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	--Attribute
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorwaySeasonal.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorwaySeasonal.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorwaySeasonal_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorwaySeasonal_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO

	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '05041', GetDate())
GO
	
		