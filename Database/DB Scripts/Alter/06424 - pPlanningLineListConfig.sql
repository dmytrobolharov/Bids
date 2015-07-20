IF		EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningLineListConfig_PlanningConfigID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningLineListConfig] DROP CONSTRAINT [DF_pPlanningLineListConfig_PlanningConfigID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningLineListConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningLineListConfig]
GO

CREATE TABLE [dbo].[pPlanningLineListConfig](
	[PlanningConfigID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NOT NULL,
	[DivisionID] [uniqueidentifier] NULL,
	[StyleTypeID] [int] NULL,
	[StyleCategoryID] [uniqueidentifier] NULL,
	[LineFolderDescription] [nvarchar](200) NULL,
	[LineListTypeID] [uniqueidentifier] NULL,
	[Days] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL
 CONSTRAINT [PK_pPlanningLineListConfig_1] PRIMARY KEY CLUSTERED 
(
	[PlanningConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningLineListConfig] ADD  CONSTRAINT [DF_pPlanningLineListConfig_PlanningConfigID]  DEFAULT (newid()) FOR [PlanningConfigID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06424', GetDate())
GO
