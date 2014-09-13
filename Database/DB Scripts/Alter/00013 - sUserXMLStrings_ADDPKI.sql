--
-- Saturday, March 13, 20103:10:29 AM
-- User: 
-- Server: YSDPSQL
-- Database: plmOn
-- Application: 
--

CREATE TABLE Tmp_sUserXMLStrings
	(
	UserXMLStringID uniqueidentifier NOT NULL ROWGUIDCOL,
	XMLName nvarchar(4000) NULL,
	UserStringID uniqueidentifier NULL,
	WhenModified datetime NULL,
	WhoModified nvarchar(200) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE Tmp_sUserXMLStrings ADD CONSTRAINT
	DF_sUserXMLStrings_UserXMLStringID DEFAULT (newsequentialid()) FOR UserXMLStringID
GO

IF EXISTS(SELECT * FROM sUserXMLStrings)
	 EXEC('INSERT INTO Tmp_sUserXMLStrings (XMLName, UserStringID, WhenModified, WhoModified)
		SELECT XMLName, UserStringID, WhenModified, WhoModified FROM sUserXMLStrings WITH (HOLDLOCK TABLOCKX)')
GO

DROP TABLE sUserXMLStrings
GO

EXECUTE sp_rename N'Tmp_sUserXMLStrings', N'sUserXMLStrings', 'OBJECT' 
GO

ALTER TABLE sUserXMLStrings ADD CONSTRAINT
	PK_sUserXMLStrings PRIMARY KEY CLUSTERED 
	(UserXMLStringID) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO


INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '013', GetDate())
GO
