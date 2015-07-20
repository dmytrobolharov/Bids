IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineListType_LineListTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineListType] DROP CONSTRAINT [DF_pLineListType_LineListTypeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineListType_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineListType] DROP CONSTRAINT [DF_pLineListType_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineListType_Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineListType] DROP CONSTRAINT [DF_pLineListType_Sort]
END

GO

/****** Object:  Table [dbo].[pLineListType]    Script Date: 02/26/2013 16:11:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineListType]') AND type in (N'U'))
DROP TABLE [dbo].[pLineListType]
GO

/****** Object:  Table [dbo].[pLineListType]    Script Date: 02/26/2013 16:11:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLineListType](
	[LineListTypeID] [uniqueidentifier] NOT NULL,
	[LineListCode] [nvarchar](10) NULL,
	[LineListType] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_pLineListType] PRIMARY KEY CLUSTERED 
(
	[LineListTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLineListType] ADD  CONSTRAINT [DF_pLineListType_LineListTypeID]  DEFAULT (newid()) FOR [LineListTypeID]
GO

ALTER TABLE [dbo].[pLineListType] ADD  CONSTRAINT [DF_pLineListType_Active]  DEFAULT ((0)) FOR [Active]
GO

ALTER TABLE [dbo].[pLineListType] ADD  CONSTRAINT [DF_pLineListType_Sort]  DEFAULT ((0)) FOR [Sort]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05169', GetDate())
GO
