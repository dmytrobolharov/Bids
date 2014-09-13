IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningBusiness_SEL]'))
DROP VIEW [dbo].[vwx_PlanningBusiness_SEL]
GO


CREATE VIEW [dbo].[vwx_PlanningBusiness_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pPlanningBusiness.PlanningBusinessID, dbo.pPlanningBusiness.PlanningID, dbo.pPlanningBusiness.PlanningFinancialID, 
                      dbo.pPlanningFinancial.PlanningFinancialText, dbo.pPlanningBusiness.PlanningFinancialSort, dbo.pPlanningBusiness.PlanningDivisionID, 
                      dbo.pPlanningBusiness.PlanningStyleTypeID, dbo.pPlanningBusiness.PlanningStyleCategoryID, dbo.pPlanningBusiness.PlanningDivision, 
                      dbo.pPlanningBusiness.PlanningStyleTypeDescription, dbo.pPlanningBusiness.PlanningStyleCategory, dbo.pPlanningBusiness.PlanningDivisionSort, 
                      dbo.pPlanningBusiness.PlanningStyleTypeSort, dbo.pPlanningBusiness.PlanningStyleCategorySort, 
                      dbo.pPlanningFinancial.PlanningFinancialDataType, dbo.pPlanningFinancial.PlanningFinancialDataFormat, dbo.pPlanningFinancial.PlanningFinancialCssClass, 
                      dbo.pPlanningBusiness.PlanningPlanningCh, dbo.pPlanningBusiness.PlanningLastYearCh, dbo.pPlanningBusiness.PlanningDIPCh, 
                      dbo.pPlanningBusiness.PlanningActualCh, dbo.pPlanningFinancial.Active, dbo.pPlanningBusiness.PlanningBrandID, dbo.pPlanningBusiness.PlanningBrand,
                      dbo.pPlanningBusiness.PlanningSubCategoryID, dbo.pPlanningBusiness.PlanningSubCategory,
                      dbo.pPlanningBusiness.SeasonYearID
FROM         dbo.pPlanningBusiness INNER JOIN
                      dbo.pPlanningFinancial ON dbo.pPlanningBusiness.PlanningFinancialID = dbo.pPlanningFinancial.PlanningFinancialID
WHERE     (dbo.pPlanningFinancial.Active = 1)
ORDER BY dbo.pPlanningBusiness.PlanningFinancialSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07422', GetDate())
GO
