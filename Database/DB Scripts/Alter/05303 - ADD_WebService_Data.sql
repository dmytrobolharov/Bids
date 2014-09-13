-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 15 March 2013                                                                            */
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


-- Text Image Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Text Image')) < 1
BEGIN

	-- Text Image
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('0C3C8B62-28C8-4CE6-94DF-CDBCA6DFBEC0', 'Text Image', '', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Text Image Type')) < 1
BEGIN

	-- Text Image Type
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('0C3C8B62-28C8-4CE6-94DF-CDBCA6DFBEC0', 'A9AA6CA6-E619-4D48-89FE-8FF25B053933', 'Text Image Type', '', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Text Image Data')) < 1
BEGIN

	-- Text Image Data
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('0C3C8B62-28C8-4CE6-94DF-CDBCA6DFBEC0', '1FEB425A-9722-47F2-BBD6-7BC26BF112B3', 'Text Image Data', '', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Text Image Item')) < 1
BEGIN

	-- Text Image Item
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('0C3C8B62-28C8-4CE6-94DF-CDBCA6DFBEC0', '0B1FC51E-2137-4156-87EB-A709AE107AEC', 'Text Image Item', '', 1)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05303', GetDate())
GO

SET NOCOUNT Off
GO
