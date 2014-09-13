-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 July 2012                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
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


DECLARE @CurrentCount int
SELECT @CurrentCount = COUNT(WebServiceName)
FROM sWebService
WHERE WebServiceName = 'Hook'

IF @CurrentCount < 1
BEGIN

	-- Hook
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('F79B2C1A-90D1-42BA-9683-7FD4F412BE80', 'Hook', 'WebService_Hook_Default.xml', 1)

		-- Stored Procedure Hook
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('F79B2C1A-90D1-42BA-9683-7FD4F412BE80', '2AF28EC9-F7E6-4307-98F4-663812FD6B28', 'Stored Procedure Hook', 'WebService_Hook_StoredProcedure_Default.xml', 1)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03724', GetDate())
GO

SET NOCOUNT Off
GO
