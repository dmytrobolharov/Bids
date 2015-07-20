/****** Object:  Table [dbo].[bBatchQueueStatus]    Script Date: 06/03/2010 09:22:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bBatchQueueStatus](
	[BatchQueueStatusID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueStatusDescription] [nvarchar](200) NOT NULL,
	[BatchQueueStatusIcon] [nvarchar](200) NULL,
	[CUser] [nvarchar](25) NOT NULL,
	[CDate] [datetime] NOT NULL,
	[MUser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_bBatchQueueStatus] PRIMARY KEY CLUSTERED 
(
	[BatchQueueStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].[bBatchQueueStatus] ADD  CONSTRAINT [DF_bBatchQueueStatus_BatchQueueStatusID]  DEFAULT (newid()) FOR [BatchQueueStatusID]
GO


INSERT INTO bBatchQueueStatus (BatchQueueStatusDescription, BatchQueueStatusIcon, CUser, CDate)
VALUES('Pending', '../System/Icons/0.gif', 'System', GetDate())
GO

INSERT INTO bBatchQueueStatus (BatchQueueStatusDescription, BatchQueueStatusIcon, CUser, CDate)
VALUES('Error', '../System/Icons/1.gif', 'System', GetDate())
GO

INSERT INTO bBatchQueueStatus (BatchQueueStatusDescription, BatchQueueStatusIcon, CUser, CDate)
VALUES('In Progress', '../System/Icons/2.gif', 'System', GetDate())
GO

INSERT INTO bBatchQueueStatus (BatchQueueStatusDescription, BatchQueueStatusIcon, CUser, CDate)
VALUES('Complete', '../System/Icons/3.gif', 'System', GetDate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '134', GetDate())
GO
