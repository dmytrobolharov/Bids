SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT sSystemFolder FROM sSystemFolder WHERE sSystemFolder='Color')
	BEGIN
		INSERT INTO sSystemFolder (sSystemFolder, CDate, CUser) VALUES ('Color', getDate(), 'Administrator')
	END
GO

IF NOT EXISTS(SELECT sSystemFolder FROM sSystemFolder WHERE sSystemFolder='Material')	
	BEGIN
		INSERT INTO sSystemFolder (sSystemFolder, CDate, CUser) VALUES ('Material', getDate(), 'Administrator')
	END
GO

IF NOT EXISTS(SELECT sSystemFolder FROM sSystemFolder WHERE sSystemFolder='Style')
	BEGIN
		INSERT INTO sSystemFolder (sSystemFolder, CDate, CUser) VALUES ('Style', getDate(), 'Administrator')
	END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03312'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03312', GetDate())
END

GO