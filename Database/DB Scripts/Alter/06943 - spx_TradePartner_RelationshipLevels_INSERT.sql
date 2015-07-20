IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartner_RelationshipLevels_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartner_RelationshipLevels_INSERT]
GO

-- Generates relationship levels for all trade partner that does'n have one
CREATE PROCEDURE [dbo].[spx_TradePartner_RelationshipLevels_INSERT]	
AS
BEGIN
	
	DECLARE @TPRL TABLE(ROWID INT IDENTITY(1, 1), TradePArtnerIDChain nVARCHAR(MAX))
	INSERT INTO @TPRL(TradePArtnerIDChain)
	SELECT TradePartnerIDChain FROM vwx_TradePartnerMgmt_SEL WHERE RelationshipLevelID IS NULL
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @TPRL)
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @TradePartnerIDChain nVARCHAR(MAX)
		SELECT @TradePartnerIDChain = TradePartnerIDChain FROM @TPRL WHERE ROWID = @ROW
		
		EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain
		
		SET @ROW = @ROW + 1
	END
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06943', GetDate())
GO
