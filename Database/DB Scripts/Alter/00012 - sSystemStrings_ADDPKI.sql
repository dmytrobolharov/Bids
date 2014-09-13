--
--   Saturday, March 13, 20102:49:20 AM
--   User: 
--   Server: YSDPSQL
--   Database: plmOn
--   Application: 
--
--

IF EXISTS (SELECT Name from sysobjects WHERE Name like '%00EF9DD0')
   BEGIN
        ALTER TABLE sSystemStrings DROP CONSTRAINT DF__sSystemSt__Syste__00EF9DD0
   END
GO

CREATE TABLE Tmp_sSystemStrings
	(
	SystemStringID uniqueidentifier NOT NULL ROWGUIDCOL,
	DesignString nvarchar(4000) NULL,
	DA nvarchar(4000) NULL,
	DE nvarchar(4000) NULL,
	[EN-US] nvarchar(4000) NULL,
	[EN-UK] nvarchar(4000) NULL,
	FR nvarchar(4000) NULL,
	ES nvarchar(4000) NULL,
	[ES-MX] nvarchar(4000) NULL,
	IT nvarchar(4000) NULL,
	JA nvarchar(4000) NULL,
	KO nvarchar(4000) NULL,
	NL nvarchar(4000) NULL,
	PL nvarchar(4000) NULL,
	PT nvarchar(4000) NULL,
	RU nvarchar(4000) NULL,
	TR nvarchar(4000) NULL,
	[ZH-CN] nvarchar(4000) NULL,
	[ZH-HK] nvarchar(4000) NULL,
	[ZH-TW] nvarchar(4000) NULL,
	WhenModified datetime NULL,
	WhoModified nvarchar(200) NULL
	)  ON [PRIMARY]
GO

ALTER TABLE Tmp_sSystemStrings ADD CONSTRAINT
	DF__sSystemSt__Syste__00EF9DD0 DEFAULT (newsequentialid()) FOR SystemStringID
GO

IF EXISTS(SELECT * FROM sSystemStrings)
	 EXEC('INSERT INTO Tmp_sSystemStrings (SystemStringID, DesignString, DA, DE, [EN-US], [EN-UK], FR, ES, [ES-MX], IT, JA, KO, NL, PL, PT, RU, TR, [ZH-CN], [ZH-HK], [ZH-TW], WhenModified, WhoModified)
		SELECT SystemStringID, DesignString, DA, DE, [EN-US], [EN-UK], FR, ES, [ES-MX], IT, JA, KO, NL, PL, PT, RU, TR, [ZH-CN], [ZH-HK], [ZH-TW], WhenModified, WhoModified FROM sSystemStrings WITH (HOLDLOCK TABLOCKX)')
GO

DROP TABLE sSystemStrings
GO

EXECUTE sp_rename N'Tmp_sSystemStrings', N'sSystemStrings', 'OBJECT' 
GO

ALTER TABLE sSystemStrings ADD CONSTRAINT
	PK_sSystemStrings PRIMARY KEY CLUSTERED 
	(SystemStringID) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '012', GetDate())
GO
