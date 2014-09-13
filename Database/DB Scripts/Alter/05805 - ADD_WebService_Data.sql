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

-------------------
-- Trade Partner --
-------------------
IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Trade Partner')) < 1
BEGIN
       -- Trade Partner
       INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-AFEA-C13BE58B72EA', 'Trade Partner', '', 1)
END
GO

-- Trade Partner Contact
IF (SELECT COUNT(WebServiceItemName)
       FROM sWebServiceItem
       WHERE UPPER(WebServiceItemName) = UPPER('Trade Partner Contact')) < 1
BEGIN
       -- Trade Partner Contact
       INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
       VALUES ('BE1720B4-8361-4B1B-AFEA-C13BE58B72EA', 'Trade Partner Contact', '', 1)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05805', GetDate())
GO

SET NOCOUNT Off
GO
