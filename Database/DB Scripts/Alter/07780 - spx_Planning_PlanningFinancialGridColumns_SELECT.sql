IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_PlanningFinancialGridColumns_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_PlanningFinancialGridColumns_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_PlanningFinancialGridColumns_SELECT]
AS
BEGIN

	SELECT CAST(PlanningFinancialID AS nVARCHAR(100)) AS PlanningFinancialID, 
		PlanningFinancialCssClass, PlanningFinancialText, AllowPercentInput, Editable, HeaderEditable, PlanningFinancialDataType, PlanningFinancialDataFormat, 
		PlanningFinancialSort, 1 AS Sort 
	FROM pPlanningFinancial WHERE Active = 1
	UNION
	SELECT 'CMP__' + CAST(PlanningFinancialID AS nVARCHAR(40)) AS PlanningFinancialID, 
		PlanningFinancialCssClass, 'LY ' + PlanningFinancialText, AllowPercentInput, Editable, HeaderEditable, PlanningFinancialDataType, PlanningFinancialDataFormat, 
		PlanningFinancialSort, 0 AS Sort 
	FROM pPlanningFinancial WHERE PlanningFinancialID IN ('10000000-0000-0000-0000-000000000000','10000000-0000-0000-0000-000000000020','10000000-0000-0000-0000-000000000001')
	ORDER BY PlanningFinancialSort, Sort

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07780', GetDate())
GO
