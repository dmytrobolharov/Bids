IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Control_ExchangeRateItem]'))
DROP VIEW [dbo].[vwx_Control_ExchangeRateItem]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Control_ExchangeRateItem]
AS
SELECT     a.ExchangeRateItemID, a.ExchangeRateID, a.CountryCode, a.Rate, a.CurrencyType, a.CUser, a.CDate, a.MUser, a.MDate, a.Sort, a.BaseCurrency, 
                      dbo.sCurrencyType.CountryName, dbo.sCurrencyType.Custom AS Currency, dbo.sCurrencyType.CustomID, dbo.sCurrencyType.CustomKey AS Code
FROM         dbo.sExchangeRateItem AS a LEFT JOIN
                      dbo.sCurrencyType ON a.CurrencyType = dbo.sCurrencyType.CustomKey

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04711', GetDate())
GO
