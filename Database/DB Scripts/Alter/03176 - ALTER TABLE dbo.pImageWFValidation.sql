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
ALTER TABLE dbo.pImageWFValidation ADD
	IsFrontBackWF bit NULL
GO
ALTER TABLE dbo.pImageWFValidation ADD CONSTRAINT
	DF_pImageWFValidation_IsFrontBackWF DEFAULT 0 FOR IsFrontBackWF
GO
ALTER TABLE dbo.pImageWFValidation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03176', GetDate())

GO

