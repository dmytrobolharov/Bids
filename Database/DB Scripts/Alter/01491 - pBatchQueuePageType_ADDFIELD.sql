/*
   Wednesday, June 01, 20118:52:30 PM
   User: 
   Server: (local)
   Database: plmOn_BB
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
ALTER TABLE dbo.pBatchQueuePageType
	DROP CONSTRAINT DF_pBatchQueuePageType_BatchQueuePageTypeID
GO
CREATE TABLE dbo.Tmp_pBatchQueuePageType
	(
	BatchQueuePageTypeID uniqueidentifier NOT NULL ROWGUIDCOL,
	BatchQueuePageTypeName nvarchar(200) NULL,
	BatchQueuePageTypeDesc nvarchar(4000) NULL,
	BatchQueuePagePkID varchar(100) NULL,
	BatchQueuePageXmlSearch varchar(200) NULL,
	BatchQueuePageXmlForm varchar(200) NULL,
	BatchQueuePageXmlGrid varchar(200) NULL,
	BatchQueuePageXmlSelected varchar(200) NULL,
	BatchQueuePageUrl varchar(400) NULL,
	BatchQueuePageRecType varchar(10) NULL,
	BatchQueuePageRecMax int NULL,
	BatchQueuePageSPX varchar(400) NULL,
	CUser nvarchar(200) NULL,
	CDate datetime NULL,
	MUser nvarchar(200) NULL,
	MDate datetime NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_pBatchQueuePageType SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_pBatchQueuePageType ADD CONSTRAINT
	DF_pBatchQueuePageType_BatchQueuePageTypeID DEFAULT (newsequentialid()) FOR BatchQueuePageTypeID
GO
IF EXISTS(SELECT * FROM dbo.pBatchQueuePageType)
	 EXEC('INSERT INTO dbo.Tmp_pBatchQueuePageType (BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, BatchQueuePageXmlSearch, BatchQueuePageXmlForm, BatchQueuePageXmlGrid, BatchQueuePageXmlSelected, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, CUser, CDate, MUser, MDate)
		SELECT BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, BatchQueuePageXmlSearch, BatchQueuePageXmlForm, BatchQueuePageXmlGrid, BatchQueuePageXmlSelected, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, CUser, CDate, MUser, MDate FROM dbo.pBatchQueuePageType WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.pBatchQueuePageType
GO
EXECUTE sp_rename N'dbo.Tmp_pBatchQueuePageType', N'pBatchQueuePageType', 'OBJECT' 
GO
ALTER TABLE dbo.pBatchQueuePageType ADD CONSTRAINT
	PK_pBatchQueuePageType PRIMARY KEY CLUSTERED 
	(
	BatchQueuePageTypeID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01491', GetDate())
GO