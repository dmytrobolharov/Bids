IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pStyleQuote]'))
DROP VIEW [dbo].[vwx_pStyleQuote]
GO


CREATE VIEW [dbo].[vwx_pStyleQuote]
AS
SELECT     dbo.pStyleQuote.StyleQuoteID, dbo.pStyleQuote.StyleDevelopmentID, dbo.pStyleQuote.StyleQuoteNo, dbo.pStyleQuote.StyleQuoteType, 
                      dbo.pStyleQuote.StyleQuoteStartDate, dbo.pStyleQuote.StyleQuoteDueDate, dbo.pStyleQuote.StyleQuoteStatus, dbo.pStyleQuote.StyleQuoteField1, 
                      dbo.pStyleQuote.StyleQuoteField2, dbo.pStyleQuote.StyleQuoteField3, dbo.pStyleQuote.StyleQuoteField4, dbo.pStyleQuote.StyleQuoteField5, 
                      dbo.pStyleQuote.StyleQuoteField6, dbo.pStyleQuote.StyleQuoteField7, dbo.pStyleQuote.StyleQuoteField8, dbo.pStyleQuote.StyleQuoteField9, 
                      dbo.pStyleQuote.StyleQuoteField10, dbo.pStyleQuote.CUser, dbo.pStyleQuote.CDate, dbo.pStyleQuote.MUser, dbo.pStyleQuote.MDate, dbo.uTradePartner.TradePartnerID, 
                      dbo.pStyleCostingDuty.DutyCategory AS StyleQuotaDutyID
FROM         dbo.pStyleQuote INNER JOIN
                      dbo.uTradePartner ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
                      dbo.pStyleCostingDuty ON dbo.pStyleCostingDuty.CustomID = dbo.pStyleQuote.StyleQuotaDutyID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09291', GetDate())
GO

