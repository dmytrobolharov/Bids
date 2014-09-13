-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 06 june 2012                                                                               */
-- * WorkItem #8772                                                                      */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
/****** Object:  View [dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]    Script Date: 06/06/2012 17:11:10 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]'))
DROP VIEW [dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]
GO


/****** Object:  View [dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]    Script Date: 06/06/2012 17:11:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_FlashEdit_StyleCostingHeader_SEL]
AS
SELECT dbo.pStyleHeader.StyleType,dbo.pStyleCostingHeader.StyleID, dbo.pStyleCostingHeader.StyleCostingTypeID, dbo.pStyleCostingHeader.StyleQuotaDutyID, 
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



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03594', GetDate())



GO


