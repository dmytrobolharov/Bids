IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSubmitFitVideo_FitVideoID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSubmitFitVideo] DROP CONSTRAINT [DF_pSampleRequestSubmitFitVideo_FitVideoID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitFitVideo]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSubmitFitVideo]
GO

CREATE TABLE [dbo].[pSampleRequestSubmitFitVideo](
	[FitVideoID] [uniqueidentifier] NOT NULL,
	[SampleRequestSubmitID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[CTeamID] [uniqueidentifier] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pSampleRequestSubmitFitVideo] PRIMARY KEY CLUSTERED 
(
	[FitVideoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestSubmitFitVideo] ADD  CONSTRAINT [DF_pSampleRequestSubmitFitVideo_FitVideoID]  DEFAULT (newid()) FOR [FitVideoID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07202', GetDate())
GO
