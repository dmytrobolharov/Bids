IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineListDocument_LineListDocumentID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineListDocument] DROP CONSTRAINT [DF_pLineListDocument_LineListDocumentID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineListDocument]') AND type in (N'U'))
DROP TABLE [dbo].[pLineListDocument]
GO


CREATE TABLE [dbo].[pLineListDocument](
	[LineListDocumentID] [uniqueidentifier] NOT NULL,
	[LineFolderID] [uniqueidentifier] NULL,
	[LineListDocumentName] [nvarchar](500) NULL,
	[LineListDocumentDescription] [nvarchar](4000) NULL,
	[LineListDocumentExt] [nvarchar](5) NULL,
	[LineListDocumentSize] [nvarchar](20) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MChange] [int] NULL,
	[SystemServerStorageID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pLineListDocument] PRIMARY KEY CLUSTERED 
(
	[LineListDocumentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLineListDocument] ADD  CONSTRAINT [DF_pLineListDocument_LineListDocumentID]  DEFAULT (newid()) FOR [LineListDocumentID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07178', GetDate())
GO
