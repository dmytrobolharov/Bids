SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Color
DELETE FROM sSystemHelp
WHERE DesignString = 'What is RGB color library?'
GO

--Material
DELETE FROM sSystemHelp
WHERE DesignString = 'How to select Material color?'
GO

--Style
DELETE FROM sSystemHelp
WHERE DesignString = 'What is Style color group?'
GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03597', GetDate())


GO