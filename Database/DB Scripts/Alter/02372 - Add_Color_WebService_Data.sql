-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 13 December 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


DECLARE @CurrentCount int
SELECT @CurrentCount = COUNT(WebServiceName)
FROM sWebService
WHERE WebServiceName = 'Color'

IF @CurrentCount < 1
BEGIN

	-- Color
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('1EDC9B2E-A630-48ba-8997-CF858858DC60', 'Color', 'WebService_Color_Default.xml', 1)

		-- Color Palette
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('1EDC9B2E-A630-48ba-8997-CF858858DC60', '099038D4-F732-4fce-9496-476DCA50F1CE', 'Color Palette', 'WebService_Color_ColorPalette_Default.xml', 1)

		-- Color Palette Item
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('1EDC9B2E-A630-48ba-8997-CF858858DC60', 'BE6C8D2B-8182-41b1-B518-45D5B6DDFD17', 'Color Palette Item', 'WebService_Color_ColorPaletteItem_Default.xml', 1)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02372', GetDate())
GO

SET NOCOUNT Off
GO
