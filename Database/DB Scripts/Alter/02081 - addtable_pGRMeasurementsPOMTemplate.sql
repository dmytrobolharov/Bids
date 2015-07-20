

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pGRMeasurementsPOMTemplate]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pGRMeasurementsPOMTemplate](
	[POMTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[POMTempGroupID] [uniqueidentifier] NULL,
	[POMTempVersion] [int] NULL,
	[POMType] [nvarchar](100) NULL,
	[POMTypeDescription] [nvarchar](200) NULL,
	[SpecSketchID] [uniqueidentifier] NULL,
	[SpecSketchVersion] [int] NULL,
	[SizeClassId] [uniqueidentifier] NOT NULL,
	[SizeRangeId] [uniqueidentifier] NOT NULL,
	[ClassRangeId] [uniqueidentifier] NOT NULL,
	[SizeClass] [nvarchar](100) NULL,
	[SizeRange] [nvarchar](100) NULL,
	[ClassRange] [nvarchar](200) NULL,
	[SampleSize] [nvarchar](50) NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[Size0] [nvarchar](20) NULL,
	[Size1] [nvarchar](20) NULL,
	[Size2] [nvarchar](20) NULL,
	[Size3] [nvarchar](20) NULL,
	[Size4] [nvarchar](20) NULL,
	[Size5] [nvarchar](20) NULL,
	[Size6] [nvarchar](20) NULL,
	[Size7] [nvarchar](20) NULL,
	[Size8] [nvarchar](20) NULL,
	[Size9] [nvarchar](20) NULL,
	[Size10] [nvarchar](20) NULL,
	[Size11] [nvarchar](20) NULL,
	[Size12] [nvarchar](20) NULL,
	[Size13] [nvarchar](20) NULL,
	[Size14] [nvarchar](20) NULL,
	[Size15] [nvarchar](20) NULL,
	[Size16] [nvarchar](20) NULL,
	[Size17] [nvarchar](20) NULL,
	[Size18] [nvarchar](20) NULL,
	[Size19] [nvarchar](20) NULL,
	[Size20] [nvarchar](20) NULL,
	[Size21] [nvarchar](20) NULL,
	[Size22] [nvarchar](20) NULL,
	[Size23] [nvarchar](20) NULL,
	[Size24] [nvarchar](20) NULL,
	[Size25] [nvarchar](20) NULL,
	[Size26] [nvarchar](20) NULL,
	[Size27] [nvarchar](20) NULL,
	[Size28] [nvarchar](20) NULL,
	[Size29] [nvarchar](20) NULL,
	[Size30] [nvarchar](20) NULL,
	[Size31] [nvarchar](20) NULL,
	[Size32] [nvarchar](20) NULL,
	[Size33] [nvarchar](20) NULL,
	[Size34] [nvarchar](20) NULL,
	[Size35] [nvarchar](20) NULL,
	[Size36] [nvarchar](20) NULL,
	[Size37] [nvarchar](20) NULL,
	[Size38] [nvarchar](20) NULL,
	[Size39] [nvarchar](20) NULL,
	[Size40] [nvarchar](20) NULL,
	[Size41] [nvarchar](20) NULL,
	[Size42] [nvarchar](20) NULL,
	[Size43] [nvarchar](20) NULL,
	[Size44] [nvarchar](20) NULL,
	[Size45] [nvarchar](20) NULL,
	[Size46] [nvarchar](20) NULL,
	[Size47] [nvarchar](20) NULL,
	[Size48] [nvarchar](20) NULL,
	[Size49] [nvarchar](20) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[Sort] [int] NULL,
	[Active] [int] NULL,
	[Linked] [int] NULL,
 CONSTRAINT [PK_pGRMeasurementsPOMTemplate] PRIMARY KEY CLUSTERED 
(
	[POMTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplate] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplate_POMTempID]  DEFAULT (newid()) FOR [POMTempID]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplate] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplate_POMTempVersion]  DEFAULT ((1)) FOR [POMTempVersion]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplate] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplate_Sort]  DEFAULT ((0)) FOR [Sort]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplate] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplate_Active]  DEFAULT ((0)) FOR [Active]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMTemplate] ADD  CONSTRAINT [DF_pGRMeasurementsPOMTemplate_Linked]  DEFAULT ((0)) FOR [Linked]
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02081'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02081', GetDate())
	END
GO