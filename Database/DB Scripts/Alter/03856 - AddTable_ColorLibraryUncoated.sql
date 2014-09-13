DECLARE @Cnt int
SELECT @Cnt = COUNT(*) from sys.objects where name =  'ColorLibraryUncoated' and type = 'U'
IF @Cnt =  0
BEGIN 

CREATE TABLE [dbo].[ColorLibraryUncoated](
	[BookOrder] [int] NOT NULL,
	[Page] [float] NULL,
	[PageRow] [float] NULL,
	[PANTONEColor] [nvarchar](255) NULL,
	[PANTONEName] [nvarchar](255) NULL,
	[PANTONEType] [nvarchar](255) NOT NULL,
	[CIELab_D50_2_L] [float] NULL,
	[CIELab_D50_2_A] [float] NULL,
	[CIELab_D50_2_B] [float] NULL,
	[CIELab_D50_2_C] [float] NULL,
	[CIELab_D50_2_H] [float] NULL,
	[XYZ_D50_2_X] [float] NULL,
	[XYZ_D50_2_Y] [float] NULL,
	[XYZ_D50_2_Z] [float] NULL,
	[CIELab_D50_10_L] [float] NULL,
	[CIELab_D50_10_A] [float] NULL,
	[CIELab_D50_10_B] [float] NULL,
	[CIELab_D50_10_C] [float] NULL,
	[CIELab_D50_10_H] [float] NULL,
	[XYZ_D50_10_X] [float] NULL,
	[XYZ_D50_10_Y] [float] NULL,
	[XYZ_D50_10_Z] [float] NULL,
	[CIELab_D65_2_L] [float] NULL,
	[CIELab_D65_2_A] [float] NULL,
	[CIELab_D65_2_B] [float] NULL,
	[CIELab_D65_2_C] [float] NULL,
	[CIELab_D65_2_H] [float] NULL,
	[XYZ_D65_2_X] [float] NULL,
	[XYZ_D65_2_Y] [float] NULL,
	[XYZ_D65_2_Z] [float] NULL,
	[CIELab_D65_10_L] [float] NULL,
	[CIELab_D65_10_A] [float] NULL,
	[CIELab_D65_10_B] [float] NULL,
	[CIELab_D65_10_C] [float] NULL,
	[CIELab_D65_10_H] [float] NULL,
	[XYZ_D65_10_X] [float] NULL,
	[XYZ_D65_10_Y] [float] NULL,
	[XYZ_D65_10_Z] [float] NULL,
	[sRGB_D65_2_R] [float] NULL,
	[sRGB_D65_2_G] [float] NULL,
	[sRGB_D65_2_B] [float] NULL,
	[sRGB_D65_2_PERC_R] [float] NULL,
	[sRGB_D65_2_PERC_G] [float] NULL,
	[sRGB_D65_2_PERC_B] [float] NULL,
	[sRGB_HTML] [nvarchar](10) NULL,
	[aRGB_D65_2_R] [float] NULL,
	[aRGB_D65_2_G] [float] NULL,
	[aRGB_D65_2_B] [float] NULL,
	[aRGB_D65_2_PERC_R] [float] NULL,
	[aRGB_D65_2_PERC_G] [float] NULL,
	[aRGB_D65_2_PERC_B] [float] NULL,
	[aRGB_HTML] [nvarchar](10) NULL,
	[Active] [int] NOT NULL,
	[ColorLibraryTypeID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ColorLibraryUncoated] PRIMARY KEY CLUSTERED 
(
	[BookOrder] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
 
 
ALTER TABLE [dbo].[ColorLibraryUncoated] ADD  CONSTRAINT [DF_ColorLibraryUncoated_PANTONEType]  DEFAULT (N'PANTONE UNCOATED') FOR [PANTONEType]
 
ALTER TABLE [dbo].[ColorLibraryUncoated] ADD  CONSTRAINT [DF_ColorLibraryUncoated_Active]  DEFAULT ((1)) FOR [Active]
 
ALTER TABLE [dbo].[ColorLibraryUncoated] ADD  CONSTRAINT [DF_ColorLibraryUncoated_ColorLibraryTypeID]  DEFAULT ('00000000-0000-0000-0000-0000000000d)') FOR [ColorLibraryTypeID]


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03856', GetDate())
GO
 