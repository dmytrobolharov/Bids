-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 28 November 2012                                                                           */
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


-- Style Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Style')) < 1
BEGIN

	-- Style
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', 'Style', 'WebService_Style_Default.xml', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Style Type')) < 1
BEGIN

	-- Style Type
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', '1CBB531B-FD97-4A10-92CF-2471AC6EFBC0', 'Style Type', 'StyleType_Default.xml', 1)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04485', GetDate())
GO

SET NOCOUNT Off
GO
