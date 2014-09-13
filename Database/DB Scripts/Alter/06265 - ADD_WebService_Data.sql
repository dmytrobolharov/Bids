-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 03 September 2013                                                                          */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
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

---------------
-- Line List --
---------------
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Line List')) < 1
BEGIN
	-- Line List
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E77B', 'Line List', 'WebService_LineList_Default.xml', 1)
END
GO


-- Line List Quick Fill Item
IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Line List Quick Fill Item')) < 1
BEGIN
	-- Style BOM Dimension
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E77B', '5EDF7EC5-E28F-4CD5-83AF-7FB36F650258', 'Line List Quick Fill Item', '', 1)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06265', GetDate())
GO

SET NOCOUNT OFF
GO
