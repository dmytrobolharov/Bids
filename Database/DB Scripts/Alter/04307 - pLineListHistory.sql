IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineListHistory]') AND type in (N'U'))
DROP TABLE [dbo].[pLineListHistory]
GO

CREATE TABLE [dbo].[pLineListHistory](
	[LineListHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[LineFolderID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pLineListHistory] PRIMARY KEY CLUSTERED 
(
	[LineListHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04307', GetDate())
GO
