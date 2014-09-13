-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 13 March 2013                                                                              */
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


------------
-- Sample --
------------
IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Sample')) < 1
BEGIN
       -- Sample
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'Sample', '', 1)
END
GO

-- Sample Request Style
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Style')) < 1
BEGIN
       -- Sample Request Style
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '8B3B78C1-34C1-4A49-8437-2568995660AE', 'Sample Request Style', '', 1)
END
GO

-- Sample Request Trade Partner
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Trade Partner')) < 1
BEGIN
       -- Sample Request Trade Partner
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '3FB99C47-3D7E-408A-8895-11DF58304BA2', 'Sample Request Trade Partner', '', 1)
END
GO

-- Sample Request Trade Partner Vendor
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Trade Partner Vendor')) < 1
BEGIN
       -- Sample Request Trade Partner Vendor
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'B9CAC5B7-064D-4178-AF24-CB1FC10026BE', 'Sample Request Trade Partner Vendor', '', 1)
END
GO

-- Sample Request Submit
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Submit')) < 1
BEGIN
       -- Sample Request Submit
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '6D5AF4A0-C010-4441-AD27-F8501CE29633', 'Sample Request Submit', '', 1)
END
GO


-----------
-- Style --
-----------
IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Style')) < 1
BEGIN
       -- Style
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', 'Style', '', 1)
END
GO

-- Style Development Item
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Style Development Item')) < 1
BEGIN
       -- Style Development Item
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', 'FD75A69A-9D12-45B3-80AF-B4D825B21C81', 'Style Development Item', '', 1)
END
GO

-- Style Document
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Style Document')) < 1
BEGIN
       -- Style Document
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', '5257D15A-69E1-45C1-9E86-9430F9A861EB', 'Style Document', '', 1)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05292', GetDate())
GO

SET NOCOUNT Off
GO
