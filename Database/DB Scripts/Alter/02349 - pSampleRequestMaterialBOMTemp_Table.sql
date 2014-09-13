-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestMaterialBOMTemp_SampleRequestMaterialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestMaterialBOMTemp] DROP CONSTRAINT [DF_pSampleRequestMaterialBOMTemp_SampleRequestMaterialID]
END

GO



/****** Object:  Table [dbo].[pSampleRequestMaterialBOMTemp]    Script Date: 12/18/2011 17:38:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestMaterialBOMTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestMaterialBOMTemp]
GO



/****** Object:  Table [dbo].[pSampleRequestMaterialBOMTemp]    Script Date: 12/18/2011 17:38:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestMaterialBOMTemp](
	[SampleRequestMaterialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Submit] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[RecDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Status] [nvarchar](200) NULL,
	[SampleRequestGroupID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[StyleMaterialID] [uniqueidentifier] NULL,
	[MainMaterial] [int] NULL,
	[Development] [bit] NULL,
	[MiscColor] [bit] NULL,
	[UOM] [nvarchar](50) NULL,
	[Qty] [nvarchar](18) NULL,
	[MaterialPrice] [money] NULL,
	[Ext] [money] NULL,
	[MaterialSize] [nvarchar](100) NULL,
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
	[CUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MChange] [int] NULL,
	[SChange] [int] NULL,
	[DChange] [int] NULL,
	[CChange] [int] NULL,
	[Action] [nvarchar](50) NULL,
	[ColorPlacement] [nvarchar](4000) NULL,
	[Artwork] [nvarchar](3) NOT NULL,
	[License] [nvarchar](3) NOT NULL,
	[Colorway] [nvarchar](3) NOT NULL,
	[MaterialComment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_pSampleRequestMaterialBOMTemp] PRIMARY KEY CLUSTERED 
(
	[SampleRequestMaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestMaterialBOMTemp] ADD  CONSTRAINT [DF_pSampleRequestMaterialBOMTemp_SampleRequestMaterialID]  DEFAULT (newid()) FOR [SampleRequestMaterialID]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02349'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02349', GetDate())

END

GO

