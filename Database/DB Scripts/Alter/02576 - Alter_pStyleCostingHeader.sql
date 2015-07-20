
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField3' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField3 decimal(18, 4) NULL
END  

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField4' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField4 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField5' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField5 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField6' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField6 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField7' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField7 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField8' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField8 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField9' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField9 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField10' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField10 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField11' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField11 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField12' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField12 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField13' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField13 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField14' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField14 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField15' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField15 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField18' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField18 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField19' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField19 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField20' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField20 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField21' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField21 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField22' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField22 decimal(18, 4) NULL
END 

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField23' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField23 decimal(18, 4) NULL
END

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleCostingCustomField24' AND TABLE_NAME='pStyleCostingHeader')
BEGIN
	ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField24 decimal(18, 4) NULL
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02576'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02576', GetDate())
END
GO