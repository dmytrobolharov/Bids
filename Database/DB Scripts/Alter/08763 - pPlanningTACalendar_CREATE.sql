IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningTACalendar_PlanningTACalendarID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningTACalendar] DROP CONSTRAINT [DF_pPlanningTACalendar_PlanningTACalendarID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningTACalendar]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningTACalendar]
GO

CREATE TABLE [dbo].[pPlanningTACalendar](
	[PlanningTACalendarID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[TACalTemplateID] [uniqueidentifier] NULL,
	[Sort] [nvarchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pPlanningTACalendar] PRIMARY KEY CLUSTERED 
(
	[PlanningTACalendarID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningTACalendar] ADD  CONSTRAINT [DF_pPlanningTACalendar_PlanningTACalendarID]  DEFAULT (newid()) FOR [PlanningTACalendarID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08763', GetDate())
GO
