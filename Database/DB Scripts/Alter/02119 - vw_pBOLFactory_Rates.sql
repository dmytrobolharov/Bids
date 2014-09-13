/****** Object:  View [dbo].[vw_pBOLFactory_Rates]    Script Date: 10/20/2011 16:23:23 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLFactory_Rates]'))
DROP VIEW [dbo].[vw_pBOLFactory_Rates]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_pBOLFactory_Rates]
AS
SELECT     dbo.pBOLFactoryRates.FactoryRateId, dbo.pBOLFactoryRates.FactoryId, dbo.pBOLFactoryRates.BaseRateId, dbo.pBOLFactoryRates.SeasonYearId, 
                      dbo.pBOLFactoryRates.CurrencyId, dbo.pBOLFactoryRates.RateValue, dbo.pBOLFactoryRates.CUser, dbo.pBOLFactoryRates.CDate, dbo.pBOLFactoryRates.MUser, 
                      dbo.pBOLFactoryRates.MDate, dbo.pBOLFactoryRates.Active AS IsActive, dbo.pBOLFactoryRates.TradePartnerVendorID, dbo.pBOLBaseRateType.RateCode, 
                      dbo.pBOLBaseRateType.RateName, dbo.sCurrencyType.CustomKey AS CurrencyCode
FROM         dbo.pBOLFactoryRates INNER JOIN
                      dbo.pBOLBaseRateType ON dbo.pBOLFactoryRates.BaseRateId = dbo.pBOLBaseRateType.BaseRateTypeId INNER JOIN
                      dbo.sCurrencyType ON dbo.pBOLFactoryRates.CurrencyId = dbo.sCurrencyType.CustomID

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02119'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02119', GetDate())
	END
GO