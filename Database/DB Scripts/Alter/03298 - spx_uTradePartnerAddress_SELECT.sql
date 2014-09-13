IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerAddress_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerAddress_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_uTradePartnerAddress_SELECT](@TradePartnerID uniqueidentifier)
AS 
SELECT a.TradePartnerAddressID, a.TradePartnerID, a.TradePartnerAddressTypeID, a.Address1, a.Address2, a.City, a.State, a.Postal, a.Country, t.TradePartnerAddressName, c.CountryName
FROM uTradePartnerAddress a
	LEFT JOIN uTradePartnerAddressType t ON a.TradePartnerAddressTypeID = t.TradePartnerAddressTypeID
	LEFT JOIN uCountry c ON a.Country = c.CustomID
WHERE TradePartnerID = @TradePartnerID
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03298'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03298', GetDate())

END
GO 