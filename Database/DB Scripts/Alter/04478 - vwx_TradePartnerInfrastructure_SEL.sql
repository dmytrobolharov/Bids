/****** Object:  View [dbo].[vwx_TradePartnerInfrastructure_SEL]    Script Date: 11/28/2012 13:42:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TradePartnerInfrastructure_SEL]'))
DROP VIEW [dbo].[vwx_TradePartnerInfrastructure_SEL]
GO

/****** Object:  View [dbo].[vwx_TradePartnerInfrastructure_SEL]    Script Date: 11/28/2012 13:42:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_TradePartnerInfrastructure_SEL]
AS
SELECT     dbo.uTradePartnerInfrastructure.TradePartnerInfrastructureID, dbo.uTradePartnerInfrastructure.TradePartnerID, dbo.uTradePartnerInfrastructure.FacilityName, 
                      dbo.uTradePartnerInfrastructure.FacilityDescription, dbo.uTradePartnerInfrastructure.FacilityType, dbo.uTradePartnerInfrastructure.FacilityLocation, 
                      dbo.uTradePartnerInfrastructure.FacilityArea, dbo.uTradePartnerInfrastructure.TotalEmployees, dbo.uTradePartnerInfrastructure.CustomField1, 
                      dbo.uTradePartnerInfrastructure.CustomField2, dbo.uTradePartnerInfrastructure.CustomField3, dbo.uTradePartnerInfrastructure.CustomField4, 
                      dbo.uTradePartnerInfrastructure.CustomField5, dbo.uTradePartnerInfrastructure.CustomField6, dbo.uTradePartnerInfrastructure.CustomField7, 
                      dbo.uTradePartnerInfrastructure.CustomField8, dbo.uTradePartnerInfrastructure.Active, dbo.uTradePartnerInfrastructure.Sort, dbo.uTradePartnerInfrastructure.CUser, 
                      dbo.uTradePartnerInfrastructure.CDate, dbo.uTradePartnerInfrastructure.MUser, dbo.uTradePartnerInfrastructure.MDate, 
                      dbo.uTradePartnerInfrastructureType.InfrastructureTypeID, dbo.uTradePartnerInfrastructureType.InfrastructureTypeName, 
                      dbo.uTradePartnerInfrastructureType.InfrastructureTypeSchema, dbo.uTradePartnerInfrastructure.TradePartnerInfrastructureTypeID, dbo.uTradePartnerInfrastructure.CustomField9, dbo.uTradePartnerInfrastructure.CustomField10, 
                      dbo.uTradePartnerInfrastructure.CustomField11, dbo.uTradePartnerInfrastructure.CustomField12, dbo.uTradePartnerInfrastructure.CustomField13, 
                      dbo.uTradePartnerInfrastructure.CustomField14, dbo.uTradePartnerInfrastructure.CustomField15, dbo.uTradePartnerInfrastructure.CustomField16, 
                      dbo.uTradePartnerInfrastructure.CustomField17, dbo.uTradePartnerInfrastructure.CustomField18, dbo.uTradePartnerInfrastructure.CustomField19, 
                      dbo.uTradePartnerInfrastructure.CustomField20
FROM         dbo.uTradePartnerInfrastructure LEFT JOIN
                      dbo.uTradePartnerInfrastructureType ON dbo.uTradePartnerInfrastructure.TradePartnerInfrastructureTypeID = dbo.uTradePartnerInfrastructureType.InfrastructureTypeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04478', GetDate())
GO