
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='QuickAdd' AND TABLE_NAME='pStyleBOMTemp')
BEGIN
	ALTER TABLE pStyleBOMTemp ADD QuickAdd int NULL DEFAULT 0
END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03092'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03092', GetDate())

END

GO