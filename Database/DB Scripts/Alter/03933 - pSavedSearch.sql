IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSavedSearch]') AND type in (N'U'))
DROP TABLE [dbo].[pSavedSearch]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSavedSearch](
	[SavedSearchID] [uniqueidentifier] NOT NULL,
	[TeamID] [uniqueidentifier] NULL,
	[StyleTypeID] [int] NULL,
	[SearchName] [nvarchar](200) NULL,
	[SearchDescription] [nvarchar](max) NULL,
	[Active] [int] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pSavedSearch] PRIMARY KEY CLUSTERED 
(
	[SavedSearchID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03933', GetDate())
GO
