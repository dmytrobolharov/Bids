IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pResourceLog_ResourceID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pResourceLog] DROP CONSTRAINT [DF_pResourceLog_ResourceID]
END

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pResourceLog]') AND type in (N'U'))
DROP TABLE [dbo].[pResourceLog]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pResourceLog](
	[ResourceLogID] [uniqueidentifier] NOT NULL,
	[ResourceTypeID] [int] NULL,
	[ResourceID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[ResourceLog] [nvarchar](200) NULL,
	[ResourceLogType] [varchar](2) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](150) NULL,
 CONSTRAINT [PK_pResourceLog] PRIMARY KEY CLUSTERED 
(
	[ResourceLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pResourceLog] ADD  CONSTRAINT [DF_pResourceLog_ResourceID]  DEFAULT (newsequentialid()) FOR [ResourceLogID]
GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03601', GetDate())

GO