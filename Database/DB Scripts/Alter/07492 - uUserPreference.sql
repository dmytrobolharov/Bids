IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uUserPreference_UserPreferenceID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uUserPreference] DROP CONSTRAINT [DF_uUserPreference_UserPreferenceID]
END

GO


/****** Object:  Table [dbo].[uUserPreference]    Script Date: 04/14/2014 16:17:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserPreference]') AND type in (N'U'))
DROP TABLE [dbo].[uUserPreference]
GO


/****** Object:  Table [dbo].[uUserPreference]    Script Date: 04/14/2014 16:17:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uUserPreference](
	[UserPreferenceID] [uniqueidentifier] NOT NULL,
	[UserPreferenceObjectID] [uniqueidentifier] NULL,
	[UserPreferenceKey] [nvarchar](300) NULL,
	[UserPreferenceValue] [nvarchar](max) NULL,
	[TeamID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_uUserPreference] PRIMARY KEY CLUSTERED 
(
	[UserPreferenceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uUserPreference] ADD  CONSTRAINT [DF_uUserPreference_UserPreferenceID]  DEFAULT (newid()) FOR [UserPreferenceID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07492', GetDate())
GO