-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 15 May 2013                                                                                */
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


-----------
-- Style --
-----------
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Style')) < 1
BEGIN
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES (NEWID(), 'Style', '', 1)
END
GO

-- Style
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Style')) >= 1
BEGIN
	DECLARE @WebServiceID uniqueidentifier
	SET @WebServiceID = (SELECT WebServiceID FROM sWebService WHERE UPPER(WebServiceName) = UPPER('Style'))

	-- Style Change
	IF (SELECT COUNT(WebServiceItemName)
		FROM sWebServiceItem
		WHERE UPPER(WebServiceItemName) = UPPER('Style Change')) < 1
	BEGIN
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES (@WebServiceID, NEWID(), 'Style Change', '', 1)
	END

	-- Style Removal
	IF (SELECT COUNT(WebServiceItemName)
		FROM sWebServiceItem
		WHERE UPPER(WebServiceItemName) = UPPER('Style Removal')) < 1
	BEGIN
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES (@WebServiceID, NEWID(), 'Style Removal', '', 1)
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05686', GetDate())
GO

SET NOCOUNT Off
GO
