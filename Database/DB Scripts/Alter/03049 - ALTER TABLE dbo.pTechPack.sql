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
ALTER TABLE dbo.pTechPack ADD
	SampleRequestSubmitId uniqueidentifier NULL,
	Submit nvarchar(4) NULL
GO
ALTER TABLE dbo.pTechPack SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03049'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03049', GetDate())

END

GO 