/****** Object:  View [dbo].[vwx_Sourcing_TradePartner_REL_SEL]    Script Date: 10/10/2012 12:58:47 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_TradePartner_REL_SEL]'))
DROP VIEW [dbo].[vwx_Sourcing_TradePartner_REL_SEL]
GO

/****** Object:  View [dbo].[vwx_Sourcing_TradePartner_REL_SEL]    Script Date: 10/10/2012 12:58:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_Sourcing_TradePartner_REL_SEL]
AS
SELECT *, NULL as TradePartnerMasterID, NULL as TradePartnerRelationshipID FROM uTradePartner 
WHERE TradePartnerRelationshipType IS NOT NULL
UNION ALL 
SELECT p.*, r.TradePartnerMasterID, r.TradePartnerRelationshipID FROM uTradePartnerRelationship r 
LEFT JOIN uTradePartner p ON p.TradePartnerID = r.TradePartnerID
WHERE TradePartnerRelationshipType IS NOT NULL


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04129', GetDate())
GO