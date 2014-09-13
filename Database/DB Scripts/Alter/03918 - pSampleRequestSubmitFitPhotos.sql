/****** Object:  Table [dbo].[pSampleRequestSubmitFitPhotos]    Script Date: 09/17/2012 14:13:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitFitPhotos]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSubmitFitPhotos]
GO

/****** Object:  Table [dbo].[pSampleRequestSubmitFitPhotos]    Script Date: 09/17/2012 14:13:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestSubmitFitPhotos](
	[FitPhotoId] [uniqueidentifier] NOT NULL,
	[FitPhotoDescription] [nvarchar](200) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](50) NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[Vendor] [nvarchar](50) NULL,
	[Submit] [int] NULL,
	[FrameCount] [int] NULL,
	[Width] [int] NULL,
	[Height] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pSampleRequestSubmitFitPhotos] PRIMARY KEY CLUSTERED 
(
	[FitPhotoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03918', GetDate())
GO