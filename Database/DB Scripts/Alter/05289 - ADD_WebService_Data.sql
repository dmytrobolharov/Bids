-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 12 March 2013                                                                              */
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


--------------
-- Material --
--------------
IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Material')) < 1
BEGIN
       -- Material
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('60C71021-CBFB-4E2C-A68A-C872F90A6F93', 'Material', '', 1)
END
GO

-- Style mBOM Dimension
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Style mBOM Dimension')) < 1
BEGIN
       -- Style mBOM Dimension
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('60C71021-CBFB-4E2C-A68A-C872F90A6F93', '9A50F6A8-909C-48F0-BB90-1BAA0735A906', 'Style mBOM Dimension', '', 1)
END
GO

-- Style mBOM Dimension Item
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Style mBOM Dimension Item')) < 1
BEGIN
       -- Style mBOM Dimension
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('60C71021-CBFB-4E2C-A68A-C872F90A6F93', 'C6F658AE-01F1-4C33-A92E-3223CB4B42AA', 'Style mBOM Dimension Item', '', 1)
END
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

-- Sample Workflow Item Template
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Workflow Item Template')) < 1
BEGIN
       -- Sample Workflow Item Template
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '2EF35B19-5350-466C-B67A-726D7247198B', 'Sample Workflow Item Template', '', 1)
END
GO

-- Sample Request Style Sourcing Temp
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Style Sourcing Temp')) < 1
BEGIN
       -- Sample Request Style Sourcing Temp
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'BE9C3F41-C260-482A-98EF-8A99B9532F08', 'Sample Request Style Sourcing Temp', '', 1)
END
GO

-- Sample Workflow Template
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Workflow Template')) < 1
BEGIN
       -- Sample Workflow Template
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'DAFF958B-A982-44F6-82ED-4EC6ED9F3EB4', 'Sample Workflow Template', '', 1)
END
GO

-- Sample Request Workflow Temp
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Workflow Temp')) < 1
BEGIN
       -- Sample Request Workflow Temp
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '967E0B37-5108-4A72-A946-2E66A65DCD9C', 'Sample Request Workflow Temp', '', 1)
END
GO

-- Sample Request Style Sourcing Item Temp
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Style Sourcing Item Temp')) < 1
BEGIN
       -- Sample Request Style Sourcing Item Temp
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'CF1186A2-FD78-4D3F-A622-51B1E971F522', 'Sample Request Style Sourcing Item Temp', '', 1)
END
GO

-- Sample Request Trade
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Trade')) < 1
BEGIN
       -- Sample Request Trade
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'CD282495-C0D7-4643-96F4-1C92153DC049', 'Sample Request Trade', '', 1)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05289', GetDate())
GO

SET NOCOUNT Off
GO
