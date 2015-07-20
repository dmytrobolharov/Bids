/****** Object:  Table [dbo].[pStyleBOMTemp]    Script Date: 09/06/2011 09:46:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pStyleBOMTemp](
	[StyleMaterialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[MainMaterial] [int] NULL,
	[Development] [bit] NULL,
	[MiscColor] [bit] NULL,
	[StyleSet] [int] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[WorkflowId] [uniqueidentifier] NULL,
	[WorkflowItemId] [uniqueidentifier] NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NULL,
	[UOM] [nvarchar](50) NULL,
	[Qty] [decimal](18, 2) NULL,
	[MaterialPrice] [money] NULL,
	[Ext] [money] NULL,
	[MaterialSize] [nvarchar](200) NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[MaterialPlacement] [bit] NULL,
	[MaterialPlacementCode] [nvarchar](4) NULL,
	[MaterialPlacementDetail] [nvarchar](200) NULL,
	[MaterialImageID] [uniqueidentifier] NULL,
	[MaterialImageVersion] [int] NULL,
	[NoColorMatch] [int] NULL,
	[SupplierID] [nvarchar](50) NULL,
	[ComponentTypeID] [int] NULL,
	[MaterialType] [int] NULL,
	[MaterialNo] [nvarchar](50) NULL,
	[MaterialName] [nvarchar](200) NULL,
	[A] [nvarchar](100) NULL,
	[B] [nvarchar](100) NULL,
	[C] [nvarchar](100) NULL,
	[D] [nvarchar](100) NULL,
	[E] [nvarchar](100) NULL,
	[F] [nvarchar](100) NULL,
	[G] [nvarchar](100) NULL,
	[H] [nvarchar](100) NULL,
	[I] [nvarchar](100) NULL,
	[J] [nvarchar](100) NULL,
	[K] [nvarchar](100) NULL,
	[L] [nvarchar](100) NULL,
	[M] [nvarchar](100) NULL,
	[N] [nvarchar](100) NULL,
	[O] [nvarchar](100) NULL,
	[P] [nvarchar](100) NULL,
	[Q] [nvarchar](100) NULL,
	[R] [nvarchar](100) NULL,
	[S] [nvarchar](100) NULL,
	[T] [nvarchar](100) NULL,
	[U] [nvarchar](100) NULL,
	[V] [nvarchar](100) NULL,
	[W] [nvarchar](100) NULL,
	[X] [nvarchar](100) NULL,
	[Y] [nvarchar](100) NULL,
	[Z] [nvarchar](100) NULL,
	[Source] [nvarchar](50) NULL,
	[Notes] [nvarchar](4000) NULL,
	[Placement] [nvarchar](4000) NULL,
	[VendorPrice] [decimal](19, 3) NULL,
	[VolumePrice] [decimal](19, 3) NULL,
	[VolumePriceMinimum] [nvarchar](50) NULL,
	[VendorProductionMin] [nvarchar](50) NULL,
	[VendorProductionLeadTime] [nvarchar](50) NULL,
	[DetailYesNo] [int] NULL,
	[ImageType] [nvarchar](50) NULL,
	[height] [nvarchar](100) NULL,
	[width] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MChange] [int] NULL,
	[SChange] [int] NULL,
	[DChange] [int] NULL,
	[CChange] [int] NULL,
	[Action] [nvarchar](50) NULL,
	[ColorPlacement] [nvarchar](4000) NULL,
	[Artwork] [int] NOT NULL,
	[License] [int] NOT NULL,
	[Colorway] [int] NOT NULL,
	[MaterialPackLabelGroupID] [uniqueidentifier] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[MaterialBOM] [int] NULL,
	[MaterialLining] [int] NULL,
	[MaterialLinked] [int] NOT NULL,
	[MaterialTrack] [int] NULL,
	[MaterialDimension] [int] NULL,
	[MaterialSort] [varchar](5) NULL,
	[MaterialSizeID] [uniqueidentifier] NULL,
	[StyleMaterialLinkID] [uniqueidentifier] NULL,
	[MaterialCoreItemID] [uniqueidentifier] NULL,
	[MaterialSwing] [int] NULL,
 CONSTRAINT [PK_pStyleBOMTemp_StyleMaterialID] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_StyleMaterialID]  DEFAULT (newid()) FOR [StyleMaterialID]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_MainMaterial]  DEFAULT ((0)) FOR [MainMaterial]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_Qty]  DEFAULT ((0)) FOR [Qty]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_Artwork]  DEFAULT ((0)) FOR [Artwork]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_License]  DEFAULT ((0)) FOR [License]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_Colorway]  DEFAULT ((1)) FOR [Colorway]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_MaterialBOM]  DEFAULT ((1)) FOR [MaterialBOM]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_MaterialLining]  DEFAULT ((0)) FOR [MaterialLining]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_MaterialLinked]  DEFAULT ((1)) FOR [MaterialLinked]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_MaterialTrack]  DEFAULT ((0)) FOR [MaterialTrack]
GO

ALTER TABLE [dbo].[pStyleBOMTemp] ADD  CONSTRAINT [DF_pStyleBOMTemp_MaterialDimension]  DEFAULT ((0)) FOR [MaterialDimension]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01858'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01858', GetDate())
	END
	
	GO