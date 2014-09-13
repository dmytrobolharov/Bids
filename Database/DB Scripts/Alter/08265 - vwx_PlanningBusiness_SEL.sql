IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningBusiness_SEL]'))
DROP VIEW [dbo].[vwx_PlanningBusiness_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningBusiness_SEL]
AS

WITH MerchandiseFinancials AS (
	SELECT V.*, 1 As IsMerchandise FROM (
	VALUES ('10000000-0000-0000-0000-000000000000') /* # of Planned Styles */
		, ('10000000-0000-0000-0000-000000000019') /* # of Planned Colorways */
		, ('10000000-0000-0000-0000-000000000020') /* # of Over Dev. Styles */
		, ('10000000-0000-0000-0000-000000000001') /* # of Carry Over Styles */
		, ('10000000-0000-0000-0000-000000000004') /* Projected Wholesale Units */
		, ('10000000-0000-0000-0000-000000000005') /* Projected Retail Units */
		, ('10000000-0000-0000-0000-000000000021') /* Projected Ecom Units */
		, ('10000000-0000-0000-0000-000000000022') /* Total Projected Units */) 
	V(FinancialID)
), FinancialFinancials AS (
	SELECT PlanningFinancialID, 1 AS IsFinancial FROM pPlanningFinancial
	WHERE PlanningFinancialID NOT IN (
		 '10000000-0000-0000-0000-000000000012' /* Wholesale Gross Margin % */
		,'10000000-0000-0000-0000-000000000013' /* Retail Gross Margin % */
		,'10000000-0000-0000-0000-000000000027' /* Ecom Gross Margin % */)

)
SELECT TOP (100) PERCENT dbo.pPlanningBusiness.PlanningBusinessID
	,dbo.pPlanningBusiness.PlanningID
	,dbo.pPlanningBusiness.PlanningFinancialID
	,dbo.pPlanningFinancial.PlanningFinancialText
	,dbo.pPlanningBusiness.PlanningFinancialSort
	,dbo.pPlanningBusiness.PlanningDivisionID
	,dbo.pPlanningBusiness.PlanningStyleTypeID
	,dbo.pPlanningBusiness.PlanningStyleCategoryID
	,dbo.pPlanningBusiness.PlanningDivision
	,dbo.pPlanningBusiness.PlanningStyleTypeDescription
	,dbo.pPlanningBusiness.PlanningStyleCategory
	,dbo.pPlanningBusiness.PlanningDivisionSort
	,dbo.pPlanningBusiness.PlanningStyleTypeSort
	,dbo.pPlanningBusiness.PlanningStyleCategorySort
	,dbo.pPlanningFinancial.PlanningFinancialDataType
	,dbo.pPlanningFinancial.PlanningFinancialDataFormat
	,dbo.pPlanningFinancial.PlanningFinancialCssClass
	,dbo.pPlanningBusiness.PlanningPlanningCh
	,dbo.pPlanningBusiness.PlanningLastYearCh
	,dbo.pPlanningBusiness.PlanningDIPCh
	,dbo.pPlanningBusiness.PlanningActualCh
	,dbo.pPlanningFinancial.Active
	,dbo.pPlanningBusiness.PlanningBrandID
	,dbo.pPlanningBusiness.PlanningBrand
	,dbo.pPlanningBusiness.PlanningSubCategoryID
	,dbo.pPlanningBusiness.PlanningSubCategory
	,dbo.pPlanningBusiness.SeasonYearID
	,ISNULL(mf.IsMerchandise, 0) AS IsMerchandise
	,ISNULL(ff.IsFinancial, 0) AS IsFinancial
FROM dbo.pPlanningBusiness
INNER JOIN dbo.pPlanningFinancial ON dbo.pPlanningBusiness.PlanningFinancialID = dbo.pPlanningFinancial.PlanningFinancialID
LEFT JOIN MerchandiseFinancials mf ON dbo.pPlanningBusiness.PlanningFinancialID = mf.FinancialID
LEFT JOIN FinancialFinancials ff ON dbo.pPlanningBusiness.PlanningFinancialID = ff.PlanningFinancialID
WHERE (dbo.pPlanningFinancial.Active = 1)
ORDER BY dbo.pPlanningBusiness.PlanningFinancialSort



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08265', GetDate())
GO
