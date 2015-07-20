/****** Object:  View [dbo].[vwx_Control_ExchangeRateItem]    Script Date: 10/11/2011 14:08:48 ******/
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
                      b.CountryName
FROM         dbo.sExchangeRateItem AS a LEFT OUTER JOIN
                      dbo.uCountry AS b ON a.CountryCode = b.CountryCode

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02117'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02117', GetDate())
	END
GO