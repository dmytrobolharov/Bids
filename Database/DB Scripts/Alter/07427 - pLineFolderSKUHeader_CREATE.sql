IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderSKUHeader_LineFolderSKHeaderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderSKUHeader] DROP CONSTRAINT [DF_pLineFolderSKUHeader_LineFolderSKHeaderID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderSKUHeader]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderSKUHeader]
GO

CREATE TABLE [dbo].[pLineFolderSKUHeader](
	[LineFolderSKUHeaderID] [uniqueidentifier] NOT NULL,
	[LineFolderID] [uniqueidentifier] NULL,
	[StyleSKUTemplateID] [uniqueidentifier] NULL,
	[LineFolderSKUHeaderName] [nvarchar](200) NULL,
	[WorkStatus] [int] NULL,
	[SortOrder] [nvarchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pLineFolderSKUHeader] PRIMARY KEY CLUSTERED 
(
	[LineFolderSKUHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLineFolderSKUHeader] ADD  CONSTRAINT [DF_pLineFolderSKUHeader_LineFolderSKHeaderID]  DEFAULT (newid()) FOR [LineFolderSKUHeaderID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07427', GetDate())
GO
