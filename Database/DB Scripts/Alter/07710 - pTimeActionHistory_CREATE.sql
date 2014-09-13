IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTimeActionHistory]') AND type in (N'U'))
DROP TABLE [dbo].[pTimeActionHistory]
GO

CREATE TABLE [dbo].[pTimeActionHistory](
	[TimeActionHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[TACalTemplateID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pTimeActionHistory] PRIMARY KEY CLUSTERED 
(
	[TimeActionHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07710', GetDate())
GO
