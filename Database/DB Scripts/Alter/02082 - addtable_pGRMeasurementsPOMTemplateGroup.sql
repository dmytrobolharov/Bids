

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMTemplateGroup]') AND type in (N'U'))
DROP TABLE [dbo].[pGRMeasurementsPOMTemplateGroup]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pGRMeasurementsPOMTemplateGroup](
	[POMTempGroupItemID] [uniqueidentifier] NOT NULL,
	[POMTempGroupID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[POMTempID] [uniqueidentifier] NOT NULL,
	[POMType] [nvarchar](100) NULL,
	[POMTypeDescription] [nvarchar](200) NULL,
	[SizeClassId] [uniqueidentifier] NULL,
	[SizeRangeId] [uniqueidentifier] NULL,
	[ClassRangeId] [uniqueidentifier] NULL,
	[SizeClass] [nvarchar](100) NULL,
	[SizeRange] [nvarchar](100) NULL,
	[ClassRange] [nvarchar](200) NULL,
	[Relative] [int] NULL,
	[Negative] [int] NULL,
	[Metric] [int] NULL,
	[Active] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pGRMeasurementsPOMTemplateGroup] PRIMARY KEY CLUSTERED 
(
	[POMTempGroupItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateGroup] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateGroup_POMTempGroupItemID]  DEFAULT (newid()) FOR [POMTempGroupItemID]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateGroup] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateGroup_POMTempGroupID]  DEFAULT (newid()) FOR [POMTempGroupID]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateGroup] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateGroup_Active]  DEFAULT ((0)) FOR [Active]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplateGroup] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplateGroup_Sort]  DEFAULT ((0)) FOR [Sort]
GO




IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02082'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02082', GetDate())
	END
GO