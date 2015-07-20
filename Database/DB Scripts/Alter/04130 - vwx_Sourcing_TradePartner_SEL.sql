/****** Object:  View [dbo].[vwx_Sourcing_TradePartner_SEL]    Script Date: 10/10/2012 12:59:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_TradePartner_SEL]'))
DROP VIEW [dbo].[vwx_Sourcing_TradePartner_SEL]
GO

/****** Object:  View [dbo].[vwx_Sourcing_TradePartner_SEL]    Script Date: 10/10/2012 12:59:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Sourcing_TradePartner_SEL]
AS
SELECT     tp.TradePartnerID, tp.TradePartnerCode, tp.TradePartnerName, tp.Address1, tp.Address2, tp.City, tp.State, tp.PostalCode, tp.Country, tp.PhoneNumber, tp.FaxNumber, 
                      tp.Username, tp.Password, tp.Active, tp.CUser, tp.CDate, tp.MUser, tp.MDate, tp.Comments, tp.CostingTypeID, tp.TradePartnerType, tp.TradePartnerClass, 
                      tp.TradePartnerCommision, tp.TradePartnerLCRequired, tp.IPADDRESS, tp.SESSION, tp.SESSIONDATE, tp.SESSIONOS, tp.SrmOnAccess, tp.ActivationID, tp.Custom1, 
                      tp.SystemServerID, tp.Fabric, tp.Trim, tp.FG, tp.Mill, tp.CurrencyType, tp.Freight, tp.Duty, tp.HKFreight, tp.HKDuty, tp.USFreight, tp.USDuty, 
                      tp.TradePartnerRelationshipType, tp.TradePartnerTemplateID, stp.SourcingTradePartnerID, stp.SourcingHeaderID, stp.TradePartnerID AS Expr1, 
                      stp.TradePartnerLevelID, stp.TradePartnerTypeID, stp.ProductTypes, stp.Active AS Expr2, stp.CUser AS Expr3, stp.CDate AS Expr4, stp.MUser AS Expr5, 
                      stp.MDate AS Expr6, stp.Custom1 AS Expr7, stp.Custom2, stp.Custom3, stp.Custom4, stp.Custom5, r.TradePartnerMasterID
FROM         dbo.pSourcingTradePartner AS stp LEFT OUTER JOIN
                      dbo.uTradePartner AS tp ON stp.TradePartnerID = tp.TradePartnerID LEFT OUTER JOIN
                      dbo.uTradePartnerRelationship AS r ON r.TradePartnerRelationshipID = stp.TradePartnerLevelID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04130', GetDate())
GO