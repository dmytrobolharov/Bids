
/****** Object:  Table [dbo].[pConstructTree]    Script Date: 07/09/2010 14:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pConstructTree](
	[SerialNumber] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConstructTree_SerialNumber]  DEFAULT (newid()),
	[Level1ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConstructTree_Level1ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
	[Level2ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConstructTree_Level2ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
	[Level3ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConstructTree_Level3ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
 CONSTRAINT [PK_pConstructTree] PRIMARY KEY CLUSTERED 
(
	[SerialNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
