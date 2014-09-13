-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 June 2010                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRAlternates')
DROP TABLE pGRAlternates
GO

CREATE TABLE [dbo].[pGRAlternates](
	[AlternatesGuidId] [uniqueidentifier] NOT NULL,
	[CompanyGuidID] [uniqueidentifier] NULL,
	[GradeTypeId] [int] NULL,
	[AlternatesCode] [nvarchar](4) NULL,
	[AlternatesDesc] [nvarchar](100) NOT NULL,
	[CompanyId] [int] NULL,
	[GTSortField] [float] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRAlternates] PRIMARY KEY CLUSTERED 
(
	[AlternatesGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRClassRange')
DROP TABLE pGRClassRange
GO

CREATE TABLE [dbo].[pGRClassRange](
	[ClassRangeId] [uniqueidentifier] NOT NULL,
	[SizeClassGuidId] [uniqueidentifier] NOT NULL,
	[SizeRangeGuidId] [uniqueidentifier] NOT NULL,
	[CUser] [nchar](25) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pGRClassRange] PRIMARY KEY CLUSTERED 
(
	[ClassRangeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRCompany')
DROP TABLE pGRCompany
GO

CREATE TABLE [dbo].[pGRCompany](
	[CompanyGuidID] [uniqueidentifier] NOT NULL,
	[CompanyId] [int] NULL,
	[Company] [nvarchar](60) NOT NULL,
	[IsRelative] [int] NULL,
	[IsNegative] [int] NULL,
	[IsMetric] [int] NULL,
	[LastUpdated] [datetime] NULL,
	[IsActive] [int] NULL,
	[ClassifierId] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRCompany] PRIMARY KEY CLUSTERED 
(
	[CompanyGuidID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRGarment')
DROP TABLE pGRGarment
GO

CREATE TABLE [dbo].[pGRGarment](
	[GarmentGuidID] [uniqueidentifier] NOT NULL,
	[CompanyGuidID] [uniqueidentifier] NULL,
	[GarmentId] [int] NULL,
	[Garment] [nvarchar](100) NOT NULL,
	[CompanyId] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRGarment] PRIMARY KEY CLUSTERED 
(
	[GarmentGuidID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRGradeRule')
DROP TABLE pGRGradeRule
GO

CREATE TABLE [dbo].[pGRGradeRule](
	[GradeRuleGuidID] [uniqueidentifier] NOT NULL,
	[POMCompanyId] [uniqueidentifier] NULL,
	[ClassRangeId] [uniqueidentifier] NULL,
	[POMAlternatesId] [uniqueidentifier] NULL,
	[SizeRangeGuidId] [uniqueidentifier] NULL,
	[GradeRuleId] [int] NULL,
	[POMGradeTypeId] [int] NULL,
	[SizeRangeId] [int] NULL,
	[Incr1] [nvarchar](18) NULL,
	[Incr2] [nvarchar](18) NULL,
	[Incr3] [nvarchar](18) NULL,
	[Incr4] [nvarchar](18) NULL,
	[Incr5] [nvarchar](18) NULL,
	[Incr6] [nvarchar](18) NULL,
	[Incr7] [nvarchar](18) NULL,
	[Incr8] [nvarchar](18) NULL,
	[Incr9] [nvarchar](18) NULL,
	[Incr10] [nvarchar](18) NULL,
	[Incr11] [nvarchar](18) NULL,
	[Incr12] [nvarchar](18) NULL,
	[Incr13] [nvarchar](18) NULL,
	[Incr14] [nvarchar](18) NULL,
	[Incr15] [nvarchar](18) NULL,
	[Incr16] [nvarchar](18) NULL,
	[Incr17] [nvarchar](18) NULL,
	[Incr18] [nvarchar](18) NULL,
	[Incr19] [nvarchar](18) NULL,
	[Incr20] [nvarchar](18) NULL,
	[Incr21] [nvarchar](18) NULL,
	[Incr22] [nvarchar](18) NULL,
	[Incr23] [nvarchar](18) NULL,
	[Incr24] [nvarchar](18) NULL,
	[Incr25] [nvarchar](18) NULL,
	[Incr26] [nvarchar](18) NULL,
	[Incr27] [nvarchar](18) NULL,
	[Incr28] [nvarchar](18) NULL,
	[Incr29] [nvarchar](18) NULL,
	[Incr30] [nvarchar](18) NULL,
	[Incr31] [nvarchar](18) NULL,
	[Incr32] [nvarchar](18) NULL,
	[Incr33] [nvarchar](18) NULL,
	[Incr34] [nvarchar](18) NULL,
	[Incr35] [nvarchar](18) NULL,
	[Incr36] [nvarchar](18) NULL,
	[Incr37] [nvarchar](18) NULL,
	[Incr38] [nvarchar](18) NULL,
	[Incr39] [nvarchar](18) NULL,
	[Incr40] [nvarchar](18) NULL,
	[Incr41] [nvarchar](18) NULL,
	[Incr42] [nvarchar](18) NULL,
	[Incr43] [nvarchar](18) NULL,
	[Incr44] [nvarchar](18) NULL,
	[Incr45] [nvarchar](18) NULL,
	[Incr46] [nvarchar](18) NULL,
	[Incr47] [nvarchar](18) NULL,
	[Incr48] [nvarchar](18) NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRGradeRule] PRIMARY KEY CLUSTERED 
(
	[GradeRuleGuidID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRGradeRuleDetail')
DROP TABLE pGRGradeRuleDetail
GO

CREATE TABLE [dbo].[pGRGradeRuleDetail](
	[GradeRuleDetailId] [uniqueidentifier] NOT NULL,
	[GradeRuleId] [uniqueidentifier] NOT NULL,
	[RulesCount] [int] NULL,
	[GradeRule] [nvarchar](50) NULL,
     CONSTRAINT [PK_GradeRuleDetail] PRIMARY KEY CLUSTERED ([GradeRuleDetailId])
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRGrmntClassImg')
DROP TABLE pGRGrmntClassImg
GO

CREATE TABLE [dbo].[pGRGrmntClassImg](
	[Garment_Cls_ImgGuidId] [uniqueidentifier] NOT NULL,
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

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRKeyMeasurement')
DROP TABLE pGRKeyMeasurement
GO

CREATE TABLE [dbo].[pGRKeyMeasurement](
	[KeyMeasurementGuidId] [uniqueidentifier] NOT NULL,
	[Garment_Cls_ImgGuidId] [uniqueidentifier] NULL,
	[POMAlternatesId] [uniqueidentifier] NULL,
	[KeyMeasurementId] [int] NOT NULL,
	[Garment_Cls_ImgId] [int] NULL,
	[POMGradeTypeId] [int] NULL,
	[IsPrimaryKeyMeas] [int] NULL,
 CONSTRAINT [PK_pGRKeyMeasurement] PRIMARY KEY CLUSTERED 
(
	[KeyMeasurementGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRPOM')
DROP TABLE pGRPOM
GO

CREATE TABLE [dbo].[pGRPOM](
	[POMGuidId] [uniqueidentifier] NOT NULL,
	[POMId] [int] NULL,
	[RefCode] [nvarchar](12) NOT NULL,
	[POMDesc] [nvarchar](100) NOT NULL,
	[CompanyId] [int] NULL,
	[How2MeasName] [nvarchar](128) NULL,
	[How2MeasText] [nvarchar](500) NULL,
	[VideoSerialNumber] [int] NULL,
	[SortField] [int] NULL,
	[CnvtPOMDesc] [nvarchar](100) NULL,
	[ImageSerialNumber] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
	[CompanyGuidIdXXX] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pGRPOM] PRIMARY KEY CLUSTERED 
(
	[POMGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRPOMAlternates')
DROP TABLE pGRPOMAlternates
GO

CREATE TABLE [dbo].[pGRPOMAlternates](
	[POMAlternatesId] [uniqueidentifier] NOT NULL,
	[POMGuidId] [uniqueidentifier] NULL,
	[AlternatesGuidId] [uniqueidentifier] NULL,
	[POMGradeTypeId] [int] NULL,
	[POMId] [int] NULL,
	[GradeTypeId] [int] NULL,
 CONSTRAINT [PK_pGRPOMAlternates] PRIMARY KEY CLUSTERED 
(
	[POMAlternatesId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRPOMCompany')
DROP TABLE pGRPOMCompany
GO

CREATE TABLE [dbo].[pGRPOMCompany](
	[POMCompanyId] [uniqueidentifier] NOT NULL,
	[CompanyGuidID] [uniqueidentifier] NOT NULL,
	[POMAlternatesId] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pGRPOMCompany] PRIMARY KEY CLUSTERED 
(
	[POMCompanyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRSizeClass')
DROP TABLE pGRSizeClass
GO

CREATE TABLE [dbo].[pGRSizeClass](
	[SizeClassGuidId] [uniqueidentifier] NOT NULL,
	[SizeClassId] [int] NULL,
	[SizeClass] [nvarchar](60) NOT NULL,
	[CompanyId] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRSizeClass] PRIMARY KEY CLUSTERED 
(
	[SizeClassGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRSizeClassCompany')
DROP TABLE pGRSizeClassCompany
GO

CREATE TABLE [dbo].[pGRSizeClassCompany](
	[SizeClassCompanyId] [uniqueidentifier] NOT NULL,
	[SizeClassGuidId] [uniqueidentifier] NOT NULL,
	[CompanyGuidId] [uniqueidentifier] NOT NULL,
       CONSTRAINT [PK_pGRSizeClassCompany] PRIMARY KEY CLUSTERED ([SizeClassCompanyId])
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRSizeRange')
DROP TABLE pGRSizeRange
GO

CREATE TABLE [dbo].[pGRSizeRange](
	[SizeRangeGuidId] [uniqueidentifier] NOT NULL,
	[SizeClassGuidIdXX] [uniqueidentifier] NULL,
	[SizeRangeId] [int] NULL,
	[SizeRange] [nvarchar](60) NULL,
	[SizeClassId] [int] NULL,
	[Active] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRSizeRange] PRIMARY KEY CLUSTERED 
(
	[SizeRangeGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRSizeRangeDetail')
DROP TABLE pGRSizeRangeDetail
GO

CREATE TABLE [dbo].[pGRSizeRangeDetail](
	[SizeRangeDetailId] [uniqueidentifier] NOT NULL,
	[SizeRangeId] [uniqueidentifier] NOT NULL,
	[SizeCount] [int] NULL,
	[SizeName] [nvarchar](50) NULL,
	[SizeDesc] [nvarchar](50) NULL,
	[Sample] [int] NULL,
 CONSTRAINT [PK_pGRSizeRangeDetail] PRIMARY KEY CLUSTERED 
(
	[SizeRangeDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'pGRTolerance')
DROP TABLE pGRTolerance
GO

CREATE TABLE [dbo].[pGRTolerance](
	[ToleranceGuidId] [uniqueidentifier] NOT NULL,
	[Garment_Cls_ImgGuidId] [uniqueidentifier] NULL,
	[POMAlternatesIdXXX] [uniqueidentifier] NULL,
	[POMCompanyId] [uniqueidentifier] NULL,
	[ToleranceId] [int] NULL,
	[Garment_Cls_ImgId] [int] NULL,
	[POMGradeTypeId] [int] NULL,
	[TolPlus] [nvarchar](18) NULL,
	[TolMinus] [nvarchar](18) NULL,
	[IsOnQA] [int] NULL,
	[IsPrimaryKeyMeas] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRTolerance] PRIMARY KEY CLUSTERED 
(
	[ToleranceGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRAlternates] ADD  CONSTRAINT [DF__pGRGradeT__Grade__5A2AD66A]  DEFAULT (newid()) FOR [AlternatesGuidId]
GO

ALTER TABLE [dbo].[pGRAlternates] ADD  CONSTRAINT [DF__pGRGradeT__GTSor__5B1EFAA3]  DEFAULT ((0)) FOR [GTSortField]
GO

ALTER TABLE [dbo].[pGRCompany] ADD  CONSTRAINT [DF__pGRCompan__Compa__50A16C30]  DEFAULT (newid()) FOR [CompanyGuidID]
GO

ALTER TABLE [dbo].[pGRCompany] ADD  CONSTRAINT [DF__pGRCompan__Class__51959069]  DEFAULT ((0)) FOR [ClassifierId]
GO

ALTER TABLE [dbo].[pGRGarment] ADD  CONSTRAINT [DF__pGRGarmen__Garme__5471FD14]  DEFAULT (newid()) FOR [GarmentGuidID]
GO

ALTER TABLE [dbo].[pGRGradeRule] ADD  CONSTRAINT [DF__pGRGradeR__Grade__574E69BF]  DEFAULT (newid()) FOR [GradeRuleGuidID]
GO

ALTER TABLE [dbo].[pGRGradeRuleDetail] ADD  CONSTRAINT [DF_pGRGradeRuleDetail_GradeRuleDetailId]  DEFAULT (newid()) FOR [GradeRuleDetailId]
GO

ALTER TABLE [dbo].[pGRGrmntClassImg] ADD  CONSTRAINT [DF__pGRGrmntC__Garme__5DFB674E]  DEFAULT (newid()) FOR [Garment_Cls_ImgGuidId]
GO

ALTER TABLE [dbo].[pGRGrmntClassImg] ADD  CONSTRAINT [DF__pGRGrmntC__Image__5EEF8B87]  DEFAULT ((0)) FOR [ImageSerialNumber]
GO

ALTER TABLE [dbo].[pGRKeyMeasurement] ADD  DEFAULT (newid()) FOR [KeyMeasurementGuidId]
GO

ALTER TABLE [dbo].[pGRKeyMeasurement] ADD  DEFAULT ((-1)) FOR [IsPrimaryKeyMeas]
GO

ALTER TABLE [dbo].[pGRPOM] ADD  CONSTRAINT [DF__pGRPOM__POMGuidI__6690AD4F]  DEFAULT (newid()) FOR [POMGuidId]
GO

ALTER TABLE [dbo].[pGRPOM] ADD  CONSTRAINT [DF__pGRPOM__VideoSer__6784D188]  DEFAULT ((0)) FOR [VideoSerialNumber]
GO

ALTER TABLE [dbo].[pGRPOM] ADD  CONSTRAINT [DF__pGRPOM__SortFiel__6878F5C1]  DEFAULT ((0)) FOR [SortField]
GO

ALTER TABLE [dbo].[pGRPOM] ADD  CONSTRAINT [DF__pGRPOM__ImageSer__696D19FA]  DEFAULT ((0)) FOR [ImageSerialNumber]
GO

ALTER TABLE [dbo].[pGRPOMAlternates] ADD  CONSTRAINT [DF__pGRPOMGra__POMGr__6C4986A5]  DEFAULT (newid()) FOR [POMAlternatesId]
GO

ALTER TABLE [dbo].[pGRPOMCompany] ADD  CONSTRAINT [DF_pGRPOMCompany_pGRPOMCompanyId]  DEFAULT (newid()) FOR [POMCompanyId]
GO

ALTER TABLE [dbo].[pGRSizeClass] ADD  CONSTRAINT [DF__pGRSizeCl__SizeC__6F25F350]  DEFAULT (newid()) FOR [SizeClassGuidId]
GO

ALTER TABLE [dbo].[pGRSizeClassCompany] ADD  CONSTRAINT [DF_pGRSizeClassCompany_SizeClassCompID]  DEFAULT (newid()) FOR [SizeClassCompanyId]
GO

ALTER TABLE [dbo].[pGRSizeRange] ADD  CONSTRAINT [DF__pGRSizeRa__SizeR__72025FFB]  DEFAULT (newid()) FOR [SizeRangeGuidId]
GO

ALTER TABLE [dbo].[pGRSizeRange] ADD  CONSTRAINT [DF_pGRSizeRange_Active]  DEFAULT ((-1)) FOR [Active]
GO

ALTER TABLE [dbo].[pGRSizeRangeDetail] ADD  CONSTRAINT [DF_pGRSizeRangeDetail_SizeRangeDetailId]  DEFAULT (newid()) FOR [SizeRangeDetailId]
GO

ALTER TABLE [dbo].[pGRSizeRangeDetail] ADD  CONSTRAINT [DF_pGRSizeRangeDetail_Sample]  DEFAULT ((0)) FOR [Sample]
GO

ALTER TABLE [dbo].[pGRTolerance] ADD  CONSTRAINT [DF__pGRTolera__Toler__0515346F]  DEFAULT (newid()) FOR [ToleranceGuidId]
GO

ALTER TABLE [dbo].[pGRTolerance] ADD  CONSTRAINT [DF__pGRTolera__IsOnQ__060958A8]  DEFAULT ((-1)) FOR [IsOnQA]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '345a', GetDate())
GO

