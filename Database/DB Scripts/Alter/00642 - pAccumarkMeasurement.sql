/****** Object:  Table [dbo].[pAccumarkMeasurement]    Script Date: 11/02/2010 09:58:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pAccumarkMeasurement]') AND type in (N'U'))
DROP TABLE [dbo].[pAccumarkMeasurement]

GO
/****** Object:  Table [dbo].[pAMLMeasPOM]    Script Date: 10/28/2010 12:47:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pAccumarkMeasurement](
	[MeasGuidId] [uniqueidentifier] NOT NULL,
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[ModelName] [nvarchar](200) NOT NULL,
	[POMDescription] [nvarchar](204) NOT NULL,
	[POMRow] [int] NOT NULL,
	[SizeCol] [int] NOT NULL,
	[SizeDesc] [nvarchar](20) NOT NULL,
	[Grade] [numeric](18, 4) NOT NULL,
	[IsMetric] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pAccumarkMeasurement] PRIMARY KEY CLUSTERED 
(
	[MeasGuidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pAccumarkMeasurement] ADD  CONSTRAINT [DF_Table_1_MeasGuidId]  DEFAULT (newid()) FOR [MeasGuidId]
GO

ALTER TABLE [dbo].[pAccumarkMeasurement] ADD  CONSTRAINT [DF_pAccumarkMeasurement_Grade]  DEFAULT ((0)) FOR [Grade]
GO

ALTER TABLE [dbo].[pAccumarkMeasurement] ADD  CONSTRAINT [DF_pAccumarkMeasurement_IsMetric]  DEFAULT ((0)) FOR [IsMetric]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '642', GetDate())
GO