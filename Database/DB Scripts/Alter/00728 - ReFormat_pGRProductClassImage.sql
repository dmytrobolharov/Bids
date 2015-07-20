SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pGRProductClassImage' )
   BEGIN
        DROP TABLE pGRProductClassImage
   END


CREATE TABLE [dbo].[pGRProductClassImage](
	[ProductClassImageID] [uniqueidentifier] NOT NULL,
	[SizeClassCompanyId] [uniqueidentifier] NULL,
	[ProductCompanyId] [uniqueidentifier] NULL,
	[SizeClassGuidId] [uniqueidentifier] NULL,
        [Imageid] [uniqueidentifier] NULL,
	[Garment_Cls_ImgId] [int] NULL,
	[GarmentId] [int] NULL,
	[SizeClassId] [int] NULL,
	[How2MeasName] [nvarchar](128) NULL,
	[How2MeasText] [nvarchar](510) NULL,
	[ImageSerialNumber] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL
 CONSTRAINT [PK_pProductClassImage] PRIMARY KEY CLUSTERED 
(
	[ProductClassImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_PCI_ProductCompanyId] ON [dbo].[pGRProductClassImage] 
(
	[ProductCompanyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_PCI_SizeClassCompanyId] ON [dbo].[pGRProductClassImage] 
(
	[SizeClassCompanyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_PCI_SizeClassGuidId] ON [dbo].[pGRProductClassImage] 
(
	[SizeClassGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRProductClassImage] ADD  CONSTRAINT [DF_pCI_ProductClassImageId]  DEFAULT (newid()) FOR [ProductClassImageID]
GO

ALTER TABLE [dbo].[pGRProductClassImage] ADD  CONSTRAINT [DF_pCI_ImageSerialNumber]  DEFAULT ((0)) FOR [ImageSerialNumber]
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pGRGrmntClassImg' )
   BEGIN
        DROP TABLE pGRGrmntClassImg
               
   END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '728', GetDate())
GO

