IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningBusiness_SEL]'))
DROP VIEW [dbo].[vwx_PlanningBusiness_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningBusiness_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pPlanningBusiness.PlanningBusinessID, dbo.pPlanningBusiness.PlanningID, dbo.pPlanningBusiness.PlanningFinancialID, 
                      dbo.pPlanningFinancial.PlanningFinancialText, dbo.pPlanningBusiness.PlanningFinancialSort, dbo.pPlanningBusiness.PlanningDivisionID, 
                      dbo.pPlanningBusiness.PlanningStyleTypeID, dbo.pPlanningBusiness.PlanningStyleCategoryID, dbo.pPlanningBusiness.PlanningDivision, 
                      dbo.pPlanningBusiness.PlanningStyleTypeDescription, dbo.pPlanningBusiness.PlanningStyleCategory, dbo.pPlanningBusiness.PlanningDivisionSort, 
                      dbo.pPlanningBusiness.PlanningStyleTypeSort, dbo.pPlanningBusiness.PlanningStyleCategorySort, dbo.pPlanningBusiness.PlanningBus1, 
                      dbo.pPlanningBusiness.PlanningBus2, dbo.pPlanningBusiness.PlanningBus3, dbo.pPlanningBusiness.PlanningBus4, 
                      dbo.pPlanningBusiness.PlanningBus5, dbo.pPlanningBusiness.PlanningBus6, dbo.pPlanningBusiness.PlanningBus7, 
                      dbo.pPlanningBusiness.PlanningBus8, dbo.pPlanningBusiness.PlanningBus9, dbo.pPlanningBusiness.PlanningBus10, 
                      dbo.pPlanningBusiness.PlanningBus11, dbo.pPlanningBusiness.PlanningBus12, dbo.pPlanningBusiness.PlanningBus13, 
                      dbo.pPlanningBusiness.PlanningBus14, dbo.pPlanningBusiness.PlanningBus15, dbo.pPlanningBusiness.PlanningBus16, 
                      dbo.pPlanningBusiness.PlanningBus17, dbo.pPlanningBusiness.PlanningBus18, dbo.pPlanningBusiness.PlanningBus19, 
                      dbo.pPlanningBusiness.PlanningBus20, dbo.pPlanningFinancial.PlanningFinancialDataType, dbo.pPlanningFinancial.PlanningFinancialDataFormat, 
                      dbo.pPlanningFinancial.PlanningFinancialCssClass, dbo.pPlanningBusiness.PlanningPlanningCh, dbo.pPlanningBusiness.PlanningLastYearCh, 
                      dbo.pPlanningBusiness.PlanningDIPCh, dbo.pPlanningBusiness.PlanningActualCh, dbo.pPlanningFinancial.Active
FROM         dbo.pPlanningBusiness INNER JOIN
                      dbo.pPlanningFinancial ON dbo.pPlanningBusiness.PlanningFinancialID = dbo.pPlanningFinancial.PlanningFinancialID
WHERE     (dbo.pPlanningFinancial.Active = 1)
ORDER BY dbo.pPlanningBusiness.PlanningFinancialSort
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06179', GetDate())
GO
