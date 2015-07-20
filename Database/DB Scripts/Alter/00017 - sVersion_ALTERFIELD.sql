--
-- Saturday, March 13, 20105:23:15 AM
-- User: 
-- Server: YSDPSQL
-- Database: plmOn
-- Application: 
--

CREATE TABLE Tmp_sVersion
	(
	AppName nvarchar(32) NULL,
	Version nvarchar(32) NULL,
	LastScriptRun nvarchar(32) NULL,
	TimeStamp datetime NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM sVersion)
	 EXEC('INSERT INTO Tmp_sVersion (AppName, Version, LastScriptRun, TimeStamp)
		SELECT AppName, Version, LastScriptRun, CONVERT(datetime, TimeStamp) FROM sVersion WITH (HOLDLOCK TABLOCKX)')
GO

DROP TABLE sVersion
GO

EXECUTE sp_rename N'Tmp_sVersion', N'sVersion', 'OBJECT' 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '017', GetDate())
GO
