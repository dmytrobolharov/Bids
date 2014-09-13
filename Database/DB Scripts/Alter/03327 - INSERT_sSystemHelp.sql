SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--These INSERTS are lookup value, ideally depending upon the page which requires Wiki these scripts should be generated
--Color lookup DesignString
IF NOT EXISTS(SELECT * FROM sSystemHelp WHERE DesignString='What is RGB color library?')
	BEGIN
		INSERT INTO sSystemHelp (DesignString, sSystemPageID, CDate, CUser)
		VALUES ('What is RGB color library?', (select sSystemPageID from sSystemPage where MappingPage='Color_Library_RGB.aspx'), GETDATE(), 'Administrator')
	END
GO

--Material lookup DesignString
IF NOT EXISTS(SELECT * FROM sSystemHelp WHERE DesignString='How to select Material color?')
	BEGIN
		INSERT INTO sSystemHelp (DesignString, sSystemPageID, CDate, CUser)
		VALUES ('How to select Material color?', (select sSystemPageID from sSystemPage where MappingPage='Material_Color_Select.aspx'), GETDATE(), 'Administrator')
	END
GO

--Style lookup DesignString
IF NOT EXISTS(SELECT * FROM sSystemHelp WHERE DesignString='What is Style color group?')
	BEGIN
		INSERT INTO sSystemHelp (DesignString, sSystemPageID, CDate, CUser)
		VALUES ('What is Style color group?', (select sSystemPageID from sSystemPage where MappingPage='Style_ColorGroup.aspx'), GETDATE(), 'Administrator')
	END

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03327'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03327', GetDate())
END

GO