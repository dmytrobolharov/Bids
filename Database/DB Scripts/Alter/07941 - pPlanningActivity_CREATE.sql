IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningActivity_PlanningActivityID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningActivity] DROP CONSTRAINT [DF_pPlanningActivity_PlanningActivityID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningActivity]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningActivity]
GO


CREATE TABLE [dbo].[pPlanningActivity](
	[PlanningActivityID] [uniqueidentifier] NOT NULL,
	[PlanningActivityTypeID] [uniqueidentifier] NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[ParamValues] [nvarchar](200) NULL,
 CONSTRAINT [PK_pPlanningActivity] PRIMARY KEY CLUSTERED 
(
	[PlanningActivityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningActivity] ADD  CONSTRAINT [DF_pPlanningActivity_PlanningActivityID]  DEFAULT (newid()) FOR [PlanningActivityID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07941', GetDate())
GO
