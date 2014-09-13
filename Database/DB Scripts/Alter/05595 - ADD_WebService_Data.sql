-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 April 2013                                                                              */
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


-----------------------------
-- Style Image Measurement --
-----------------------------
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Measurement')) < 1
BEGIN
	-- Measurement
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES (NEWID(), 'Measurement', '', 1)
END
GO

-- Style Image Measurement
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Measurement')) >= 1
BEGIN
	DECLARE @WebServiceID uniqueidentifier
	SET @WebServiceID = (SELECT WebServiceID FROM sWebService WHERE UPPER(WebServiceName) = UPPER('Measurement'))

	IF (SELECT COUNT(WebServiceItemName)
		FROM sWebServiceItem
		WHERE UPPER(WebServiceItemName) = UPPER('Style Image Measurement')) < 1
	BEGIN
		-- Style Image Measurement
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES (@WebServiceID, NEWID(), 'Style Image Measurement', '', 1)
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05595', GetDate())
GO

SET NOCOUNT Off
GO
