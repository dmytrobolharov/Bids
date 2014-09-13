
/****** Object:  Table [dbo].[pStyleBOMDimensionItem]    Script Date: 09/06/2011 09:45:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMDimensionItem](
	[StyleBOMDimensionItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NOT NULL,
	[WorkFlowID] [uniqueidentifier] NOT NULL,
	[WorkFlowItemID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NOT NULL,
	[StyleSet] [int] NOT NULL,
	[ItemDim1TypeId] [uniqueidentifier] NULL,
	[ItemDim2TypeId] [uniqueidentifier] NULL,
	[ItemDim3TypeId] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[ItemDim1Name] [nvarchar](50) NULL,
	[ItemDim2Name] [nvarchar](50) NULL,
	[ItemDim3Name] [nvarchar](50) NULL,
	[ItemDim1Sort] [int] NULL,
	[ItemDim2Sort] [int] NULL,
	[ItemDim3Sort] [int] NULL,
	[ItemDim1Active] [int] NULL,
	[ItemDim2Active] [int] NULL,
	[ItemDim3Active] [int] NULL,
	[Comments] [nvarchar](510) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pStyleBOMDimensionItem] PRIMARY KEY CLUSTERED 
(
	[StyleBOMDimensionItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOMDimensionItem] ADD  CONSTRAINT [DF_pStyleBOMDimensionItem_StyleBOMDimensionItemID]  DEFAULT (newid()) FOR [StyleBOMDimensionItemID]
GO

ALTER TABLE [dbo].[pStyleBOMDimensionItem] ADD  CONSTRAINT [DF_pStyleBOMDimensionItem_ItemDim1Sort]  DEFAULT ((0)) FOR [ItemDim1Sort]
GO

ALTER TABLE [dbo].[pStyleBOMDimensionItem] ADD  CONSTRAINT [DF_pStyleBOMDimensionItem_ItemDim2Sort]  DEFAULT ((0)) FOR [ItemDim2Sort]
GO

ALTER TABLE [dbo].[pStyleBOMDimensionItem] ADD  CONSTRAINT [DF_pStyleBOMDimensionItem_ItemDim3Sort]  DEFAULT ((0)) FOR [ItemDim3Sort]
GO

ALTER TABLE [dbo].[pStyleBOMDimensionItem] ADD  CONSTRAINT [DF_pStyleBOMDimensionItem_ItemDim1Active]  DEFAULT ((1)) FOR [ItemDim1Active]
GO

ALTER TABLE [dbo].[pStyleBOMDimensionItem] ADD  CONSTRAINT [DF_pStyleBOMDimensionItem_ItemDim2Active]  DEFAULT ((1)) FOR [ItemDim2Active]
GO

ALTER TABLE [dbo].[pStyleBOMDimensionItem] ADD  CONSTRAINT [DF_pStyleBOMDimensionItem_ItemDim3Active]  DEFAULT ((1)) FOR [ItemDim3Active]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01853'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01853', GetDate())
	END

	GO