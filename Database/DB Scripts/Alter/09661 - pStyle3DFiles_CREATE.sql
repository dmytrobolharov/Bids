IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyle3DFiles_Style3DFileID_1]') AND type = 'D')
	ALTER TABLE [dbo].[pStyle3DFiles] DROP CONSTRAINT [DF_pStyle3DFiles_Style3DFileID_1]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyle3DFiles]') AND type in (N'U'))
	DROP TABLE [dbo].[pStyle3DFiles]
GO

CREATE TABLE [dbo].[pStyle3DFiles](
	[Style3DFileID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[WorkflowItemID] [uniqueidentifier] NULL,
	[Style3DFileName] [nvarchar](500) NULL,
	[Style3DFileDescription] [nvarchar](max) NULL,
	[Style3DFileExt] [nvarchar](5) NULL,
	[Style3DFileSize] [nvarchar](20) NULL,
	[Style3DFileShared] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK__pStyle3DFiles__338A9CD5] PRIMARY KEY CLUSTERED 
(
	[Style3DFileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pStyle3DFiles] ADD  CONSTRAINT [DF_pStyle3DFiles_Style3DFileID_1]  DEFAULT (newid()) FOR [Style3DFileID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09661', GetDate())
GO