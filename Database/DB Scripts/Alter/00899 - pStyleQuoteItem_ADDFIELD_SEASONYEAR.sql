/*
   Tuesday, December 07, 20103:54:06 PM
   User: 
   Server: localhost
   Database: plmOnOoTB
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

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleQuoteItem' and COLUMN_NAME = N'StyleSeasonYearID')
       BEGIN 
             ALTER TABLE pStyleQuoteItem  ADD StyleSeasonYearID uniqueidentifier NULL          
       END
GO

COMMIT
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '899', GetDate())
GO
