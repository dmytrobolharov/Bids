/****** Object:  View [dbo].[vwx_Sourcing_TradePartner_REL_SEL]    Script Date: 11/14/2012 14:30:13 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_TradePartner_REL_SEL]'))
DROP VIEW [dbo].[vwx_Sourcing_TradePartner_REL_SEL]
GO

/****** Object:  View [dbo].[vwx_Sourcing_TradePartner_REL_SEL]    Script Date: 11/14/2012 14:30:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Sourcing_TradePartner_REL_SEL]
AS
SELECT     TradePartnerID, TradePartnerCode, TradePartnerName, Address1, Address2, City, State, PostalCode, Country, PhoneNumber, FaxNumber, Username, Password, 
                      Active, CUser, CDate, MUser, MDate, Comments, CostingTypeID, TradePartnerType, TradePartnerClass, TradePartnerCommision, TradePartnerLCRequired, 
                      IPADDRESS, SESSION, SESSIONDATE, SESSIONOS, SrmOnAccess, ActivationID, Custom1, SystemServerID, Fabric, Trim, FG, Mill, CurrencyType, Freight, Duty, 
                      HKFreight, HKDuty, USFreight, USDuty, TradePartnerRelationshipType, TradePartnerTemplateID, Direct, NULL AS TradePartnerMasterID, NULL 
                      AS TradePartnerRelationshipID
FROM         uTradePartner
WHERE     TradePartnerRelationshipType IS NOT NULL
UNION ALL
SELECT     p.TradePartnerID, p.TradePartnerCode, p.TradePartnerName, p.Address1, p.Address2, p.City, p.State, p.PostalCode, p.Country, p.PhoneNumber, p.FaxNumber, 
                      p.Username, p.Password, p.Active, p.CUser, p.CDate, p.MUser, p.MDate, p.Comments, p.CostingTypeID, p.TradePartnerType, p.TradePartnerClass, 
                      p.TradePartnerCommision, p.TradePartnerLCRequired, p.IPADDRESS, p.SESSION, p.SESSIONDATE, p.SESSIONOS, p.SrmOnAccess, p.ActivationID, p.Custom1, 
                      p.SystemServerID, p.Fabric, p.Trim, p.FG, p.Mill, p.CurrencyType, p.Freight, p.Duty, p.HKFreight, p.HKDuty, p.USFreight, p.USDuty, p.TradePartnerRelationshipType, 
                      p.TradePartnerTemplateID, p.Direct, r.TradePartnerMasterID, r.TradePartnerRelationshipID
FROM         uTradePartnerRelationship r LEFT JOIN
                      uTradePartner p ON p.TradePartnerID = r.TradePartnerID
WHERE     TradePartnerRelationshipType IS NOT NULL

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04342', GetDate())
GO