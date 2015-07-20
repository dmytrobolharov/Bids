ALTER TABLE pStyleBOLPageOperations 
ALTER COLUMN Adj NUMERIC(10,2)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02340'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02340', GetDate())

END
GO