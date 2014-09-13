-- =============================================
-- Author:		Rajul Radadia
-- =============================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	DECLARE @HelpTable TABLE
	(
		ID				INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
		DesignString	NVARCHAR(200),
		sSystemPageID	UNIQUEIDENTIFIER,
		CDate			DATETIME,
		CUser			NVARCHAR(50)
	)

	DECLARE @theCount int
	DECLARE @theMax int

	INSERT INTO @HelpTable (DesignString, sSystemPageID, CDate, CUser)
	SELECT MappingPage, sSystemPageID, GETDATE(), 'Administrator' FROM sSystemPage
	WHERE sSystemFolderID = (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color')

	SET @theCount = 1
	SELECT @theMax = COUNT(ID) FROM @HelpTable

	WHILE (@theCount <= @theMax)
	BEGIN
		IF NOT EXISTS(SELECT * FROM sSystemHelp WHERE DesignString=(SELECT DesignString FROM @HelpTable WHERE ID = @theCount))
		BEGIN
			INSERT INTO sSystemHelp (DesignString, sSystemPageID, CDate, CUser)
			SELECT DesignString, sSystemPageID, CDate, CUser FROM @HelpTable
			WHERE ID = @theCount
		END
		SET @theCount = @theCount + 1
	END


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03599', GetDate())

GO