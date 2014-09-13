
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_TradePartner]'))
DROP VIEW [dbo].[vw_TradePartner]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW vw_TradePartner
AS
SELECT     TradePartnerID, TradePartnerCode, TradePartnerName, Address1, Address2, City, State, PostalCode, Country, PhoneNumber, FaxNumber, Username, Password, 
                      Active, CUser, CDate, MUser, MDate, Comments, CostingTypeID, TradePartnerType, TradePartnerClass, TradePartnerCommision, TradePartnerLCRequired, 
                      IPADDRESS, SESSION, SESSIONDATE, SESSIONOS, SrmOnAccess, ActivationID, Custom1, SystemServerID, Fabric, Trim, FG, Mill, CurrencyType, Freight, Duty, 
                      HKFreight, HKDuty, USFreight, USDuty, TradePartnerRelationshipType, TradePartnerTemplateID, Direct, Laboratory, TradePartnerStatusID
FROM         uTradePartner
WHERE     (TradePartnerID NOT IN (SELECT TradePartnerVendorID FROM  uTradePartnerVendor))

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05253', GetDate())
GO
      