IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerTemp_SELECT]
	@MaterialID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT *, STUFF(
        ISNULL(' &rarr; ' + AgentName, '') +
        ISNULL(' &rarr; ' + VendorName, '') +
        ISNULL(' &rarr; ' + FactoryName, ''), 1, 8, '') AS 'TradePartnerNameChain' 
    FROM tmpMaterialTradePartner tmtp
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON tmtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	WHERE tmtp.MaterialID = @MaterialID	
	ORDER BY CDate
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06075', GetDate())
GO
