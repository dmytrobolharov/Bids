-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 12 February 2012                                                                           */
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


-- Material Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Material')) < 1
BEGIN

	-- Material
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('60C71021-CBFB-4e2c-A68A-C872F90A6F93', 'Material', 'WebService_Material_Default.xml', 1)

		-- Material Info
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('60C71021-CBFB-4e2c-A68A-C872F90A6F93', '64F4F1A4-C73B-4158-BDD9-366024EB3217', 'Style mBOM Material Info', 'WebService_Material_mBOM_Default.xml', 1)

END
ELSE
BEGIN

	-- Material Info
	UPDATE sWebServiceItem SET WebServiceItemDefaultSchema = 'WebService_Material_mBOM_Default.xml'
	WHERE WebServiceItemID = '64F4F1A4-C73B-4158-BDD9-366024EB3217'

	UPDATE sWebServiceItem SET WebServiceItemName = 'Style mBOM Material Info'
	WHERE WebServiceItemID = '64F4F1A4-C73B-4158-BDD9-366024EB3217'

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03123', GetDate())
GO

SET NOCOUNT Off
GO
