IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerAllAddress_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerAllAddress_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerAllAddress_SELECT] 
(   
	@TradePartnerMasterID uniqueidentifier
)
AS

BEGIN

SELECT     uTradePartnerAddress.TradePartnerAddressID, uTradePartnerAddress.TradePartnerID, uTradePartnerAddress.Address1, 
                      uTradePartnerAddress.Address2, uTradePartnerAddress.City, uTradePartnerAddress.State, uTradePartnerAddress.Postal, 
                      uCountry.CountryName, uTradePartner.TradePartnerName, uTradePartnerAddressType.TradePartnerAddressName
FROM         uTradePartnerAddress INNER JOIN
                      uCountry ON uTradePartnerAddress.Country = uCountry.CustomID INNER JOIN
                      uTradePartnerRelationship ON uTradePartnerAddress.TradePartnerID = uTradePartnerRelationship.TradePartnerID INNER JOIN
                      uTradePartner ON uTradePartnerAddress.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
                      uTradePartnerAddressType ON uTradePartnerAddress.TradePartnerAddressTypeID = uTradePartnerAddressType.TradePartnerAddressTypeID
                      
WHERE uTradePartnerRelationship.TradePartnerMasterID = @TradePartnerMasterID
       
END


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03350'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03350', GetDate())

END

GO

