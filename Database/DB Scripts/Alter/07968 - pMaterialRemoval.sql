IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialRemoval_MaterialRemovalID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialRemoval] DROP CONSTRAINT [DF_pMaterialRemoval_MaterialRemovalID]
END

GO

/****** Object:  Table [dbo].[pMaterialRemoval]    Script Date: 06/11/2014 13:24:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRemoval]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialRemoval]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pMaterialRemoval](
	[MaterialRemovalID] [uniqueidentifier] NOT NULL,
	[RemovalTeamID] [uniqueidentifier] NULL,
	[RemovalReasonID] [uniqueidentifier] NULL,
	[RemovalComment] [nvarchar](500) NULL,
	[RemovalDate] [datetime] NULL,
	[MaterialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TempID] [nvarchar](20) NULL,
	[TempNo] [nvarchar](20) NULL,
	[MaterialImageID] [uniqueidentifier] NULL,
	[MaterialImageVersion] [int] NULL,
	[MaterialImageDetailID] [uniqueidentifier] NULL,
	[MaterialImageDetailVersion] [int] NULL,
	[NoColorMatch] [int] NULL,
	[SupplierID] [nvarchar](50) NULL,
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
	[VendorPrice] [money] NOT NULL,
	[VolumePrice] [money] NOT NULL,
	[VolumePriceMinimum] [nvarchar](50) NULL,
	[VendorProductionMin] [nvarchar](50) NULL,
	[VendorProductionLeadTime] [nvarchar](50) NULL,
	[MaterialPlacement] [bit] NULL,
	[DetailYesNo] [int] NULL,
	[ImageType1] [nvarchar](50) NULL,
	[height] [nvarchar](100) NULL,
	[width] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MChange] [int] NULL,
	[DChange] [int] NULL,
	[Action] [nvarchar](50) NULL,
	[Status] [nvarchar](100) NULL,
	[Active] [int] NOT NULL,
	[MultiDimension] [int] NULL,
	[UOM] [nvarchar](50) NULL,
	[MaterialCode] [varchar](50) NULL,
	[MaterialCodeNo] [int] NULL,
	[SAPCode] [varchar](50) NULL,
	[SAPControl] [int] NULL,
	[MaterialColorRequired] [int] NULL,
	[FactorySourced] [int] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[HeaderLocked] [int] NOT NULL,
	[MaterialTemplateID] [uniqueidentifier] NULL,
	[DutyCategoryID] [uniqueidentifier] NULL,
	[DueDate] [datetime] NULL,
	[CurrencyType] [nvarchar](5) NULL,
CONSTRAINT [PK_pMaterialRemovalLog] PRIMARY KEY CLUSTERED 
(
	[MaterialRemovalID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE pMaterialRemoval ADD  CONSTRAINT [DF_pMaterialRemoval_MaterialRemovalID]  DEFAULT (newid()) FOR [MaterialRemovalID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07968', GetDate())
GO
