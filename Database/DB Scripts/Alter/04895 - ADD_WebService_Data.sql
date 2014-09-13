-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 January 2013                                                                            */
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


-- Image Service
IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Image')) < 1
BEGIN
       -- Image
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('F1A4FA16-718D-4BFD-B3D2-91A726B4A234', 'Image', '', 1)
END
GO


IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Image Type')) < 1
BEGIN

       -- Image Type
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('F1A4FA16-718D-4BFD-B3D2-91A726B4A234', '2650B5D9-2C70-48D1-ADE0-6C22D7C186FA', 'Image Type', '', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Image')) < 1
BEGIN

       -- Process Detail Item
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('F1A4FA16-718D-4BFD-B3D2-91A726B4A234', '76013440-B7D4-4508-99EB-8FEE43D89FBF', 'Image', '', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Image History')) < 1
BEGIN

       -- Process Detail Item
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('F1A4FA16-718D-4BFD-B3D2-91A726B4A234', '56AF5F39-A427-48D5-90EF-2CF09FFEAA1A', 'Image History', '', 1)

END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04895', GetDate())
GO

SET NOCOUNT Off
GO
