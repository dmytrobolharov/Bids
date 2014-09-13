-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 14 March 2013                                                                              */
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

-- Sample Request Material
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Material')) < 1
BEGIN
       -- Sample Request Material
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '6E44516F-A710-4174-917C-D6658275A3CF', 'Sample Request Material', '', 1)
END
GO

-- Sample Request Comment
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Comment')) < 1
BEGIN
       -- Sample Request Comment
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', 'ACD0CE2B-4BEA-4F0E-B44E-601C1DF6640C', 'Sample Request Comment', '', 1)
END
GO

-- Sample Request Spec Item
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Sample Request Spec Item')) < 1
BEGIN
       -- Sample Request Spec Item
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('EF599F51-55B3-4FB7-BB48-4EABF2E3B1D2', '16C2B8B2-FC9F-444A-B344-9B08EA472AAF', 'Sample Request Spec Item', '', 1)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05300', GetDate())
GO

SET NOCOUNT Off
GO
