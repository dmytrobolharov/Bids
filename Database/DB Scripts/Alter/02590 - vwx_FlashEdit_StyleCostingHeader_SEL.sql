
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]
GO


/****** Object:  View [dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]    Script Date: 01/12/2012 18:01:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]
AS
SELECT dbo.pStyleCostingHeader.StyleID, dbo.pStyleCostingHeader.StyleCostingTypeID, dbo.pStyleCostingHeader.StyleQuotaDutyID, 
                      dbo.pStyleCostingHeader.StyleCostingDate, dbo.pStyleCostingHeader.StyleCostingStatus, dbo.pStyleCostingHeader.StyleCostingCustomField1, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField2, dbo.pStyleCostingHeader.StyleCostingCustomField3, dbo.pStyleCostingHeader.StyleCostingCustomField4, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField5, dbo.pStyleCostingHeader.StyleCostingCustomField6, dbo.pStyleCostingHeader.StyleCostingCustomField7, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField8, dbo.pStyleCostingHeader.StyleCostingCustomField9, dbo.pStyleCostingHeader.StyleCostingCustomField10, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField11, dbo.pStyleCostingHeader.StyleCostingCustomField12, dbo.pStyleCostingHeader.StyleCostingCustomField13, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField14, dbo.pStyleCostingHeader.StyleCostingCustomField15, dbo.pStyleCostingHeader.StyleCostingCustomField16, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField17, dbo.pStyleCostingHeader.StyleCostingCustomField18, dbo.pStyleCostingHeader.StyleCostingCustomField19, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField20, dbo.pStyleCostingHeader.StyleCostingCustomField21, dbo.pStyleCostingHeader.StyleCostingCustomField22, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField23, dbo.pStyleCostingHeader.StyleCostingCustomField24, dbo.pStyleCostingHeader.StyleCostingCustomField25, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField26, dbo.pStyleCostingHeader.StyleCostingCustomField27, dbo.pStyleCostingHeader.StyleCostingCustomField28, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField29, dbo.pStyleCostingHeader.StyleCostingCustomField30, dbo.pStyleCostingHeader.CUser, 
                      dbo.pStyleCostingHeader.CDate, dbo.pStyleCostingHeader.MUser, dbo.pStyleCostingHeader.MDate, dbo.pStyleCostingHeader.Active, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField31, dbo.pStyleCostingHeader.StyleCostingCustomField32, dbo.pStyleCostingHeader.StyleCostingCustomField33, 
                      dbo.pStyleCostingHeader.StyleCostingCustomField34, dbo.pStyleCostingHeader.StyleCostingCustomField35, dbo.pStyleCostingHeader.StyleCostingHeaderID, 
                      dbo.pStyleCostingHeader.StyleSeasonYearID, dbo.pStyleCostingHeader.UnitsPlan, dbo.pStyleCostingHeader.UnitsActual, dbo.pStyleHeader.StyleNo, 
                      dbo.pStyleHeader.Description, dbo.pStyleSeasonYear.StyleSeason, dbo.pStyleSeasonYear.StyleYear
FROM         dbo.pStyleCostingHeader INNER JOIN
                      dbo.pStyleHeader ON dbo.pStyleCostingHeader.StyleID = dbo.pStyleHeader.StyleID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pStyleCostingHeader.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02590'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02590', GetDate())

END
GO