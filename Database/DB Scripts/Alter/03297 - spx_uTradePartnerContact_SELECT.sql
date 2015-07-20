IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerContact_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerContact_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_uTradePartnerContact_SELECT](@TradePartnerID uniqueidentifier)
AS 
SELECT TradePartnerContactID, TradePartnerID, FirstName, MiddleName, LastName, Title, PhoneNumber, MobileNumber, Email, CUser, CDate, MUser, MDate, FirstName + ' ' + LastName AS FULLNAME, PreferredLang
FROM uTradepartnerContact WHERE TradePartnerID = @TradePartnerID
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03297'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03297', GetDate())

END
GO 