/*
   Monday, July 02, 201212:12:44 PM
   User: Shashi
   Server: (local)
   Database: plmon42x
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
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_ConstructionDetailID
GO
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_StyleID
GO
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_WorkflowID
GO
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_OrigOperationSN
GO
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_Level1ID
GO
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_Level2ID
GO
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_Level3ID
GO
ALTER TABLE dbo.pConPageDetail
	DROP CONSTRAINT DF_pConPageDetail_Level0ID
GO
CREATE TABLE dbo.Tmp_pConPageDetail
	(
	ConstructionDetailID uniqueidentifier NOT NULL ROWGUIDCOL,
	StyleID uniqueidentifier NULL,
	WorkflowID uniqueidentifier NULL,
	Sort nvarchar(5) NULL,
	StyleSet int NULL,
	Detail ntext NULL,
	OrigOperationSN uniqueidentifier NULL,
	Level1Desc nvarchar(100) NULL,
	Level2Desc nvarchar(100) NULL,
	Level3Desc nvarchar(100) NULL,
	ImageID uniqueidentifier NULL,
	AuxField1 nvarchar(100) NULL,
	AuxField2 nvarchar(100) NULL,
	AuxField3 nvarchar(100) NULL,
	AuxField4 nvarchar(100) NULL,
	AuxField5 nvarchar(100) NULL,
	Linked int NULL,
	Level1ID uniqueidentifier NULL,
	Level2ID uniqueidentifier NULL,
	Level3ID uniqueidentifier NULL,
	CUser nvarchar(200) NULL,
	CDate datetime NULL,
	MUser nvarchar(200) NULL,
	MDate datetime NULL,
	WorkFlowItemId uniqueidentifier NULL,
	Level0ID uniqueidentifier NULL,
	Level0Desc nvarchar(100) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_pConPageDetail SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_ConstructionDetailID DEFAULT (newid()) FOR ConstructionDetailID
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_StyleID DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR StyleID
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_WorkflowID DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR WorkflowID
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_OrigOperationSN DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR OrigOperationSN
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_Level1ID DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR Level1ID
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_Level2ID DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR Level2ID
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_Level3ID DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR Level3ID
GO
ALTER TABLE dbo.Tmp_pConPageDetail ADD CONSTRAINT
	DF_pConPageDetail_Level0ID DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR Level0ID
GO
IF EXISTS(SELECT * FROM dbo.pConPageDetail)
	 EXEC('INSERT INTO dbo.Tmp_pConPageDetail (ConstructionDetailID, StyleID, WorkflowID, Sort, StyleSet, Detail, OrigOperationSN, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3, AuxField4, AuxField5, Linked, Level1ID, Level2ID, Level3ID, CUser, CDate, MUser, MDate, WorkFlowItemId, Level0ID, Level0Desc)
		SELECT ConstructionDetailID, StyleID, WorkflowID, Sort, StyleSet, CONVERT(ntext, Detail), OrigOperationSN, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3, AuxField4, AuxField5, Linked, Level1ID, Level2ID, Level3ID, CUser, CDate, MUser, MDate, WorkFlowItemId, Level0ID, Level0Desc FROM dbo.pConPageDetail WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.pConPageDetail
GO
EXECUTE sp_rename N'dbo.Tmp_pConPageDetail', N'pConPageDetail', 'OBJECT' 
GO
ALTER TABLE dbo.pConPageDetail ADD CONSTRAINT
	PK_pConPageDetail_1 PRIMARY KEY CLUSTERED 
	(
	ConstructionDetailID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IX_pConPageDetail_1 ON dbo.pConPageDetail
	(
	Level1ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_pConPageDetail_2 ON dbo.pConPageDetail
	(
	Level2ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_pConPageDetail_3 ON dbo.pConPageDetail
	(
	Level3ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_pConPageDetailSID ON dbo.pConPageDetail
	(
	StyleID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_pConPageDetailWFID ON dbo.pConPageDetail
	(
	WorkflowID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_pConPageDetailWFIID ON dbo.pConPageDetail
	(
	WorkFlowItemId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_pConPageDetail_0 ON dbo.pConPageDetail
	(
	Level0ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
COMMIT

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03683', GetDate())
GO