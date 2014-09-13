
/****** Object:  Table [dbo].[pConPageDetail]    Script Date: 07/16/2010 17:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pConPageDetail](
	[PageId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConPageDetail_PageId]  DEFAULT (newid()),
	[Row_Id] [int] NOT NULL CONSTRAINT [DF_pConPageDetail_Row_Id]  DEFAULT ((0)),
	[Detail] [text] NULL,
	[OrigOperationSN] [uniqueidentifier] NULL,
	[Level1Desc] [nvarchar](100) NULL,
	[Level2Desc] [nvarchar](100) NULL,
	[Level3Desc] [nvarchar](100) NULL,
	[ImageID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_ImageID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
	[AuxField1] [nvarchar](100) NULL,
	[AuxField2] [nvarchar](100) NULL,
	[AuxField3] [nvarchar](100) NULL,
	[AuxField4] [nvarchar](100) NULL,
	[AuxField5] [nvarchar](100) NULL,
	[Linked] [int] NULL,
	[Level1ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_Level1ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
	[Level2ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_Level2ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
	[Level3ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_Level3ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
 CONSTRAINT [PK_pConPageDetail] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC,
	[Row_Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
