IF not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleQuoteItem' and COLUMN_NAME = N'BOMOptionDefault')
BEGIN 
	ALTER TABLE pStyleQuoteItem add BOMOptionDefault uniqueidentifier
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04455', GetDate())
GO