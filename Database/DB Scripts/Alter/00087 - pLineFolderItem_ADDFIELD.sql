/*
   Monday, May 03, 20109:37:41 PM
   User: 
   Server: YSDPSQL
   Database: plmOn
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
ALTER TABLE dbo.pLineFolderItem ADD
	StyleSeasonYearID uniqueidentifier NULL
GO
ALTER TABLE dbo.pLineFolderItem ADD CONSTRAINT
	DF_pLineFolderItem_StyleSeasonYearID DEFAULT '00000000-0000-0000-0000-000000000000' FOR StyleSeasonYearID
GO
COMMIT
GO

UPDATE pLineFolderItem SET StyleSeasonYearID = '00000000-0000-0000-0000-000000000000'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '087', GetDate())

GO
