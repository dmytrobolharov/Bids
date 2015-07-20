
/****** Object:  Table [dbo].[pQuickBatchReplace]    Script Date: 06/07/2010 17:15:56 ******/

CREATE TABLE [dbo].[pQuickBatchReplace](
	[QuickBRId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pQuickBatchReplace_QuickBRId]  DEFAULT (newid()),
	[QuickBRTypeId] [int] NOT NULL,
	[QuickBRName] [nvarchar](200)  NULL,
	[QuickBRDesc] [nvarchar](1000)  NULL,
	[QuickBROrder] [int] NULL,
	[QuickBRSchema] [nchar](10)  NULL,
	[QuickBRSearchSchema] [nvarchar](200) NULL,
	[QuickBRBatchSchema] [nvarchar](200)  NULL,
	[QuickBRGridSchema] [nvarchar](200)  NULL,
	[Active] [int] NOT NULL CONSTRAINT [DF_pQuickEditReplace_Active]  DEFAULT ((1)),
	[CUser] [nvarchar](200)  NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200)  NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pQuickBatchReplace_1] PRIMARY KEY CLUSTERED 
(
	[QuickBRId] ASC
)
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '119', GetDate())
GO