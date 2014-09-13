IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleQuoteItemFieldSort_ItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pRadGridFieldSort] DROP CONSTRAINT [DF_pStyleQuoteItemFieldSort_ItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pRadGridFieldSort_ColumnOrderIndex]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pRadGridFieldSort] DROP CONSTRAINT [DF_pRadGridFieldSort_ColumnOrderIndex]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pRadGridFieldSort_ColumnGroupByIndex]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pRadGridFieldSort] DROP CONSTRAINT [DF_pRadGridFieldSort_ColumnGroupByIndex]
END

GO

/****** Object:  Table [dbo].[pRadGridFieldSort]    Script Date: 11/28/2012 16:49:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pRadGridFieldSort]') AND type in (N'U'))
DROP TABLE [dbo].[pRadGridFieldSort]
GO

/****** Object:  Table [dbo].[pRadGridFieldSort]    Script Date: 11/28/2012 16:49:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pRadGridFieldSort](
	[RadGridSortID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[RadGridFormName] [nvarchar](200) NOT NULL,
	[ColumnUniqueName] [nvarchar](200) NOT NULL,
	[ColumnOrderIndex] [int] NOT NULL,
	[ColumnGroupByIndex] [int] NOT NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pRadGridFieldSort] PRIMARY KEY CLUSTERED 
(
	[RadGridSortID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pRadGridFieldSort] ADD  CONSTRAINT [DF_pStyleQuoteItemFieldSort_ItemID]  DEFAULT (newid()) FOR [RadGridSortID]
GO

ALTER TABLE [dbo].[pRadGridFieldSort] ADD  CONSTRAINT [DF_pRadGridFieldSort_ColumnOrderIndex]  DEFAULT ((-1)) FOR [ColumnOrderIndex]
GO

ALTER TABLE [dbo].[pRadGridFieldSort] ADD  CONSTRAINT [DF_pRadGridFieldSort_ColumnGroupByIndex]  DEFAULT ((-1)) FOR [ColumnGroupByIndex]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04479', GetDate())
GO
