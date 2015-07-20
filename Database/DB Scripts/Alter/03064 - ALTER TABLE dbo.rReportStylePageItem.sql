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
ALTER TABLE dbo.rReportStylePageItem ADD
	ReportIsWorkflow int NULL
GO
ALTER TABLE dbo.rReportStylePageItem ADD CONSTRAINT
	DF_rReportStylePageItem_ReportIsWorkflow DEFAULT 0 FOR ReportIsWorkflow
GO
ALTER TABLE dbo.rReportStylePageItem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03064'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03064', GetDate())
END
GO