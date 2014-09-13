/*
   Thursday, February 17, 201111:42:18 AM
   User: 
   Server: YSDPW7
   Database: plmOn400OoTB
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pStyleHeader ADD
	IntroSeasonYearID uniqueidentifier NULL
GO
ALTER TABLE dbo.pStyleHeader SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01153', GetDate())
GO