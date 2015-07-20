IF OBJECT_ID('spx_TradePartnerRelationship_SELECT', 'P') IS NOT NULL
	DROP PROCEDURE spx_TradePartnerRelationship_SELECT
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerRelationship_SELECT]
    (
      @TradePartnerMasterID UNIQUEIDENTIFIER
    )
AS 
BEGIN

    SELECT  uTradePartner.TradePartnerID ,
            uTradePartner.TradePartnerCode ,
            uTradePartner.TradePartnerName ,
            uTradePartner.TradePartnerTemplateID ,
            uTradePartnerRelationship.TradePartnerRelationshipID ,
            uTradePartnerRelationship.TradePartnerMasterID ,
            uTradePartnerRelationshipType.TradePartnerRelationshipTypeID ,
            uTradePartnerRelationshipType.TradePartnerRelationshipTypeName ,
            uTradePartnerRelationshipType.TradePartnerRelationshipTypeDesc ,
            uTradePartnerRelationshipType.TradePartnerAllowRelationship ,
            uCountry.CountryName ,
            uTradePartner.PostalCode
    FROM    uTradePartner
            INNER JOIN uTradePartnerRelationship ON uTradePartner.TradePartnerID = uTradePartnerRelationship.TradePartnerID
            INNER JOIN uTradePartnerRelationshipType ON uTradePartner.TradePartnerRelationshipType = uTradePartnerRelationshipType.TradePartnerRelationshipTypeID
            LEFT OUTER JOIN uCountry ON uTradePartner.Country = uCountry.CountryCode
    WHERE   uTradePartnerRelationship.TradePartnerMasterID = @TradePartnerMasterID
    ORDER BY uTradePartnerRelationshipType.TradePartnerRelationshipTypeName 
       
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09158', GetDate())
GO