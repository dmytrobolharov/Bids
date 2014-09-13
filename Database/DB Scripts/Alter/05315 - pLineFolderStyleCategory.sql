/****** Object:  Table [dbo].[pLineFolderStyleCategory]    Script Date: 03/15/2013 12:36:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderStyleCategory]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderStyleCategory]
GO

/****** Object:  Table [dbo].[pLineFolderStyleCategory]    Script Date: 03/15/2013 12:36:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLineFolderStyleCategory](
	[LineFolderID] [uniqueidentifier] NOT NULL,
	[StyleCategoryID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pLineFolderStyleCategory] PRIMARY KEY CLUSTERED 
(
	[LineFolderID] ASC,
	[StyleCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05315', GetDate())
GO
