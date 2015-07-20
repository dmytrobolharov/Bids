IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TradePartnerRelationship_SEL]'))
DROP VIEW [dbo].[vwx_TradePartnerRelationship_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[vwx_TradePartnerRelationship_SEL]
AS
SELECT     dbo.uTradePartner.TradePartnerID, dbo.uTradePartner.TradePartnerName, dbo.uTradePartner.TradePartnerCode, dbo.uTradePartner.Country, 
                      dbo.uTradePartnerRelationshipType.TradePartnerRelationshipTypeID, dbo.uTradePartnerRelationshipType.TradePartnerRelationshipTypeName, 
                      dbo.uTradePartnerRelationshipType.TradePartnerRelationshipTypeDesc, dbo.uTradePartnerRelationshipType.TradePartnerAllowRelationship, 
                      dbo.uTradePartnerRelationshipType.TradePartnerLevel
FROM         dbo.uTradePartner INNER JOIN
                      dbo.uTradePartnerRelationshipType ON dbo.uTradePartner.TradePartnerRelationshipType = dbo.uTradePartnerRelationshipType.TradePartnerRelationshipTypeID

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03348'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03348', GetDate())

END

GO