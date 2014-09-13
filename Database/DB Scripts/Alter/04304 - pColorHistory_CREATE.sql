IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorHistory]') AND type in (N'U'))
DROP TABLE [dbo].[pColorHistory]
GO

CREATE TABLE [dbo].[pColorHistory](
	[ColorHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[ColorFolderID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pColorHistory] PRIMARY KEY CLUSTERED 
(
	[ColorHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04304', GetDate())
GO
