/****** Object:  Table [dbo].[pSampleRequestSubmitFitPhotosComments]    Script Date: 09/17/2012 14:10:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitFitPhotosComments]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSubmitFitPhotosComments]
GO

/****** Object:  Table [dbo].[pSampleRequestSubmitFitPhotosComments]    Script Date: 09/17/2012 14:10:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestSubmitFitPhotosComments](
	[FitPhotoCommentId] [uniqueidentifier] NOT NULL,
	[FitPhotoId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03919', GetDate())
GO