if NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleQuoteItemShare'
    AND  COLUMN_NAME = 'PartnerView')
begin	
	ALTER TABLE pStyleQuoteItemShare ADD PartnerView INT NULL
	ALTER TABLE pStyleQuoteItemShare ADD CONSTRAINT DF_pStyleQuoteItemShare_PartnerView DEFAULT (0) FOR PartnerView	
end
GO

UPDATE pStyleQuoteItemShare SET PartnerView = 0 WHERE PartnerView IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04872', GetDate())
GO