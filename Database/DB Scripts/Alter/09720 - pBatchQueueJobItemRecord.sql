IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueueJobItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord] DROP CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueueJobItem]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueueJob]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord] DROP CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueueJob]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueue]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord] DROP CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueue]
GO

/****** Object:  Table [dbo].[pBatchQueueJobItemRecord]    Script Date: 26.02.2015 15:22:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]') AND type in (N'U'))
DROP TABLE [dbo].[pBatchQueueJobItemRecord]
GO

/****** Object:  Table [dbo].[pBatchQueueJobItemRecord]    Script Date: 26.02.2015 15:22:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pBatchQueueJobItemRecord](
	[BatchQueueJobItemRecordID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pBatchQueueJobItemRecord_BatchQueueJobItemsID]  DEFAULT (newsequentialid()),
	[BatchQueueJobItemID] [uniqueidentifier] NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[BatchQueuePageID] [uniqueidentifier] NULL,
	[BatchQueuePagePki] [uniqueidentifier] NOT NULL,
	[BatchQueueId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pBatchQueueJobItems] PRIMARY KEY CLUSTERED 
(
	[BatchQueueJobItemRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueue]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord]  WITH CHECK ADD  CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueue] FOREIGN KEY([BatchQueueId])
REFERENCES [dbo].[pBatchQueue] ([BatchQueueID])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueue]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord] CHECK CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueue]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueueJob]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord]  WITH CHECK ADD  CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueueJob] FOREIGN KEY([BatchQueueJobID])
REFERENCES [dbo].[pBatchQueueJob] ([BatchQueueJobID])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueueJob]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord] CHECK CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueueJob]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueueJobItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord]  WITH CHECK ADD  CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueueJobItem] FOREIGN KEY([BatchQueueJobItemID])
REFERENCES [dbo].[pBatchQueueJobItem] ([BatchQueueJobItemID])
ON DELETE CASCADE
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBatchQueueJobItems_pBatchQueueJobItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItemRecord]'))
ALTER TABLE [dbo].[pBatchQueueJobItemRecord] CHECK CONSTRAINT [FK_pBatchQueueJobItems_pBatchQueueJobItem]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09720', GetDate())
GO

