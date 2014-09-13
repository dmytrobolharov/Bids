-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 10 December 2012                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
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


-- Trade Partner Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Trade Partner')) < 1
BEGIN

	-- Trade Partner
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('BE1720B4-8361-4B1B-AFEA-C13BE58B72EA', 'Trade Partner', 'WebService_Color_Default.xml', 1)

END
GO


-- Trade Partner Template
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Trade Partner Template')) < 1
BEGIN

	-- Trade Partner Template
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('BE1720B4-8361-4B1B-AFEA-C13BE58B72EA', '2A292AC7-F162-491D-9BB3-6DCB2B25B1FC', 'Trade Partner Template', 'Vendor_TemplateFolder_Default.xml', 1)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04591', GetDate())
GO

SET NOCOUNT Off
GO
