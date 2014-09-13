IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningSeasonYear_PlanningSeasonYearID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningSeasonYear] DROP CONSTRAINT [DF_pPlanningSeasonYear_PlanningSeasonYearID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningSeasonYear]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningSeasonYear]
GO


CREATE TABLE [dbo].[pPlanningSeasonYear](
	[PlanningSeasonYearID] [uniqueidentifier] NOT NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[PlanningSeason] [nvarchar](200) NULL,
	[PlanningYear] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_pPlanningSeasonYear] PRIMARY KEY CLUSTERED 
(
	[PlanningSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningSeasonYear] ADD  CONSTRAINT [DF_pPlanningSeasonYear_PlanningSeasonYearID]  DEFAULT (newid()) FOR [PlanningSeasonYearID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06169', GetDate())
GO
