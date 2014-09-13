/****** Object:  Table [dbo].[pLineFolderStyleType]    Script Date: 03/15/2013 12:34:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderStyleType]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderStyleType]
GO

/****** Object:  Table [dbo].[pLineFolderStyleType]    Script Date: 03/15/2013 12:34:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLineFolderStyleType](
	[LineFolderID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
 CONSTRAINT [PK_pLineFolderStyleType] PRIMARY KEY CLUSTERED 
(
	[LineFolderID] ASC,
	[StyleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05316', GetDate())
GO
