IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sDesk]') AND type in (N'U'))
DROP TABLE [dbo].[sDesk]
GO

CREATE TABLE [dbo].[sDesk](
	[DeskID] [uniqueidentifier] NOT NULL,
	[DeskName] [nvarchar](100) NOT NULL,
	[DeskThumbnail] [nvarchar](400) NOT NULL,
	[DeskContent] [nvarchar](400) NOT NULL,
	[DeskURL] [nvarchar](400) NOT NULL,
	[DeskSize] [nvarchar](10) NOT NULL,
	[DeskTheme] [nvarchar](50) NOT NULL,
	[DeskLink] [nvarchar](400) NOT NULL,
	[DeskActive] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sDesk] PRIMARY KEY CLUSTERED 
(
	[DeskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskID]  DEFAULT (NEWID()) FOR [DeskID]
GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskName]  DEFAULT ('') FOR [DeskName]
GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskThumbnail]  DEFAULT ('') FOR [DeskThumbnail]
GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskContent]  DEFAULT ('') FOR [DeskContent]
GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskURL]  DEFAULT ('') FOR [DeskURL]
GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskSize]  DEFAULT ('') FOR [DeskSize]
GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskTheme]  DEFAULT ('') FOR [DeskTheme]
GO

ALTER TABLE [dbo].[sDesk] ADD  CONSTRAINT [DF_sDesk_DeskLink]  DEFAULT ('') FOR [DeskLink]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05637', GetDate())
GO
