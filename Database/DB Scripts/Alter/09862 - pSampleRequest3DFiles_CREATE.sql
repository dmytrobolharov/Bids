IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequest3DFiles_SampleRequest3DFileID_1]') AND type = 'D')
	ALTER TABLE [dbo].[pSampleRequest3DFiles] DROP CONSTRAINT [DF_pSampleRequest3DFiles_SampleRequest3DFileID_1]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequest3DFiles]') AND type in (N'U'))
	DROP TABLE [dbo].[pSampleRequest3DFiles]
GO

CREATE TABLE [dbo].[pSampleRequest3DFiles](
	[SampleRequest3DFileID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestSubmitID] [uniqueidentifier] NULL,
	[SampleRequest3DFileName] [nvarchar](500) NULL,
	[SampleRequest3DFileDescription] [nvarchar](max) NULL,
	[SampleRequest3DFileExt] [nvarchar](5) NULL,
	[SampleRequest3DFileSize] [nvarchar](20) NULL,
	[SampleRequest3DFileShared] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK__pSampleRequest3DFiles__338A9CD5] PRIMARY KEY CLUSTERED 
(
	[SampleRequest3DFileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pSampleRequest3DFiles] ADD  CONSTRAINT [DF_pSampleRequest3DFiles_SampleRequest3DFileID_1]  DEFAULT (newid()) FOR [SampleRequest3DFileID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09862', GetDate())
GO