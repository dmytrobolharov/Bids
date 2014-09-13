IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleBOM' AND COLUMN_NAME = 'TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pStyleBOM ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleBOMTemp' AND COLUMN_NAME = 'TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pStyleBOMTemp ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
END
GO

UPDATE pStyleBOM 
SET TradePartnerRelationshipLevelID = 
(
	SELECT TOP 1 TradePartnerRelationshipLevelID 
	FROM pMaterialTradePartner 
	WHERE TradePartnerID = pStyleBOM.TradePartnerID AND MaterialID = pstylebom.MaterialID
	AND SeasonYearID IN (SELECT SeasonYearID FROM pStyleSeasonYear WHERE StyleID = pStyleBOM.StyleID)
)
WHERE pStyleBOM.TradePartnerID IS NOT NULL AND pStyleBOM.TradePartnerID <> '00000000-0000-0000-0000-000000000000'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06642', GetDate())
GO
