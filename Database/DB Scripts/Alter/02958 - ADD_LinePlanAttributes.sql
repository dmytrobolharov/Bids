-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 January 2012                                                                            */
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

IF (SELECT COUNT(*) FROM pLinePlanAttributeType WHERE LinePlanAttributeTypeID = '1') = 0
BEGIN

	/* Creates entry in pLinePlanAttributeType table. This allows you to select this attribute type within 
	the line plan attribute folder. You can create additional line plan attribute types and assign different
	schema for each if needed.
	*/
	INSERT INTO pLinePlanAttributeType (LinePlanAttributeTypeID, LinePlanAttributeType, SearchSchema, DefaultSchema)
	VALUES ('1', 'Theme', 'LinePlan_StyleAttributeGroup_Search.xml', 'LinePlan_StyleAttributeGroup_Default')

	/*Creates entries in pLinePlanStyleAttributeType1 table. This allows you select these entries based
	on the previous script that was run.
	*/
	INSERT INTO pLinePlanStyleAttributeType1 (AttributeID, AttributeName, LinePlanAttributeTypeID)
	VALUES ('10000000-0000-0000-0000-000000000001', 'Military', '1')

	INSERT INTO pLinePlanStyleAttributeType1 (AttributeID, AttributeName, LinePlanAttributeTypeID)
	VALUES ('10000000-0000-0000-0000-000000000002', 'Casual', '1')

	INSERT INTO pLinePlanStyleAttributeType1 (AttributeID, AttributeName, LinePlanAttributeTypeID)
	VALUES ('10000000-0000-0000-0000-000000000003', 'Corporate', '1')

	INSERT INTO pLinePlanStyleAttributeType1 (AttributeID, AttributeName, LinePlanAttributeTypeID)
	VALUES ('10000000-0000-0000-0000-000000000004', 'Lifestyle', '1')

	INSERT INTO pLinePlanStyleAttributeType1 (AttributeID, AttributeName, LinePlanAttributeTypeID)
	VALUES ('10000000-0000-0000-0000-000000000005', 'Seasonal', '1')

END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '02958', GetDate())
GO

SET NOCOUNT Off
GO
