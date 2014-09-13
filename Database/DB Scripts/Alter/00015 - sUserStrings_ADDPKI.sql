--
-- Saturday, March 13, 20102:21:26 AM
-- User: 
-- Server: YSDPSQL
-- Database: plmOn
-- Application: 
--

IF EXISTS (SELECT Name from sysobjects WHERE Name like '%02D7E642')
   BEGIN
        ALTER TABLE sUserStrings DROP CONSTRAINT DF__sUserStri__UserS__02D7E642
   END
GO

CREATE TABLE Tmp_sUserStrings
	(
	UserStringID uniqueidentifier NOT NULL ROWGUIDCOL,
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

ALTER TABLE Tmp_sUserStrings ADD CONSTRAINT
	DF__sUserStri__UserS__02D7E642 DEFAULT (newsequentialid()) FOR UserStringID
GO

IF EXISTS(SELECT * FROM sUserStrings)
	 EXEC('INSERT INTO Tmp_sUserStrings (UserStringID, DesignString, DA, DE, [EN-US], [EN-UK], FR, ES, [ES-MX], IT, JA, KO, NL, PL, PT, RU, TR, [ZH-CN], [ZH-HK], [ZH-TW], WhenModified, WhoModified)
		SELECT UserStringID, DesignString, DA, DE, [EN-US], [EN-UK], FR, ES, [ES-MX], IT, JA, KO, NL, PL, PT, RU, TR, [ZH-CN], [ZH-HK], [ZH-TW], WhenModified, WhoModified FROM sUserStrings WITH (HOLDLOCK TABLOCKX)')
GO

DROP TABLE sUserStrings
GO

EXECUTE sp_rename N'Tmp_sUserStrings', N'sUserStrings', 'OBJECT' 
GO

ALTER TABLE sUserStrings ADD CONSTRAINT
	PK_sUserStrings PRIMARY KEY CLUSTERED 
	(UserStringID) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '015', GetDate())
GO
