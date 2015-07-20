/* Add new values to pPlanningFinancial */

INSERT INTO pPlanningFinancial (PlanningFinancialID, PlanningFinancialDataType, PlanningFinancialDataFormat, PlanningFinancialCssClass,
				PlanningFinancialText, PlanningFinancialSort, Active, Editable, AllowPercentInput)
SELECT '10000000-0000-0000-0000-000000000020', 'decimal', '0', 'fontHead', '# of Dev.Styles', '0001', '1', '1', '1'
UNION
SELECT '10000000-0000-0000-0000-000000000021', 'decimal', '0', 'font', 'Projected Ecom Units', '0007', '1', '1', '1'
UNION
SELECT '10000000-0000-0000-0000-000000000022', 'decimal', '0', 'font', 'Total Projected Units', '0008', '1', '0', '0'
UNION
SELECT '10000000-0000-0000-0000-000000000023', 'decimal', '0.00', 'fontRed', 'Avg Ecom Price / Unit', '0012', '1', '1', '0'
UNION
SELECT '10000000-0000-0000-0000-000000000024', 'decimal', '0.00', 'fontRed', 'Planned Budget', '0013', '1', '1', '0'
UNION
SELECT '10000000-0000-0000-0000-000000000025', 'decimal', '0.00', 'fontRed', 'Extended Ecom', '0017', '1', '0', '0'
UNION
SELECT '10000000-0000-0000-0000-000000000026', 'decimal', '0.00', 'fontRed', 'Gross Profit', '0018', '1', '0', '0'
UNION
SELECT '10000000-0000-0000-0000-000000000027', 'percent', '{0:p}', 'font', 'Ecom Gross Margin %', '0021', '1', '0', '0'
UNION
SELECT '10000000-0000-0000-0000-000000000028', 'percent', '{0:p}', 'font', 'Gross Margin %', '0022', '1', '0', '0'

/* UPDATE Sort field in table pPlanningFinancial  */

UPDATE pPlanningFinancial 
SET PlanningFinancialText = '# of Planned Styles'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000000'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = '# of Carry Over Styles', PlanningFinancialSort = '0002'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000001'

UPDATE pPlanningFinancial 
SET PlanningFinancialSort = '0003'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000002'

UPDATE pPlanningFinancial 
SET PlanningFinancialSort = '0004'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000003'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Projected Wholesale Units', PlanningFinancialSort = '0005'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000004'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Projected Retail Units', PlanningFinancialSort = '0006'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000005'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Avg Cost / Unit', PlanningFinancialSort = '0009'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000006'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Avg Wholesale Price / Unit', PlanningFinancialSort = '0010'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000007'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Avg Retail Price / Unit', PlanningFinancialSort = '0011'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000008'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Extended Cost', PlanningFinancialSort = '0014'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000011'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Extended Wholesale', PlanningFinancialSort = '0015'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000009'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Extended Retail', PlanningFinancialSort = '0016'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000010'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Wholesale Gross Margin %', PlanningFinancialSort = '0019'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000012'

UPDATE pPlanningFinancial 
SET PlanningFinancialText = 'Retail Gross Margin %', PlanningFinancialSort = '0020'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000013'


/* UPDATE Sort field in table pPlanningBusiness  */

UPDATE pPlanningBusiness 
SET PlanningFinancialText = '# of Planned Styles'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000000'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = '# of Carry Over Styles', PlanningFinancialSort = '0002'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000001'

UPDATE pPlanningBusiness 
SET PlanningFinancialSort = '0003'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000002'

UPDATE pPlanningBusiness 
SET PlanningFinancialSort = '0004'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000003'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Projected Wholesale Units', PlanningFinancialSort = '0005'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000004'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Projected Retail Units', PlanningFinancialSort = '0006'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000005'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Avg Cost / Unit', PlanningFinancialSort = '0009'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000006'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Avg Wholesale Price / Unit', PlanningFinancialSort = '0010'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000007'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Avg Retail Price / Unit', PlanningFinancialSort = '0011'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000008'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Extended Cost', PlanningFinancialSort = '0014'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000011'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Extended Wholesale', PlanningFinancialSort = '0015'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000009'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Extended Retail', PlanningFinancialSort = '0016'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000010'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Wholesale Gross Margin %', PlanningFinancialSort = '0019'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000012'

UPDATE pPlanningBusiness 
SET PlanningFinancialText = 'Retail Gross Margin %', PlanningFinancialSort = '0020'
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000013'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06857', GetDate())
GO
