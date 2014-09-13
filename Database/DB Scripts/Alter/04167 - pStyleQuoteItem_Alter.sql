
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleQuoteItem' and COLUMN_NAME = N'SourcingHeaderID')
       BEGIN 
            ALTER TABLE pStyleQuoteItem ADD SourcingHeaderID uniqueidentifier NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04167', GetDate())
GO