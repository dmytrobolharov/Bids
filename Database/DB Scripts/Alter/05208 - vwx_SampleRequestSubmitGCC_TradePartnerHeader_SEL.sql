/****** Object:  View [dbo].[vwx_SampleRequestSubmitGCC_TradePartnerHeader_SEL]    Script Date: 03/01/2013 13:34:11 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitGCC_TradePartnerHeader_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestSubmitGCC_TradePartnerHeader_SEL]
GO

/****** Object:  View [dbo].[vwx_SampleRequestSubmitGCC_TradePartnerHeader_SEL]    Script Date: 03/01/2013 13:34:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SampleRequestSubmitGCC_TradePartnerHeader_SEL]
AS
SELECT     a.SampleRequestSubmitVendorID AS SampleRequestSubmitGroupID, b.TradePartnerID, b.Address2, b.City, b.State, b.PostalCode, b.Country, b.PhoneNumber, 
                      b.FaxNumber, b.Username, b.Password, b.Active, b.CUser, b.CDate, b.MUser, b.MDate, b.Comments, b.Freight, b.Duty, b.Fabric, b.Trim, b.FG, b.Mill, b.CurrencyType, 
                      b.HKFreight, b.HKDuty, b.USFreight, b.USDuty, b.Laboratory, b.TradePartnerCode, b.Address1, b.TradePartnerName, b.TradePartnerType, b.TradePartnerClass, 
                      b.TradePartnerRelationshipType, b.TradePartnerStatusID
FROM         dbo.pSampleRequestSubmitVendor AS a INNER JOIN
                      dbo.uTradePartner AS b ON a.TradePartnerVendorID = b.TradePartnerID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05208', GetDate())
GO
