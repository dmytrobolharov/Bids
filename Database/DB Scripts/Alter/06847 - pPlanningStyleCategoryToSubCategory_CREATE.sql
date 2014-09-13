IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningStyleCategoryToSubCategory_PlanningStyleCategoryToSubCategoryID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [DF_pPlanningStyleCategoryToSubCategory_PlanningStyleCategoryToSubCategoryID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningStyleCategoryToSubCategory]
GO


CREATE TABLE [dbo].[pPlanningStyleCategoryToSubCategory](
	[PlanningStyleCategoryToSubCategoryID] [uniqueidentifier] NOT NULL,
	[PlanningBrandID] [uniqueidentifier] NULL,
	[PlanningDivisionID] [uniqueidentifier] NULL,
	[PlanningStyleTypeID] [int] NULL,
	[PlanningStyleCategoryID] [uniqueidentifier] NULL,
	[SubCategoryID] [uniqueidentifier] NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningStyleCategoryToSubCategory] PRIMARY KEY CLUSTERED 
(
	[PlanningStyleCategoryToSubCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] ADD  CONSTRAINT [DF_pPlanningStyleCategoryToSubCategory_PlanningStyleCategoryToSubCategoryID]  DEFAULT (newid()) FOR [PlanningStyleCategoryToSubCategoryID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06847', GetDate())
GO
