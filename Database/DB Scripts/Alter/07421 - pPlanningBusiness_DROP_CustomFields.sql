--pPlanningBusiness
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus1')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus1
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus2')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus2
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus3')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus3
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus4')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus4
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus5')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus5
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus6')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus6
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus7')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus7
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus8')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus8
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus9')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus9
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus10')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus10
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus11')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus11
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus12')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus12
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus13')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus13
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus14')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus14
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus15')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus15
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus16')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus16
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus17')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus17
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus18')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus18
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus19')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus19
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningBusiness' and COLUMN_NAME = N'PlanningBus20')
BEGIN
	ALTER TABLE pPlanningBusiness DROP COLUMN PlanningBus20
END
GO

--pPlanningFinancial
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningFinancial' and COLUMN_NAME = N'PlanningFinancialChannel1')
BEGIN
	ALTER TABLE pPlanningFinancial DROP COLUMN PlanningFinancialChannel1
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningFinancial' and COLUMN_NAME = N'PlanningFinancialChannel2')
BEGIN
	ALTER TABLE pPlanningFinancial DROP COLUMN PlanningFinancialChannel2
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningFinancial' and COLUMN_NAME = N'PlanningFinancialChannel3')
BEGIN
	ALTER TABLE pPlanningFinancial DROP COLUMN PlanningFinancialChannel3
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningFinancial' and COLUMN_NAME = N'PlanningFinancialChannel4')
BEGIN
	ALTER TABLE pPlanningFinancial DROP COLUMN PlanningFinancialChannel4
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pPlanningFinancial' and COLUMN_NAME = N'PlanningFinancialChannel5')
BEGIN
	ALTER TABLE pPlanningFinancial DROP COLUMN PlanningFinancialChannel5
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07421', GetDate())
GO
