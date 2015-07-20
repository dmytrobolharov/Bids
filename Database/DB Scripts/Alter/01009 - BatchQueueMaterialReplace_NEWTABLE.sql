

CREATE TABLE [dbo].[bBatchQueueMaterialReplace](
	[BatchQueueMaterialReplaceID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueTypeID] [uniqueidentifier] NULL,
	[MaterialFindID] [uniqueidentifier] NULL,
	[MaterialReplaceID] [uniqueidentifier] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_bBatchQueueMaterialReplace] PRIMARY KEY CLUSTERED 
(
	[BatchQueueMaterialReplaceID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[bBatchQueueMaterialReplaceStyle](
	[BatchQueueMaterialReplaceStyleID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueMaterialReplaceID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[MaterialFindID] [uniqueidentifier] NULL,
	[MaterialReplaceID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_bBatchQueueMaterialReplaceStyle] PRIMARY KEY CLUSTERED 
(
	[BatchQueueMaterialReplaceStyleID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[bBatchQueueMaterialReplace] ADD  CONSTRAINT [DF_bBatchQueueMaterialReplace_BatchQueueMaterialReplaceID]  DEFAULT (newid()) FOR [BatchQueueMaterialReplaceID]
GO

ALTER TABLE [dbo].[bBatchQueueMaterialReplace] ADD  CONSTRAINT [DF_bBatchQueueMaterialReplace_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

ALTER TABLE [dbo].[bBatchQueueMaterialReplace] ADD  CONSTRAINT [DF_bBatchQueueMaterialReplace_MDate]  DEFAULT (getdate()) FOR [MDate]
GO

ALTER TABLE [dbo].[bBatchQueueMaterialReplaceStyle] ADD  CONSTRAINT [DF_bBatchQueueMaterialReplaceStyle_BatchQueueMaterialReplaceStyleID]  DEFAULT (newid()) FOR [BatchQueueMaterialReplaceStyleID]
GO

DELETE FROM bBatchQueueType WHERE BatchQueueTypeID = '5CF80E0E-BA32-4CE5-90E9-A8BA833DB861'
GO
DELETE FROM bBatchQueueType WHERE BatchQueueTypeID = '5CF80E0E-BA32-4CE5-90E9-A8BA833DB862'
GO
INSERT INTO bBatchQueueType(BatchQueueTypeID, BatchQueueTypeDescription, BatchQueueTypeURL, BatchQueueTypeSchema, BatchQueueTypeSearchSchema, BatchQueueTypeIcon, BatchQueueSort, ItemURL, CUser, CDate, MUser, MDate) VALUES ('5CF80E0E-BA32-4CE5-90E9-A8BA833DB861', N'Tech Pack Queue', N'BatchQueue_TechPack.aspx', N'BatchQueue_TechPack_Default.xml', N'BatchQueue_TechPack_Search.xml', N'icon_package.gif', N'0001', N'../Style/Style_Frame.aspx?SID={0}', N'System', '2010-08-13 08:56:34.97', null, null)
GO
INSERT INTO bBatchQueueType(BatchQueueTypeID, BatchQueueTypeDescription, BatchQueueTypeURL, BatchQueueTypeSchema, BatchQueueTypeSearchSchema, BatchQueueTypeIcon, BatchQueueSort, ItemURL, CUser, CDate, MUser, MDate) VALUES ('5CF80E0E-BA32-4CE5-90E9-A8BA833DB862', N'Material Replace', N'BatchQueue_MaterialReplace.aspx', N'BatchQueue_MaterialReplace_Default.xml', N'BatchQueue_MaterialReplace_Search.xml', N'icon_replace.gif', N'0002', null, N'System', '2011-01-14 00:00:00.0', null, null)
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01009', GetDate())
GO
