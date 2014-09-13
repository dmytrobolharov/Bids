SET ANSI_NULLS ON
GO

IF NOT EXISTS(SELECT * FROM sSystemFolder WHERE sSystemFolder='Development Calendar')
	begin
		INSERT INTO sSystemFolder(sSystemFolder,CDate,CUser)
		VALUES('Development Calendar',GETDATE(),'Administrator')
	end
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='TimeAction_Folder.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('TimeAction_Folder.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Development Calendar'))
	END
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
WHERE sSystemFolderID = (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Development Calendar')

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

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08808', GetDate())
GO
