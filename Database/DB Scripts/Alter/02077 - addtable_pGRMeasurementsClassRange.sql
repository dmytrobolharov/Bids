
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsClassRange]') AND type in (N'U'))
DROP TABLE [dbo].[pGRMeasurementsClassRange]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pGRMeasurementsClassRange](
	[ClassRangeId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SizeClassId] [uniqueidentifier] NOT NULL,
	[SizeRangeId] [uniqueidentifier] NOT NULL,
	[SizeClass] [nvarchar](200) NOT NULL,
	[SizeRange] [nvarchar](200) NOT NULL,
	[Active] [int] NOT NULL,
	[IsLinked] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRMeasurementsClassRange] PRIMARY KEY CLUSTERED 
(
	[ClassRangeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRMeasurementsClassRange] ADD  CONSTRAINT [DF_pGRMeasurementsClassRange_ClassRangeId]  DEFAULT (newid()) FOR [ClassRangeId]
GO

ALTER TABLE [dbo].[pGRMeasurementsClassRange] ADD  CONSTRAINT [DF_pGRMeasurementsClassRange_Active]  DEFAULT ((0)) FOR [Active]
GO

ALTER TABLE [dbo].[pGRMeasurementsClassRange] ADD  CONSTRAINT [DF_pGRMeasurementsClassRange_IsLinked]  DEFAULT ((0)) FOR [IsLinked]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02077'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02077', GetDate())
	END
GO