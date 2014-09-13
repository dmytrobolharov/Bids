-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 06 March 2013                                                                              */
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
-- Colorway --
--------------
IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Colorway')) < 1
BEGIN
       -- Colorway
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('50A1F4D9-CDA1-4048-A9E0-AFDA75E677F3', 'Colorway', '', 1)
END
GO

-- Colorway
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Colorway')) < 1
BEGIN
       -- Colorway
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('50A1F4D9-CDA1-4048-A9E0-AFDA75E677F3', 'B2237C07-5B4E-4718-8B21-3A30DA7A9094', 'Colorway', '', 1)
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

-- Sample Request Group Temp
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Group Temp')) < 1
BEGIN
       -- Sample Request Group Temp
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'A1B73D7D-C06D-4BC3-9ED7-9E7299607319', 'Sample Request Group Temp', '', 1)
END
GO

-- Sample Request Style Temp
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Style Temp')) < 1
BEGIN
       -- Sample Request Style Temp
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'BF742AF6-8410-43BF-BA4F-5AA04E5EE78C', 'Sample Request Style Temp', '', 1)
END
GO

-- Sample Request Style Colorway Temp
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Style Colorway Temp')) < 1
BEGIN
       -- Sample Request Style Colorway Temp
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '5A3E0CBF-0CC6-44EC-BF5B-47AD1F2D665B', 'Sample Request Style Colorway Temp', '', 1)
END
GO

-- Sample Request Set Item Temp
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Set Item Temp')) < 1
BEGIN
       -- Sample Request Set Item Temp
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'C381A42B-0D41-477D-9AED-F251EB3134CE', 'Sample Request Set Item Temp', '', 1)
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

-- Style Set
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Style Set')) < 1
BEGIN
       -- Style Set
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', '7E4D7815-C7DF-427C-8836-FA386E31DD1E', 'Style Set', '', 1)
END
GO


---------------
-- Tech Pack --
---------------
IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Tech Pack')) < 1
BEGIN
       -- Tech Pack
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('44289C90-67AC-486D-818D-4E11AC4B5227', 'Tech Pack', '', 1)
END
GO

-- Tech Pack
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Tech Pack')) < 1
BEGIN
       -- Tech Pack
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('44289C90-67AC-486D-818D-4E11AC4B5227', '60291B85-3898-4CD3-8083-21303FDCBBA5', 'Tech Pack', '', 1)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05266', GetDate())
GO

SET NOCOUNT Off
GO
