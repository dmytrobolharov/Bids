IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningConfig_PlanningConfigID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningConfig] DROP CONSTRAINT [DF_pPlanningConfig_PlanningConfigID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningConfig]
GO


CREATE TABLE [dbo].[pPlanningConfig](
	[PlanningConfigID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NOT NULL,
	[DivisionID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
	[StyleCategoryID] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](100) NULL,
	[WorkflowTemplateID] [uniqueidentifier] NULL,
	[SizeClass] [nvarchar](50) NULL,
	[SizeRange] [nvarchar](50) NULL,
	[Status] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[StyleThemeID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningConfig_1] PRIMARY KEY CLUSTERED 
(
	[PlanningConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningConfig] ADD  CONSTRAINT [DF_pPlanningConfig_PlanningConfigID]  DEFAULT (newid()) FOR [PlanningConfigID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06390', GetDate())
GO
