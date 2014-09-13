/****** Object:  Table [dbo].[pStyleBOM]    Script Date: 09/06/2011 09:44:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pStyleBOM](
	[StyleMaterialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleMaterialMasterID] [uniqueidentifier] NULL,
	[CopyStyleMaterialID] [uniqueidentifier] NULL,
	[MainMaterial] [int] NULL,
	[Development] [bit] NULL,
	[MiscColor] [bit] NULL,
	[StyleSet] [int] NOT NULL,
	[StyleID] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[WorkflowItemId] [uniqueidentifier] NOT NULL,
	[StyleBOMDimensionId] [uniqueidentifier] NOT NULL,
	[Dim1TypeSel] [int] NULL,
	[Dim2TypeSel] [int] NULL,
	[Dim3TypeSel] [int] NULL,
	[UOM] [nvarchar](50) NULL,
	[Qty] [nvarchar](18) NULL,
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
	[Source] [nvarchar](200) NULL,
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
	[MaterialSort] [varchar](5) NULL,
	[MaterialTrack] [int] NULL,
	[MaterialLinked] [int] NOT NULL,
	[MaterialDimension] [int] NULL,
	[MaterialSizeA0] [nvarchar](100) NULL,
	[MaterialSizeA1] [nvarchar](100) NULL,
	[MaterialSizeA2] [nvarchar](100) NULL,
	[MaterialSizeA3] [nvarchar](100) NULL,
	[MaterialSizeA4] [nvarchar](100) NULL,
	[MaterialSizeA5] [nvarchar](100) NULL,
	[MaterialSizeA6] [nvarchar](100) NULL,
	[MaterialSizeA7] [nvarchar](100) NULL,
	[MaterialSizeA8] [nvarchar](100) NULL,
	[MaterialSizeA9] [nvarchar](100) NULL,
	[MaterialSizeA10] [nvarchar](100) NULL,
	[MaterialSizeA11] [nvarchar](100) NULL,
	[MaterialSizeA12] [nvarchar](100) NULL,
	[MaterialSizeA13] [nvarchar](100) NULL,
	[MaterialSizeA14] [nvarchar](100) NULL,
	[MaterialSizeA15] [nvarchar](100) NULL,
	[MaterialSizeA16] [nvarchar](100) NULL,
	[MaterialSizeA17] [nvarchar](100) NULL,
	[MaterialSizeA18] [nvarchar](100) NULL,
	[MaterialSizeA19] [nvarchar](100) NULL,
	[MaterialSizeB0] [nvarchar](100) NULL,
	[MaterialSizeB1] [nvarchar](100) NULL,
	[MaterialSizeB2] [nvarchar](100) NULL,
	[MaterialSizeB3] [nvarchar](100) NULL,
	[MaterialSizeB4] [nvarchar](100) NULL,
	[MaterialSizeB5] [nvarchar](100) NULL,
	[MaterialSizeB6] [nvarchar](100) NULL,
	[MaterialSizeB7] [nvarchar](100) NULL,
	[MaterialSizeB8] [nvarchar](100) NULL,
	[MaterialSizeB9] [nvarchar](100) NULL,
	[MaterialSizeB10] [nvarchar](100) NULL,
	[MaterialSizeB11] [nvarchar](100) NULL,
	[MaterialSizeB12] [nvarchar](100) NULL,
	[MaterialSizeB13] [nvarchar](100) NULL,
	[MaterialSizeB14] [nvarchar](100) NULL,
	[MaterialSizeB15] [nvarchar](100) NULL,
	[MaterialSizeB16] [nvarchar](100) NULL,
	[MaterialSizeB17] [nvarchar](100) NULL,
	[MaterialSizeB18] [nvarchar](100) NULL,
	[MaterialSizeB19] [nvarchar](100) NULL,
	[MaterialLining] [int] NULL,
	[MaterialSizeID] [uniqueidentifier] NULL,
	[MaterialColorId] [uniqueidentifier] NULL,
	[MaterialPackLabelGroupID] [uniqueidentifier] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[MaterialBOM] [int] NULL,
	[MaterialCode] [varchar](50) NULL,
	[StyleMaterialLinkID] [uniqueidentifier] NULL,
	[MultiCloth] [int] NOT NULL,
	[MaterialCoreItemID] [uniqueidentifier] NULL,
	[MaterialSwing] [int] NULL,
	[MaterialLinkID] [uniqueidentifier] NULL,
	[MultiMaterialParentID] [uniqueidentifier] NULL,
	[WebPDMCustom_Category] [nvarchar](100) NULL,
	[WebPDMCustom_SubCategory] [nvarchar](100) NULL,
	[WebPDMCustom_ItemTypeCode] [nvarchar](100) NULL,
	[WebPDMCustom_Approved] [int] NULL,
	[WebPDMCustom_Content] [nvarchar](510) NULL,
	[WebPDMCustom_Finish] [nvarchar](100) NULL,
	[WebPDMCustom_Construction] [nvarchar](100) NULL,
	[WebPDMCustom_GroupDesc] [nvarchar](100) NULL,
	[WebPDMCustom_Dutiable] [int] NULL,
	[WebPDMCustom_WasteFactor] [float] NULL,
	[WebPDMCustom_UOM] [nvarchar](100) NULL,
	[WebPDMCustom_UOMPurchase] [nvarchar](100) NULL,
	[WebPDMCustom_Comments] [nvarchar](510) NULL,
 CONSTRAINT [PK_pStyleBOM] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pStyleBOM', @level2type=N'COLUMN',@level2name=N'MaterialSizeA10'
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_StyleMaterialID]  DEFAULT (newid()) FOR [StyleMaterialID]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MainMaterial]  DEFAULT ((0)) FOR [MainMaterial]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_Artwork]  DEFAULT ((1)) FOR [Artwork]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_License]  DEFAULT ((1)) FOR [License]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_Colorway]  DEFAULT ((1)) FOR [Colorway]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSort]  DEFAULT ('0000') FOR [MaterialSort]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialTrack]  DEFAULT ((1)) FOR [MaterialTrack]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialLinked]  DEFAULT ((1)) FOR [MaterialLinked]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialDimension]  DEFAULT ((0)) FOR [MaterialDimension]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA0]  DEFAULT ((0)) FOR [MaterialSizeA0]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA1]  DEFAULT ((0)) FOR [MaterialSizeA1]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA2]  DEFAULT ((0)) FOR [MaterialSizeA2]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA3]  DEFAULT ((0)) FOR [MaterialSizeA3]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA4]  DEFAULT ((0)) FOR [MaterialSizeA4]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA5]  DEFAULT ((0)) FOR [MaterialSizeA5]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA6]  DEFAULT ((0)) FOR [MaterialSizeA6]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA7]  DEFAULT ((0)) FOR [MaterialSizeA7]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA8]  DEFAULT ((0)) FOR [MaterialSizeA8]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA9]  DEFAULT ((0)) FOR [MaterialSizeA9]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA10]  DEFAULT ((0)) FOR [MaterialSizeA10]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA11]  DEFAULT ((0)) FOR [MaterialSizeA11]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA13]  DEFAULT ((0)) FOR [MaterialSizeA13]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA14]  DEFAULT ((0)) FOR [MaterialSizeA14]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA15]  DEFAULT ((0)) FOR [MaterialSizeA15]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA16]  DEFAULT ((0)) FOR [MaterialSizeA16]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA17]  DEFAULT ((0)) FOR [MaterialSizeA17]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA18]  DEFAULT ((0)) FOR [MaterialSizeA18]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeA19]  DEFAULT ((0)) FOR [MaterialSizeA19]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB0]  DEFAULT ((0)) FOR [MaterialSizeB0]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB1]  DEFAULT ((0)) FOR [MaterialSizeB1]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB2]  DEFAULT ((0)) FOR [MaterialSizeB2]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB3]  DEFAULT ((0)) FOR [MaterialSizeB3]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB4]  DEFAULT ((0)) FOR [MaterialSizeB4]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB5]  DEFAULT ((0)) FOR [MaterialSizeB5]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB6]  DEFAULT ((0)) FOR [MaterialSizeB6]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB7]  DEFAULT ((0)) FOR [MaterialSizeB7]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB8]  DEFAULT ((0)) FOR [MaterialSizeB8]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB9]  DEFAULT ((0)) FOR [MaterialSizeB9]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB10]  DEFAULT ((0)) FOR [MaterialSizeB10]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB11]  DEFAULT ((0)) FOR [MaterialSizeB11]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB12]  DEFAULT ((0)) FOR [MaterialSizeB12]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB13]  DEFAULT ((0)) FOR [MaterialSizeB13]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB14]  DEFAULT ((0)) FOR [MaterialSizeB14]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB15]  DEFAULT ((0)) FOR [MaterialSizeB15]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB16]  DEFAULT ((0)) FOR [MaterialSizeB16]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB17]  DEFAULT ((0)) FOR [MaterialSizeB17]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB18]  DEFAULT ((0)) FOR [MaterialSizeB18]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialSizeB19]  DEFAULT ((0)) FOR [MaterialSizeB19]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialLining]  DEFAULT ((0)) FOR [MaterialLining]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MaterialBOM]  DEFAULT ((1)) FOR [MaterialBOM]
GO

ALTER TABLE [dbo].[pStyleBOM] ADD  CONSTRAINT [DF_pStyleBOM_MultiCloth]  DEFAULT ((0)) FOR [MultiCloth]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01851'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01851', GetDate())
	END

	GO