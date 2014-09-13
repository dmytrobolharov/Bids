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
	DesignSketchBackID uniqueidentifier NULL,
	DesignSketchBackVersion int NULL
GO
ALTER TABLE dbo.pStyleHeader ADD CONSTRAINT
	DF_pStyleHeader_DesignSketchBackID DEFAULT ('00000000-0000-0000-0000-000000000000') FOR DesignSketchBackID
GO
ALTER TABLE dbo.pStyleHeader SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03172', GetDate())

GO
