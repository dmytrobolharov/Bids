/****** Object:  Table [dbo].[bBatchQueueType]    Script Date: 06/03/2010 09:22:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bBatchQueueType](
	[BatchQueueTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueTypeDescription] [nvarchar](100) NOT NULL,
	[BatchQueueTypeURL] [nvarchar](200) NOT NULL,
	[BatchQueueTypeSchema] [nvarchar](200) NOT NULL,
	[BatchQueueTypeSearchSchema] [nvarchar](200) NOT NULL,
	[BatchQueueTypeIcon] [nvarchar](200) NULL,
	[BatchQueueSort] [nvarchar] (4) NOT NULL,
	[ItemURL] [nvarchar](200) NULL,
	[CUser] [nvarchar](25) NOT NULL,
	[CDate] [datetime] NOT NULL,
	[MUser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_bBatchQueueType] PRIMARY KEY CLUSTERED 
(
	[BatchQueueTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].[bBatchQueueType] ADD  CONSTRAINT [DF_bBatchQueueType_BatchQueueTypeID]  DEFAULT (newid()) FOR [BatchQueueTypeID]
GO


INSERT INTO dbo.bBatchQueueType (BatchQueueTypeDescription, BatchQueueTypeURL, BatchQueueTypeSchema, BatchQueueTypeSearchSchema, BatchQueueTypeIcon, BatchQueueSort, ItemURL, CUser, CDate)
VALUES('Tech Pack', 'BatchQueue_TechPack.aspx', 'BatchQueue_TechPack_Default.xml', 'BatchQueue_TechPack_Search.xml', NULL, '0001', '../Style/Style_Frame.aspx?SID={0}', 'System', GetDate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '135', GetDate())
GO
