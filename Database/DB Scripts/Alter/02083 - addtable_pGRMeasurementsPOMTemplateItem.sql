

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMTemplateItem]') AND type in (N'U'))
DROP TABLE [dbo].[pGRMeasurementsPOMTemplateItem]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pGRMeasurementsPOMTemplateItem](
	[POMTempItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[POMTempID] [uniqueidentifier] NOT NULL,
	[POMTempGroupID] [uniqueidentifier] NOT NULL,
	[POMID] [uniqueidentifier] NULL,
	[AlternatesId] [uniqueidentifier] NULL,
	[POMAlternatesID] [uniqueidentifier] NULL,
	[SizeclassID] [uniqueidentifier] NULL,
	[SizeRangeID] [uniqueidentifier] NULL,
	[ClassRangeID] [uniqueidentifier] NULL,
	[ImageId] [uniqueidentifier] NULL,
	[SampleSizeRangeID] [uniqueidentifier] NULL,
	[FitComID] [int] NULL,
	[Critical] [int] NULL,
	[IsOnQA] [int] NULL,
	[IsLinked] [int] NULL,
	[POMCode] [nvarchar](50) NULL,
	[POMDesc] [nvarchar](200) NULL,
	[AlternatesCode] [nvarchar](10) NULL,
	[AlternatesDesc] [nvarchar](100) NULL,
	[How2MeasText] [nvarchar](4000) NULL,
	[How2MeasName] [nvarchar](200) NULL,
	[POMSort] [int] NULL,
	[AlternatesSort] [int] NULL,
	[Active] [int] NULL,
	[TolPlus] [numeric](18, 4) NULL,
	[TolMinus] [numeric](18, 4) NULL,
	[Incr0] [decimal](18, 4) NULL,
	[Incr1] [decimal](18, 4) NULL,
	[Incr2] [decimal](18, 4) NULL,
	[Incr3] [decimal](18, 4) NULL,
	[Incr4] [decimal](18, 4) NULL,
	[Incr5] [decimal](18, 4) NULL,
	[Incr6] [decimal](18, 4) NULL,
	[Incr7] [decimal](18, 4) NULL,
	[Incr8] [decimal](18, 4) NULL,
	[Incr9] [decimal](18, 4) NULL,
	[Incr10] [decimal](18, 4) NULL,
	[Incr11] [decimal](18, 4) NULL,
	[Incr12] [decimal](18, 4) NULL,
	[Incr13] [decimal](18, 4) NULL,
	[Incr14] [decimal](18, 4) NULL,
	[Incr15] [decimal](18, 4) NULL,
	[Incr16] [decimal](18, 4) NULL,
	[Incr17] [decimal](18, 4) NULL,
	[Incr18] [decimal](18, 4) NULL,
	[Incr19] [decimal](18, 4) NULL,
	[Incr20] [decimal](18, 4) NULL,
	[Incr21] [decimal](18, 4) NULL,
	[Incr22] [decimal](18, 4) NULL,
	[Incr23] [decimal](18, 4) NULL,
	[Incr24] [decimal](18, 4) NULL,
	[Incr25] [decimal](18, 4) NULL,
	[Incr26] [decimal](18, 4) NULL,
	[Incr27] [decimal](18, 4) NULL,
	[Incr28] [decimal](18, 4) NULL,
	[Incr29] [decimal](18, 4) NULL,
	[Incr30] [decimal](18, 4) NULL,
	[Incr31] [decimal](18, 4) NULL,
	[Incr32] [decimal](18, 4) NULL,
	[Incr33] [decimal](18, 4) NULL,
	[Incr34] [decimal](18, 4) NULL,
	[Incr35] [decimal](18, 4) NULL,
	[Incr36] [decimal](18, 4) NULL,
	[Incr37] [decimal](18, 4) NULL,
	[Incr38] [decimal](18, 4) NULL,
	[Incr39] [decimal](18, 4) NULL,
	[Incr40] [decimal](18, 4) NULL,
	[Incr41] [decimal](18, 4) NULL,
	[Incr42] [decimal](18, 4) NULL,
	[Incr43] [decimal](18, 4) NULL,
	[Incr44] [decimal](18, 4) NULL,
	[Incr45] [decimal](18, 4) NULL,
	[Incr46] [decimal](18, 4) NULL,
	[Incr47] [decimal](18, 4) NULL,
	[Incr48] [decimal](18, 4) NULL,
	[Incr49] [decimal](18, 4) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[Change] [int] NULL,
	[Sort] [nvarchar](4) NULL,
	[CopyPOMTempItemID] [uniqueidentifier] NULL,
	[Conv] [numeric](18, 4) NULL,
	[TempCopyPOMTempItemID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pGRMeasurementsPOMTemplateItem] PRIMARY KEY CLUSTERED 
(
	[POMTempItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_POMTempItemID]  DEFAULT (newid()) FOR [POMTempItemID]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_FitComID]  DEFAULT ((0)) FOR [FitComID]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_Critical]  DEFAULT ((0)) FOR [Critical]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_IsOnQA]  DEFAULT ((0)) FOR [IsOnQA]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_IsLinked]  DEFAULT ((0)) FOR [IsLinked]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_POMSort]  DEFAULT ((0)) FOR [POMSort]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_AlternatesSort]  DEFAULT ((0)) FOR [AlternatesSort]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateItem] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateItem_Active]  DEFAULT ((0)) FOR [Active]
GO




IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02083'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02083', GetDate())
	END
GO