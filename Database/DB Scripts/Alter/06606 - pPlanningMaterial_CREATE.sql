IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningMaterial_PlanningMaterialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningMaterial] DROP CONSTRAINT [DF_pPlanningMaterial_PlanningMaterialID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningMaterial_PlanningMaterialDrop]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningMaterial] DROP CONSTRAINT [DF_pPlanningMaterial_PlanningMaterialDrop]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningMaterial_PlanningMaterialDropUser]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningMaterial] DROP CONSTRAINT [DF_pPlanningMaterial_PlanningMaterialDropUser]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningMaterial]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningMaterial]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pPlanningMaterial](
	[PlanningMaterialID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NOT NULL,
	[MaterialID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CustomField6] [nvarchar](200) NULL,
	[CustomField7] [nvarchar](200) NULL,
	[CustomField8] [nvarchar](200) NULL,
	[CustomField9] [nvarchar](200) NULL,
	[CustomField10] [nvarchar](200) NULL,
	[PlanningMaterialDrop] [int] NULL,
	[PlanningMaterialDropUser] [nvarchar](200) NULL,
	[PlanningMaterialDropDate] [datetime] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningMaterial] PRIMARY KEY CLUSTERED 
(
	[PlanningMaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningMaterial] ADD  CONSTRAINT [DF_pPlanningMaterial_PlanningMaterialID]  DEFAULT (newid()) FOR [PlanningMaterialID]
GO

ALTER TABLE [dbo].[pPlanningMaterial] ADD  CONSTRAINT [DF_pPlanningMaterial_PlanningMaterialDrop]  DEFAULT ((0)) FOR [PlanningMaterialDrop]
GO

ALTER TABLE [dbo].[pPlanningMaterial] ADD  CONSTRAINT [DF_pPlanningMaterial_PlanningMaterialDropUser]  DEFAULT ('NONE') FOR [PlanningMaterialDropUser]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06606', GetDate())
GO
