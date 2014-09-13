IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningHistory]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningHistory]
GO

CREATE TABLE [dbo].[pPlanningHistory](
	[PlanningHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pPlanningHistory] PRIMARY KEY CLUSTERED 
(
	[PlanningHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06164', GetDate())
GO
