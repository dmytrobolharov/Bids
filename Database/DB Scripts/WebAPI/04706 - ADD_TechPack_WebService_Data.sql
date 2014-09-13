-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 01 January 2013                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
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

IF (NOT EXISTS(SELECT WebServiceName FROM sWebService WHERE WebServiceName = 'Tech Pack'))
BEGIN

	-- Tech Pack
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('44289C90-67AC-486D-818D-4E11AC4B5227', 'Tech Pack', '', 1)

		-- Style Tech Pack
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('44289C90-67AC-486D-818D-4E11AC4B5227', '4FF3FB92-482E-4534-AFE7-5AB6C11FBD10', 'Style Tech Pack', '', 1)

		-- Batch Style Tech Pack
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('44289C90-67AC-486D-818D-4E11AC4B5227', 'DDEE2BD8-30A2-4621-9929-B20E5C6E7945', 'Batch Style Tech Pack', '', 1)

		-- Sample Tech Pack
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('44289C90-67AC-486D-818D-4E11AC4B5227', 'AD24CBA4-E10F-4426-8DE7-9DF7DFFD3BC4', 'Sample Tech Pack', '', 1)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04706', GetDate())
GO

SET NOCOUNT Off
GO
