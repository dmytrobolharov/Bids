IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningTemplate_PlanningTemplateId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningTemplate] DROP CONSTRAINT [DF_pPlanningTemplate_PlanningTemplateId]
END

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningTemplate]
GO

CREATE TABLE [dbo].[pPlanningTemplate](
	[PlanningTemplateId] [uniqueidentifier] NOT NULL,
	[PlanningTemplateName] [nvarchar](200) NULL,
	[FinancialPlanSchema] [nvarchar](200) NULL,
	[FinancialPlanEditSchema] [nvarchar](200) NULL,
	[FinancialPlanEditSearchSchema] [nvarchar](200) NULL,
	[MerchandisePlanSchema] [nvarchar](200) NULL,
	[MerchandisePlanEditSchema] [nvarchar](200) NULL,
	[MerchandisePlanEditSearchSchema] [nvarchar](200) NULL,
 CONSTRAINT [PK_pPlanningTemplate] PRIMARY KEY CLUSTERED 
(
	[PlanningTemplateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

DECLARE @PlanningID uniqueidentifier
SET @PlanningID = newid()

IF NOT EXISTS (SELECT * FROM pPlanningTemplate WHERE PlanningTemplateName = 'Default Template')
BEGIN
INSERT INTO pPlanningTemplate (PlanningTemplateId, PlanningTemplateName, FinancialPlanSchema, FinancialPlanEditSchema, FinancialPlanEditSearchSchema,
	MerchandisePlanSchema, MerchandisePlanEditSchema, MerchandisePlanEditSearchSchema)
	
	VALUES (@PlanningID, 'Default Template', 'Planning_FinancialPlan_Default.xml', 'Planning_FinancialPlan_Edit_Default.xml', 'Planning_Folder_FinancialPlan_Edit_Search.xml',
	 'Planning_MerchandisePlan_Default.xml', 'Planning_MerchandisePlan_Edit_Default.xml', 'Planning_Folder_MerchandisePlan_Edit_Search.xml')
	
UPDATE pPlanning SET PlanningTemplateID = @PlanningID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08237', GetDate())
GO

	
	
