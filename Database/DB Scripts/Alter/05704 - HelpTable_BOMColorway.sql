SET ANSI_NULLS ON
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DimensionalBOM_BOMColorway.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DimensionalBOM_BOMColorway.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
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
WHERE sSystemFolderID = (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style')

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
VALUES     ('DB_Version', '0.5.0000', '05704', GetDate())
GO
