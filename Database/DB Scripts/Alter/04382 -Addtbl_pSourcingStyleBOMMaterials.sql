
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_StyleMaterialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_StyleMaterialID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MainMaterial]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MainMaterial]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_Artwork]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_Artwork]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_License]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_License]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_Colorway]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_Colorway]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialTrack]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialTrack]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialLinked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialLinked]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialDimension]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialDimension]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialLining]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialLining]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialBOM]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialBOM]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MultiCloth]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MultiCloth]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pSourcing__AUTOC__04DCFCE9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF__pSourcing__AUTOC__04DCFCE9]
END

GO


/****** Object:  Table [dbo].[pSourcingStyleBOMMaterials]    Script Date: 11/19/2012 16:52:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingStyleBOMMaterials]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingStyleBOMMaterials]
GO

/****** Object:  Table [dbo].[pSourcingStyleBOMMaterials]    Script Date: 11/19/2012 16:52:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pSourcingStyleBOMMaterials](
	[StyleMaterialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[SourcingStyleID] [uniqueidentifier] NULL,
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
	[AUTOCOLOR] [int] NULL,
 CONSTRAINT [PK_pSourcingStyleBOMMaterials] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pSourcingStyleBOMMaterials', @level2type=N'COLUMN',@level2name=N'MaterialSizeA10'
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_StyleMaterialID]  DEFAULT (newsequentialid()) FOR [StyleMaterialID]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MainMaterial]  DEFAULT ((0)) FOR [MainMaterial]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_Artwork]  DEFAULT ((1)) FOR [Artwork]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_License]  DEFAULT ((1)) FOR [License]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_Colorway]  DEFAULT ((1)) FOR [Colorway]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSort]  DEFAULT ('0000') FOR [MaterialSort]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialTrack]  DEFAULT ((1)) FOR [MaterialTrack]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialLinked]  DEFAULT ((1)) FOR [MaterialLinked]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialDimension]  DEFAULT ((0)) FOR [MaterialDimension]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA0]  DEFAULT ((0)) FOR [MaterialSizeA0]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA1]  DEFAULT ((0)) FOR [MaterialSizeA1]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA2]  DEFAULT ((0)) FOR [MaterialSizeA2]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA3]  DEFAULT ((0)) FOR [MaterialSizeA3]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA4]  DEFAULT ((0)) FOR [MaterialSizeA4]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA5]  DEFAULT ((0)) FOR [MaterialSizeA5]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA6]  DEFAULT ((0)) FOR [MaterialSizeA6]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA7]  DEFAULT ((0)) FOR [MaterialSizeA7]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA8]  DEFAULT ((0)) FOR [MaterialSizeA8]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA9]  DEFAULT ((0)) FOR [MaterialSizeA9]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA10]  DEFAULT ((0)) FOR [MaterialSizeA10]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA11]  DEFAULT ((0)) FOR [MaterialSizeA11]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA13]  DEFAULT ((0)) FOR [MaterialSizeA13]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA14]  DEFAULT ((0)) FOR [MaterialSizeA14]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA15]  DEFAULT ((0)) FOR [MaterialSizeA15]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA16]  DEFAULT ((0)) FOR [MaterialSizeA16]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA17]  DEFAULT ((0)) FOR [MaterialSizeA17]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA18]  DEFAULT ((0)) FOR [MaterialSizeA18]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA19]  DEFAULT ((0)) FOR [MaterialSizeA19]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB0]  DEFAULT ((0)) FOR [MaterialSizeB0]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB1]  DEFAULT ((0)) FOR [MaterialSizeB1]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB2]  DEFAULT ((0)) FOR [MaterialSizeB2]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB3]  DEFAULT ((0)) FOR [MaterialSizeB3]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB4]  DEFAULT ((0)) FOR [MaterialSizeB4]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB5]  DEFAULT ((0)) FOR [MaterialSizeB5]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB6]  DEFAULT ((0)) FOR [MaterialSizeB6]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB7]  DEFAULT ((0)) FOR [MaterialSizeB7]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB8]  DEFAULT ((0)) FOR [MaterialSizeB8]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB9]  DEFAULT ((0)) FOR [MaterialSizeB9]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB10]  DEFAULT ((0)) FOR [MaterialSizeB10]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB11]  DEFAULT ((0)) FOR [MaterialSizeB11]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB12]  DEFAULT ((0)) FOR [MaterialSizeB12]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB13]  DEFAULT ((0)) FOR [MaterialSizeB13]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB14]  DEFAULT ((0)) FOR [MaterialSizeB14]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB15]  DEFAULT ((0)) FOR [MaterialSizeB15]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB16]  DEFAULT ((0)) FOR [MaterialSizeB16]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB17]  DEFAULT ((0)) FOR [MaterialSizeB17]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB18]  DEFAULT ((0)) FOR [MaterialSizeB18]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB19]  DEFAULT ((0)) FOR [MaterialSizeB19]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialLining]  DEFAULT ((0)) FOR [MaterialLining]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialBOM]  DEFAULT ((1)) FOR [MaterialBOM]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_MultiCloth]  DEFAULT ((0)) FOR [MultiCloth]
GO

ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] ADD  CONSTRAINT [DF_pSourcingStyleBOMMaterials_AUTOCOLOR]  DEFAULT ((0)) FOR [AUTOCOLOR]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04382', GetDate())
GO