IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningActivityView]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningActivityView]
GO

CREATE TABLE [dbo].[pPlanningActivityView](
	[PlanningActivityID] [uniqueidentifier] NOT NULL,
	[TeamID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pPlanningActivityView] PRIMARY KEY CLUSTERED 
(
	[PlanningActivityID] ASC,
	[TeamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07942', GetDate())
GO
