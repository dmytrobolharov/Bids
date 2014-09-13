
/****** Object:  Table [dbo].[pQASampLbl]    Script Date: 07/14/2011 11:58:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQASampLbl]') AND type in (N'U'))
	DROP TABLE [dbo].[pQASampLbl]
GO

CREATE TABLE [dbo].[pQASampLbl](
	[SampleLabelId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestHeaderId] [uniqueidentifier] NOT NULL,
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[AMLMeasLblId] [uniqueidentifier] NULL,
	[Submit] [int] NOT NULL,
	[SizeCol] [int] NULL,
	[ColLabel] [nvarchar](26) NULL,
	[IsVisible] [int] NULL,
	[SampleNo] [int] NULL,
	[CommentLabel] [nvarchar](100) NULL,
	[Comments] [text] NULL,
	[NextSampleNo] [int] NULL,
	[FitAttendee] [nvarchar](100) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pQASampLbl] PRIMARY KEY CLUSTERED 
(
	[SampleLabelId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[pQASampLbl] ADD  CONSTRAINT [DF_pQASampLbl_SampleLabelId]  DEFAULT (newid()) FOR [SampleLabelId]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01637', GetDate())
GO