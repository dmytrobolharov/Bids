--IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleQuoteItemVersion' and COLUMN_NAME = N'StyleQuoteItemCustomField7' and data_type = 'uniqueidentifier')
--       BEGIN 
--			Update pStyleQuoteItemVersion set StyleQuoteItemCustomField7 = null where StyleQuoteItemCustomField7 is not null
--			
--            ALTER TABLE pStyleQuoteItemVersion ALTER COLUMN StyleQuoteItemCustomField7 decimal(18, 5) NULL
--       END
--GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03096'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03096', GetDate())

END
GO