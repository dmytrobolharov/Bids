

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueue' 
    AND  COLUMN_NAME = 'BatchQueuePageHistoryUrl')
	ALTER TABLE [dbo].[pBatchQueue] ADD [BatchQueuePageHistoryUrl] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
	
GO


IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueueJob' 
    AND  COLUMN_NAME = 'Description')
	ALTER TABLE [dbo].[pBatchQueueJob] ADD [Description] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO


IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueuePageType' 
    AND  COLUMN_NAME = 'BatchQueueExecuteSPX')
	ALTER TABLE pBatchQueuePageType ADD	[BatchQueueExecuteSPX] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueuePageType' 
    AND  COLUMN_NAME = 'BatchQueueLogicInsertSPX')
	ALTER TABLE pBatchQueuePageType ADD	[BatchQueueLogicInsertSPX] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO


IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueuePageType' 
    AND  COLUMN_NAME = 'BatchQueuepageXMLGridAlternating')
	ALTER TABLE pBatchQueuePageType ADD	BatchQueuepageXMLGridAlternating [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueuePageType' 
    AND  COLUMN_NAME = 'BatchQueueGridAlternatingName')
	ALTER TABLE pBatchQueuePageType ADD	[BatchQueueGridAlternatingName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueuePageType' 
    AND  COLUMN_NAME = 'BatchQueueGridXMLThumbnail')
	ALTER TABLE pBatchQueuePageType ADD	[BatchQueueGridXMLThumbnail] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBatchQueuePageType' 
    AND  COLUMN_NAME = 'BatchQueuePageXmlColorGrid')
	ALTER TABLE pBatchQueuePageType ADD	[BatchQueuePageXmlColorGrid] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pLinePlanColorItemTemp' 
    AND  COLUMN_NAME = 'TeamID')
	ALTER TABLE dbo.pLinePlanColorItemTemp ADD [TeamID] [uniqueidentifier] NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pLinePlanMaterialItemTemp' 
    AND  COLUMN_NAME = 'TeamID')
	ALTER TABLE dbo.pLinePlanMaterialItemTemp ADD [TeamID] [uniqueidentifier] NULL
GO

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleMaterials' 
    AND  COLUMN_NAME = 'BatchQJobID')
	ALTER TABLE dbo.pStyleMaterials ADD BatchQJobID [uniqueidentifier] NULL
GO


IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleMaterialTemp' 
    AND  COLUMN_NAME = 'BatchQJobID')
	ALTER TABLE dbo.pStyleMaterialTemp ADD BatchQJobID [uniqueidentifier] NULL
GO




IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01541'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01541', GetDate())
END	

GO
