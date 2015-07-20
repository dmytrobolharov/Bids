IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderSKUHeaderDimType_LineFolderSKUHeaderDimTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderSKUHeaderDimType] DROP CONSTRAINT [DF_pLineFolderSKUHeaderDimType_LineFolderSKUHeaderDimTypeID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderSKUHeaderDimType]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderSKUHeaderDimType]
GO

CREATE TABLE [dbo].[pLineFolderSKUHeaderDimType](
	[LineFolderSKUHeaderDimTypeID] [uniqueidentifier] NOT NULL,
	[LineFolderSKUHeaderID] [uniqueidentifier] NULL,
	[DimTypeID] [uniqueidentifier] NULL,
	[Position] [int] NULL,
 CONSTRAINT [PK_pLineFolderSKUHeaderDimType] PRIMARY KEY CLUSTERED 
(
	[LineFolderSKUHeaderDimTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLineFolderSKUHeaderDimType] ADD  CONSTRAINT [DF_pLineFolderSKUHeaderDimType_LineFolderSKUHeaderDimTypeID]  DEFAULT (newid()) FOR [LineFolderSKUHeaderDimTypeID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07428', GetDate())
GO
