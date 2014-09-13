IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerRelationship_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerRelationship_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerRelationship_SELECT] 
(   
	@TradePartnerMasterID uniqueidentifier
)
AS

BEGIN

SELECT     uTradePartner.TradePartnerID, uTradePartner.TradePartnerCode, uTradePartner.TradePartnerName, uTradePartner.TradePartnerTemplateID,
                      uTradePartnerRelationship.TradePartnerRelationshipID, uTradePartnerRelationship.TradePartnerMasterID, 
                      uTradePartnerRelationshipType.TradePartnerRelationshipTypeID, uTradePartnerRelationshipType.TradePartnerRelationshipTypeName, 
                      uTradePartnerRelationshipType.TradePartnerRelationshipTypeDesc, uTradePartnerRelationshipType.TradePartnerAllowRelationship, 
                      uCountry.CountryName, uTradePartner.PostalCode
FROM         uTradePartner INNER JOIN
                      uTradePartnerRelationship ON uTradePartner.TradePartnerID = uTradePartnerRelationship.TradePartnerID INNER JOIN
                      uTradePartnerRelationshipType ON 
                      uTradePartner.TradePartnerRelationshipType = uTradePartnerRelationshipType.TradePartnerRelationshipTypeID INNER JOIN
                      uCountry ON uTradePartner.Country = uCountry.CountryCode
                      
WHERE  uTradePartnerRelationship.TradePartnerMasterID = @TradePartnerMasterID order by uTradePartnerRelationshipType.TradePartnerRelationshipTypeName 
       
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03356'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03356', GetDate())

END

GO


