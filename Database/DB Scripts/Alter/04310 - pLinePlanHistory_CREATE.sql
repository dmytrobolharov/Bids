IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanHistory]') AND type in (N'U'))
DROP TABLE [dbo].[pLinePlanHistory]
GO

CREATE TABLE [dbo].[pLinePlanHistory](
	[LinePlanHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[LinePlanID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pLinePlanHistory] PRIMARY KEY CLUSTERED 
(
	[LinePlanHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04310', GetDate())
GO
