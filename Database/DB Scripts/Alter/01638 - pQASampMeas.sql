
/****** Object:  Table [dbo].[pQASampMeas]    Script Date: 07/14/2011 11:59:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQASampMeas]') AND type in (N'U'))
	DROP TABLE [dbo].[pQASampMeas]
GO

CREATE TABLE [dbo].[pQASampMeas](
	[SampleMeasId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestHeaderId] [uniqueidentifier] NOT NULL,
	[SamplepomId] [uniqueidentifier] NULL,
	[SampleLabelId] [uniqueidentifier] NULL,
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[AMLMeasPomid] [uniqueidentifier] NULL,
	[AMLMeasLblId] [uniqueidentifier] NULL,
	[AMLMeasIGCId] [uniqueidentifier] NULL,
	[POMRow] [int] NOT NULL,
	[Sizecol] [int] NOT NULL,
	[SampleNo] [int] NOT NULL,
	[Submit] [int] NOT NULL,
	[MeasValue] [numeric](18, 4) NULL,
	[SampMeasValue] [numeric](18, 4) NULL,
	[SampDelta] [numeric](18, 4) NULL,
	[SampOutTol] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pQASampMeas] PRIMARY KEY CLUSTERED 
(
	[SampleMeasId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pQASampMeas] ADD  CONSTRAINT [DF_pQASampMeas_SampleMeasId]  DEFAULT (newid()) FOR [SampleMeasId]
GO

ALTER TABLE [dbo].[pQASampMeas] ADD  CONSTRAINT [DF_pQASampMeas_MeasValue]  DEFAULT ((0)) FOR [MeasValue]
GO

ALTER TABLE [dbo].[pQASampMeas] ADD  CONSTRAINT [DF_pQASampMeas_SampMeasValue]  DEFAULT ((0)) FOR [SampMeasValue]
GO

ALTER TABLE [dbo].[pQASampMeas] ADD  CONSTRAINT [DF_pQASampMeas_SampDelta]  DEFAULT ((0)) FOR [SampDelta]
GO

ALTER TABLE [dbo].[pQASampMeas] ADD  CONSTRAINT [DF_pQASampMeas_SampOutTol]  DEFAULT ((0)) FOR [SampOutTol]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01638', GetDate())
GO
