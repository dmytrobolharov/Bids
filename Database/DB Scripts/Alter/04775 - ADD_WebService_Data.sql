-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 15 January 2013                                                                            */
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


-- Process Detail Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Process Detail')) < 1
BEGIN

	-- Process Detail
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('B17A1BD8-7FD4-4FDC-9CBB-4AA9CF529ACF', 'Process Detail', 'Style_ConstructionDetails.xml', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Process Detail Type')) < 1
BEGIN

	-- Process Detail Type
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('B17A1BD8-7FD4-4FDC-9CBB-4AA9CF529ACF', '63CB956E-9E81-437F-9ABE-B896092A4A9E', 'Process Detail Type', 'Style_WorkflowItemType_Default.xml', 1)

END
GO


IF (SELECT COUNT(WebServiceItemName)
	FROM sWebServiceItem
	WHERE UPPER(WebServiceItemName) = UPPER('Process Detail Item')) < 1
BEGIN

	-- Process Detail Item
	INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
	VALUES ('B17A1BD8-7FD4-4FDC-9CBB-4AA9CF529ACF', '0B39E08C-208C-4834-9E9E-199CCD77ED95', 'Process Detail Item', 'Style_ConstructionDetails.xml', 1)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04775', GetDate())
GO

SET NOCOUNT Off
GO
