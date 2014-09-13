IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningDivision_PlanningDivisionID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningDivision] DROP CONSTRAINT [DF_pPlanningDivision_PlanningDivisionID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningDivision]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningDivision]
GO

CREATE TABLE [dbo].[pPlanningDivision](
	[PlanningDivisionID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[DivisionID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningDivision] PRIMARY KEY CLUSTERED 
(
	[PlanningDivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningDivision] ADD  CONSTRAINT [DF_pPlanningDivision_PlanningDivisionID]  DEFAULT (newid()) FOR [PlanningDivisionID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06167', GetDate())
GO
