IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerSession_SELECT]'))
DROP PROCEDURE spx_TradePartnerSession_SELECT
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerSession_SELECT](@SessionId int,
@ContactId uniqueidentifier)
AS

SELECT dbo.uTradePartner.TradePartnerID, dbo.uTradePartner.TradePartnerCode, dbo.uTradePartner.TradePartnerName, dbo.uTradePartner.Address1, 
  dbo.uTradePartner.Address2, dbo.uTradePartner.City, dbo.uTradePartner.State, dbo.uTradePartner.PostalCode, dbo.uTradePartner.Country, 
  dbo.uTradePartner.Username, dbo.uTradePartner.Password, dbo.uTradePartnerContact.TradePartnerContactID, dbo.uTradePartnerContact.FirstName, 
  dbo.uTradePartnerContact.MiddleName, dbo.uTradePartnerContact.LastName, dbo.uTradePartnerContact.Title, dbo.uTradePartnerContact.Email, 
  dbo.uTradePartnerContact.SESSION, dbo.uTradePartnerContact.SESSIONDATE, dbo.uTradePartnerContact.SESSIONOS, dbo.uTradePartnerContact.IPADDRESS, 
  dbo.uTradePartnerContact.PreferredLang,
  dbo.sSystemServerSetting.SystemServerID, dbo.sSystemServerSetting.FileWebServiceUrl
FROM  dbo.uTradePartner INNER JOIN
  dbo.uTradePartnerContact ON dbo.uTradePartner.TradePartnerID = dbo.uTradePartnerContact.TradePartnerID INNER JOIN
  dbo.sSystemServerSetting ON dbo.uTradePartner.SystemServerID = dbo.sSystemServerSetting.SystemServerID
WHERE     (dbo.uTradePartnerContact.TradePartnerContactID = @ContactId) AND (dbo.uTradePartnerContact.SESSION = @SessionId)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01288', GetDate())
GO