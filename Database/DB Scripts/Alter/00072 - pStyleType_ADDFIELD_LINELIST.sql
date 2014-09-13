/*
   Tuesday, April 20, 20108:05:08 AM
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
ALTER TABLE dbo.pStyleType ADD
	LineListSearchSchema nvarchar(200) NULL
GO
UPDATE pStyleType SET LineListSearchSchema = 'Style_Search_Apparel.xml'

GO
COMMIT

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '072', GetDate())
GO
