/****** Object:  Table [dbo].[pStyleBOMItem]    Script Date: 09/06/2011 09:46:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMItem](
	[StyleBOMItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NOT NULL,
	[StyleBOMDimensionItemID] [uniqueidentifier] NULL,
	[StyleMaterialID] [uniqueidentifier] NOT NULL,
	[WorkFlowID] [uniqueidentifier] NOT NULL,
	[WorkFlowItemID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NOT NULL,
	[StyleSet] [int] NOT NULL,
	[ItemDim1TypeId] [uniqueidentifier] NULL,
	[ItemDim2TypeId] [uniqueidentifier] NULL,
	[ItemDim3TypeId] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim1Name] [nvarchar](50) NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim2Name] [nvarchar](50) NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[ItemDim3Name] [nvarchar](50) NULL,
	[ItemDim3ColSelId] [uniqueidentifier] NULL,
	[MaterialColorId] [uniqueidentifier] NULL,
	[MaterialQuantity] [float] NULL,
	[MaterialDimension] [uniqueidentifier] NULL,
	[MaterialPrice] [money] NULL,
	[Comments] [nvarchar](510) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pStyleBOMItem] PRIMARY KEY CLUSTERED 
(
	[StyleBOMItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOMItem] ADD  CONSTRAINT [DF_pStyleBOMItem_StyleBOMItemID]  DEFAULT (newid()) FOR [StyleBOMItemID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01857'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01857', GetDate())
	END
	
	GO