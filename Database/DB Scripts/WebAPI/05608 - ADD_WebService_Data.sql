-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 22 April 2013                                                                              */
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


--------------------------
-- Image Catalog --
--------------------------
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Image')) < 1
BEGIN
	-- Image
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES (NEWID(), 'Image', '', 1)
END
GO

-- Image Catalog
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Image')) >= 1
BEGIN
	DECLARE @WebServiceID uniqueidentifier
	SET @WebServiceID = (SELECT WebServiceID FROM sWebService WHERE UPPER(WebServiceName) = UPPER('Image'))

	IF (SELECT COUNT(WebServiceItemName)
		FROM sWebServiceItem
		WHERE UPPER(WebServiceItemName) = UPPER('Image Catalog')) < 1
	BEGIN
		-- Image Catalog
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES (@WebServiceID, NEWID(), 'Image Catalog', '', 1)
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05608', GetDate())
GO

SET NOCOUNT Off
GO
