IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'ShowBOM')
BEGIN 
	ALTER TABLE pStyleCostingType 
	ADD ShowBOM int NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'ShowBOL')
BEGIN 
	ALTER TABLE pStyleCostingType 
	ADD ShowBOL int NULL
END
GO

UPDATE pStyleCostingType SET ShowBOM = 0, ShowBOL = 0
UPDATE pStyleCostingType SET ShowBOM = 1, ShowBOL = 1 WHERE StyleCostingTypeID = 3 --Domestic
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03147'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03147', GetDate())

END
GO