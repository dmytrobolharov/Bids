-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 February 2012                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
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


-- Seam Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Seam')) < 1
BEGIN

	-- Seam
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('001A5128-B75E-4a3a-A49E-793F10E55584', 'Seam', 'WebService_Seam_Default.xml', 1)

		-- Seam Data
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('001A5128-B75E-4a3a-A49E-793F10E55584', 'EA032FF5-91F3-4d18-B1A5-843D4C1C999D', 'Seam Data', 'WebService_Seam_SeamData_Default.xml', 1)

END
ELSE
BEGIN

	-- Seam Data
	UPDATE sWebServiceItem SET WebServiceItemDefaultSchema = 'WebService_Seam_SeamData_Default.xml'
	WHERE WebServiceItemID = 'EA032FF5-91F3-4d18-B1A5-843D4C1C999D'

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03154', GetDate())
GO

SET NOCOUNT Off
GO
