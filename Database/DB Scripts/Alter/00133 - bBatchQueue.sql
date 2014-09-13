/****** Object:  Table [dbo].[bBatchQueue]    Script Date: 06/03/2010 09:22:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bBatchQueue](
	[BatchQueueID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TeamID] [uniqueidentifier] NOT NULL,
	[BatchQueueTypeID] [uniqueidentifier] NOT NULL,
	[ItemID] [uniqueidentifier] NOT NULL,
	[ItemDescription] [nvarchar](200) NOT NULL,
	[BatchQueueXMLData] [text] NULL,
	[BatchQueueStatusID] [uniqueidentifier] NOT NULL,
	[BatchQueueComments] [nvarchar](200) NULL,
	[CUser] [nvarchar](25) NOT NULL,
	[CDate] [datetime] NOT NULL,
	[MUser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_bBatchQueue] PRIMARY KEY CLUSTERED 
(
	[BatchQueueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[bBatchQueue] ADD  CONSTRAINT [DF_bBatchQueue_BatchQueueID]  DEFAULT (newid()) FOR [BatchQueueID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '133', GetDate())
GO
