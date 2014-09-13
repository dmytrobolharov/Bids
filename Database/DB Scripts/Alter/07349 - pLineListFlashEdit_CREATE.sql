IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineListFlashEdit_LineListFlashEditID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineListFlashEdit] DROP CONSTRAINT [DF_pLineListFlashEdit_LineListFlashEditID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineListFlashEdit]') AND type in (N'U'))
DROP TABLE [dbo].[pLineListFlashEdit]
GO
CREATE TABLE [dbo].[pLineListFlashEdit](
	[LineListFlashEditID] [uniqueidentifier] NOT NULL,
	[LineListFlashEditName] [nvarchar](50) NULL,
	[LineListFlashEditDescription] [nvarchar](400) NULL,
	[LineListFlashEditSort] [int] NULL,
	[LineListFlashEditActive] [int] NULL,
	[LineListFlashEditGridXML] [nvarchar](200) NULL,
	[LineListFlashEditBatchXML] [nvarchar](200) NULL,
	[LineListFlashEditSearchXML] [nvarchar](200) NULL,
	[LineListFlashEditUpdateLogicSPX] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pLineListFlashEdit] PRIMARY KEY CLUSTERED 
(
	[LineListFlashEditID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLineListFlashEdit] ADD  CONSTRAINT [DF_pLineListFlashEdit_LineListFlashEditID]  DEFAULT (newid()) FOR [LineListFlashEditID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07349', GetDate())
GO
