-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 August, 2014                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

UPDATE pStyleType
SET StyleIDSchema = 'Silhouette_ID_Apparel.xml',
StyleDevelopmentIDSchema = 'Silhouette_Development_ID_Apparel.xml',
StyleHeaderSchema = 'Silhouette_Header_Apparel.xml',
StyleSchema = 'Silhouette_Apparel.xml',
StyleSchemaSearch = 'Silhouette_Search_Apparel.xml',
StyleSchemaPrint = 'Silhouette_Print_Apparel.xml',
StyleSchemaCoverPrint = 'Silhouette_Cover_Apparel.xml'
WHERE StyleTypeDescription = 'Apparel Silhouette'

UPDATE pStyleType
SET StyleIDSchema = 'Silhouette_ID_Accessory.xml',
StyleDevelopmentIDSchema = 'Silhouette_Development_ID_Accessory.xml',
StyleHeaderSchema = 'Silhouette_Header_Accessory.xml',
StyleSchema = 'Silhouette_Accessory.xml',
StyleSchemaSearch = 'Silhouette_Search_Accessory.xml',
StyleSchemaPrint = 'Silhouette_Print_Accessory.xml',
StyleSchemaCoverPrint = 'Silhouette_Cover_Accessory.xml'
WHERE StyleTypeDescription = 'Accessory Silhouette'
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08893', GetDate())
GO
