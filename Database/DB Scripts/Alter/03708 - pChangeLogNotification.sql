IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pChangeLogNotification_ChangeLogNotificationID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pChangeLogNotification] DROP CONSTRAINT [DF_pChangeLogNotification_ChangeLogNotificationID]
END

GO

/****** Object:  Table [dbo].[pChangeLogNotification]    Script Date: 07/23/2012 15:02:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pChangeLogNotification]') AND type in (N'U'))
DROP TABLE [dbo].[pChangeLogNotification]
GO

/****** Object:  Table [dbo].[pChangeLogNotification]    Script Date: 07/23/2012 15:02:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pChangeLogNotification](
	[ChangeLogNotificationID] [uniqueidentifier] NOT NULL,
	[ChangeLogBatchID] [uniqueidentifier] NOT NULL,
	[ChangeLogItemID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pChangeLogNotification] PRIMARY KEY CLUSTERED 
(
	[ChangeLogNotificationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pChangeLogNotification] ADD  CONSTRAINT [DF_pChangeLogNotification_ChangeLogNotificationID]  DEFAULT (newid()) FOR [ChangeLogNotificationID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03708', GetDate())
GO