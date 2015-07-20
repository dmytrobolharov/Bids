IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_PlanningFinancialGridColumns_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_PlanningFinancialGridColumns_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_PlanningFinancialGridColumns_SELECT]
	@IsMerchandisePlan BIT = 0
AS
BEGIN

	SELECT CAST(PlanningFinancialID AS nVARCHAR(100)) AS PlanningFinancialID, 
		PlanningFinancialCssClass, PlanningFinancialText, AllowPercentInput, Editable, HeaderEditable, PlanningFinancialDataType, PlanningFinancialDataFormat, 
		PlanningFinancialSort, 1 AS Sort 
	FROM pPlanningFinancial WHERE Active = 1
		AND (@IsMerchandisePlan = 0 
			OR PlanningFinancialID NOT IN (
				  '10000000-0000-0000-0000-000000000007' /* Avg Wholesale Price / Unit */
				, '10000000-0000-0000-0000-000000000008' /* Avg Retail Price / Unit */
				, '10000000-0000-0000-0000-000000000023' /* Avg Ecom Price / Unit */
				, '10000000-0000-0000-0000-000000000024' /* Planned Budget */
				, '10000000-0000-0000-0000-000000000011' /* Extended Cost */
				, '10000000-0000-0000-0000-000000000009' /* Extended Wholesale */
				, '10000000-0000-0000-0000-000000000010' /* Extended Retail */
				, '10000000-0000-0000-0000-000000000025' /* Extended Ecom */
				, '10000000-0000-0000-0000-000000000026' /* Gross Profit */
				, '10000000-0000-0000-0000-000000000012' /* Wholesale Gross Margin % */
				, '10000000-0000-0000-0000-000000000013' /* Retail Gross Margin % */
				, '10000000-0000-0000-0000-000000000027' /* Ecom Gross Margin % */
				, '10000000-0000-0000-0000-000000000028' /* Gross Margin % */))
	UNION
	SELECT 'CMP__' + CAST(PlanningFinancialID AS nVARCHAR(40)) AS PlanningFinancialID, 
		PlanningFinancialCssClass, 'LY ' + PlanningFinancialText, AllowPercentInput, Editable, HeaderEditable, PlanningFinancialDataType, PlanningFinancialDataFormat, 
		PlanningFinancialSort, 0 AS Sort 
	FROM pPlanningFinancial WHERE PlanningFinancialID IN ('10000000-0000-0000-0000-000000000000','10000000-0000-0000-0000-000000000020','10000000-0000-0000-0000-000000000001')
	ORDER BY PlanningFinancialSort, Sort

END



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07800', GetDate())
GO

