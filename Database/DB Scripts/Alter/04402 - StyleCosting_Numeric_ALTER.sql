/****** Style Costing Table *****/

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField6' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField6 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField8' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField8 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField10' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField10 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField12' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField12 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField13' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField13 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField14' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField14 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField20' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField20 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField21' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField21 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField36' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField36 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField38' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField38 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField37' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField37 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField39' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField39 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField16' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField16 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField22' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField22 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField42' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField42 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField43' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField43 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField41' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField41 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField40' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCustomField40 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingConvertedCurr' ) AND name='pStyleCosting')
BEGIN
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingConvertedCurr decimal(18, 4)
END

/****** Style Costing Scenario Items table ******/

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField6' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField6 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField8' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField8 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField10' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField10 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField12' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField12 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField13' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField13 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField14' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField14 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField20' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField20 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField21' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField21 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField36' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField36 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField38' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField38 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField37' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField37 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField39' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField39 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField16' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField16 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField22' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField22 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField42' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField42 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField43' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField43 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField41' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField41 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingCustomField40' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCustomField40 decimal(18, 4)
END

IF EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'StyleCostingConvertedCurr' ) AND name='pStyleCostingScenarioItems')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingConvertedCurr decimal(18, 4)
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04402', GetDate())
GO
