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
ALTER TABLE dbo.pStyleColorwaySeasonYear ADD
	DesignImageFrontID uniqueidentifier NULL,
	DesignImageFrontVersion int NULL,
	DesignImageBackID uniqueidentifier NULL,
	DesignImageBackVersion int NULL
GO
ALTER TABLE dbo.pStyleColorwaySeasonYear ADD CONSTRAINT
	DF_pStyleColorwaySeasonYear_DesignImageFrontID DEFAULT ('00000000-0000-0000-0000-000000000000') FOR DesignImageFrontID
GO
ALTER TABLE dbo.pStyleColorwaySeasonYear ADD CONSTRAINT
	DF_pStyleColorwaySeasonYear_DesignImageFrontVersion DEFAULT ((0)) FOR DesignImageFrontVersion
GO
ALTER TABLE dbo.pStyleColorwaySeasonYear ADD CONSTRAINT
	DF_pStyleColorwaySeasonYear_DesignImageBackID DEFAULT ('00000000-0000-0000-0000-000000000000') FOR DesignImageBackID
GO
ALTER TABLE dbo.pStyleColorwaySeasonYear ADD CONSTRAINT
	DF_pStyleColorwaySeasonYear_DesignImageBackVersion DEFAULT ((0)) FOR DesignImageBackVersion
GO
ALTER TABLE dbo.pStyleColorwaySeasonYear SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03173', GetDate())

GO
