--
-- Saturday, March 13, 20102:44:00 AM
-- User: 
-- Server: YSDPSQL
-- Database: plmOn
-- Application: 
--

CREATE TABLE Tmp_sSystemPageStrings
	(
	sSystemPageString uniqueidentifier NOT NULL ROWGUIDCOL,
	FormName nvarchar(4000) NULL,
	SystemStringID uniqueidentifier NULL,
	WhenModified datetime NULL,
	WhoModified nvarchar(200) NULL
	)  ON [PRIMARY]
GO

ALTER TABLE Tmp_sSystemPageStrings ADD CONSTRAINT
	DF_sSystemPageStrings_sSystemPageString DEFAULT newid() FOR sSystemPageString
GO
IF EXISTS(SELECT * FROM sSystemPageStrings)
	 EXEC('INSERT INTO Tmp_sSystemPageStrings (FormName, SystemStringID, WhenModified, WhoModified)
		SELECT FormName, SystemStringID, WhenModified, WhoModified FROM sSystemPageStrings WITH (HOLDLOCK TABLOCKX)')
GO

DROP TABLE sSystemPageStrings
GO

EXECUTE sp_rename N'Tmp_sSystemPageStrings', N'sSystemPageStrings', 'OBJECT' 
GO

ALTER TABLE sSystemPageStrings ADD CONSTRAINT
	PK_sSystemPageStrings PRIMARY KEY CLUSTERED 
	(sSystemPageString) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '014', GetDate())
GO
