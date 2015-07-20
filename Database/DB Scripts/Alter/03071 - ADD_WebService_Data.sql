-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 January 2012                                                                            */
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
		VALUES ('60C71021-CBFB-4e2c-A68A-C872F90A6F93', '64F4F1A4-C73B-4158-BDD9-366024EB3217', 'Material Info', NULL, 1)

END


-- Measurement Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Measurement')) < 1
BEGIN

	-- Measurement
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('7D2C929F-FAF9-46b7-BA5B-5741B19F276A', 'Measurement', 'WebService_Measurement_Default.xml', 1)

		-- Graded Spec
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('7D2C929F-FAF9-46b7-BA5B-5741B19F276A', 'F917587D-C2FB-44ad-B1DF-6F02F5987610', 'Graded Spec', 'WebService_Measurement_GradedSpec_Default.xml', 1)

		-- Grade Rules
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('7D2C929F-FAF9-46b7-BA5B-5741B19F276A', '7C4F4049-796F-47a7-B1BE-743134A47867', 'Grade Rules', 'WebService_Measurement_GradeRules_Default.xml', 1)

END


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
		VALUES ('001A5128-B75E-4a3a-A49E-793F10E55584', 'EA032FF5-91F3-4d18-B1A5-843D4C1C999D', 'Seam Data', NULL, 1)

END


-- Style Service
IF (SELECT COUNT(WebServiceName)
	FROM sWebService
	WHERE UPPER(WebServiceName) = UPPER('Style')) < 1
BEGIN

	-- Style
	INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
	VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', 'Style', 'WebService_Style_Default.xml', 1)

		-- Style Header
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', '00CCB915-7633-43a8-8707-575B32154B94', 'Style Header', 'WebService_Style_StyleHeader_Default.xml', 1)

		-- Style Page
		INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
		VALUES ('56BDAD9B-B6AF-4380-94D7-70588FD8E66A', '59CE59B5-E2B5-4a95-8F16-8A6B5B47C375', 'Style Page', 'WebService_Style_StylePages_Default.xml', 1)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03071', GetDate())
GO

SET NOCOUNT Off
GO
