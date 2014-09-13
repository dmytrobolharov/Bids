
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uUserPreferenceObject_UserPreferenceObectID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uUserPreferenceObject] DROP CONSTRAINT [DF_uUserPreferenceObject_UserPreferenceObectID]
END

GO


/****** Object:  Table [dbo].[uUserPreferenceObject]    Script Date: 04/14/2014 16:18:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserPreferenceObject]') AND type in (N'U'))
DROP TABLE [dbo].[uUserPreferenceObject]
GO

/****** Object:  Table [dbo].[uUserPreferenceObject]    Script Date: 04/14/2014 16:18:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uUserPreferenceObject](
	[UserPreferenceObectID] [uniqueidentifier] NOT NULL,
	[UserPreferenceObjectName] [nvarchar](300) NOT NULL,
	[UserPreferencePage] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_uUserPreferenceObject] PRIMARY KEY CLUSTERED 
(
	[UserPreferenceObectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uUserPreferenceObject] ADD  CONSTRAINT [DF_uUserPreferenceObject_UserPreferenceObectID]  DEFAULT (newid()) FOR [UserPreferenceObectID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07493', GetDate())
GO