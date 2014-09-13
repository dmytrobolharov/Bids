/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
GO
ALTER TABLE pStyleCostingHeader ALTER COLUMN 
	StyleCostingCustomField1 money
GO
ALTER TABLE pStyleCostingHeader ALTER COLUMN 
	StyleCostingCustomField2 money
GO
COMMIT
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01772'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01772', GetDate())
END
GO