--
-- Rename POMAlternatesId to POMAlternatesIdXX
--
sp_RENAME 'pGRGradeRule.POMAlternatesId', 'POMAlternatesIdXX' ,'COLUMN'
GO
--
-- ADD SizeClassCompanyId to pGRGrmntClassImg table
--

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRGrmntClassImg')
DROP TABLE pGRGrmntClassImg
GO

CREATE TABLE pGRGrmntClassImg(
	[Garment_Cls_ImgGuidId] [uniqueidentifier] NOT NULL,
	[SizeClassCompanyId] [uniqueidentifier] NULL,
	[GarmentGuidID] [uniqueidentifier] NULL,
	[SizeClassGuidId] [uniqueidentifier] NULL,
	[Garment_Cls_ImgId] [int] NULL,
	[GarmentId] [int] NULL,
	[SizeClassId] [int] NULL,
	[How2MeasName] [nvarchar](128) NULL,
	[How2MeasText] [nvarchar](510) NULL,
	[ImageSerialNumber] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRGrmntClassImg] PRIMARY KEY CLUSTERED 
(
	[Garment_Cls_ImgGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRGrmntClassImg] ADD  CONSTRAINT [DF__pGRGrmntC__Garme__5DFB674E]  DEFAULT (newid()) FOR [Garment_Cls_ImgGuidId]
GO

ALTER TABLE [dbo].[pGRGrmntClassImg] ADD  CONSTRAINT [DF__pGRGrmntC__Image__5EEF8B87]  DEFAULT ((0)) FOR [ImageSerialNumber]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '549', GetDate())
GO
