IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_VendorTradePartner_Header_SELECT]'))
DROP VIEW [dbo].[vwx_VendorTradePartner_Header_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create VIEW [dbo].[vwx_VendorTradePartner_Header_SELECT]
AS
SELECT dbo.uTradePartner.TradePartnerID, dbo.uTradePartner.TradePartnerName, dbo.uTradePartner.TradePartnerCode, dbo.uTradePartner.Address1, dbo.uTradePartner.Address2, dbo.uTradePartner.City, 
      dbo.uTradePartner.State, dbo.uTradePartner.PostalCode, dbo.uTradePartner.Country, dbo.uTradePartner.PhoneNumber, dbo.uTradePartner.FaxNumber, 
      dbo.uTradePartner.Username, dbo.uTradePartner.Password, dbo.uTradePartner.Active, dbo.uTradePartner.CUser, dbo.uTradePartner.CDate, dbo.uTradePartner.MUser, 
      dbo.uTradePartner.MDate, dbo.uTradePartner.Comments, dbo.uTradePartner.TradePartnerType, dbo.uTradePartner.TradePartnerClass, 
      dbo.uTradePartner.TradePartnerCommision, dbo.uTradePartner.TradePartnerLCRequired, dbo.uTradePartner.CostingTypeID, dbo.uTradePartner.TradePartnerTemplateID,
      dbo.uTradePartner.TradePartnerRelationshipType, dbo.uTradePartnerRelationshipType.TradePartnerRelationshipTypeName AS TradePartnerTypeName
FROM  dbo.uTradePartner INNER JOIN
      dbo.uTradePartnerRelationshipType ON dbo.uTradePartner.TradePartnerRelationshipType = dbo.uTradePartnerRelationshipType.TradePartnerRelationshipTypeId

go


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03285'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03285', GetDate())

END
GO