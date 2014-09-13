IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImageMeasurements]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleImageMeasurements]
GO

/****** Object:  Table [dbo].[pStyleImageMeasurements]    Script Date: 11/15/2011 14:17:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleImageMeasurements](
	[MeasurementID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ImageSet1Id] [uniqueidentifier] NULL,
	[ImageVersionSet1] [int] NULL,
	[ImageSet2Id] [uniqueidentifier] NULL,
	[ImageVersionSet2] [int] NULL,
	[ImageSet3Id] [uniqueidentifier] NULL,
	[ImageVersionSet3] [int] NULL,
	[ImageSet4Id] [uniqueidentifier] NULL,
	[ImageVersionSet4] [int] NULL,
 CONSTRAINT [PK_pStyleImageMeasurements_1] PRIMARY KEY CLUSTERED 
(
	[MeasurementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageSet1Id]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ImageSet1Id]
GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageVersionSet1]  DEFAULT ((1)) FOR [ImageVersionSet1]
GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageSet2Id]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ImageSet2Id]
GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageVersionSet2]  DEFAULT ((1)) FOR [ImageVersionSet2]
GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageSet3Id]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ImageSet3Id]
GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageVersionSet3]  DEFAULT ((1)) FOR [ImageVersionSet3]
GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageSet4Id]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ImageSet4Id]
GO

ALTER TABLE [dbo].[pStyleImageMeasurements] ADD  CONSTRAINT [DF_pStyleImageMeasurements_ImageVersionSet4]  DEFAULT ((1)) FOR [ImageVersionSet4]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02177'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02177', GetDate())
	END
GO