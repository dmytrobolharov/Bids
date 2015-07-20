-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 August, 2014                                                                            */
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
SET StyleIDSchema = 'Style_ID_Apparel.xml',
StyleDevelopmentIDSchema = 'Style_Development_ID_Apparel.xml',
StyleHeaderSchema = 'Style_Header_Apparel.xml',
StyleSchema = 'Style_Apparel.xml',
StyleSchemaSearch = 'Style_Search_Apparel.xml',
StyleSchemaPrint = 'Style_Print_Apparel.xml',
StyleSchemaCoverPrint = 'Style_Cover_Apparel.xml'
WHERE StyleTypeDescription = 'Apparel'

UPDATE pStyleType
SET StyleIDSchema = 'Style_ID_Footwear.xml',
StyleDevelopmentIDSchema = 'Style_Development_ID_Footwear.xml',
StyleHeaderSchema = 'Style_Header_Footwear.xml',
StyleSchema = 'Style_Footwear.xml',
StyleSchemaSearch = 'Style_Search_Footwear.xml',
StyleSchemaPrint = 'Style_Print_Footwear.xml',
StyleSchemaCoverPrint = 'Style_Cover_Footwear.xml'
WHERE StyleTypeDescription = 'Footwear'

UPDATE pStyleType
SET StyleIDSchema = 'Style_ID_Accessory.xml',
StyleDevelopmentIDSchema = 'Style_Development_ID_Accessory.xml',
StyleHeaderSchema = 'Style_Header_Accessory.xml',
StyleSchema = 'Style_Accessory.xml',
StyleSchemaSearch = 'Style_Search_Accessory.xml',
StyleSchemaPrint = 'Style_Print_Accessory.xml',
StyleSchemaCoverPrint = 'Style_Cover_Accessory.xml'
WHERE StyleTypeDescription = 'Accessory'

UPDATE pStyleType
SET StyleIDSchema = 'Style_ID_ApparelSilhouette.xml',
StyleDevelopmentIDSchema = 'Style_Development_ID_ApparelSilhouette.xml',
StyleHeaderSchema = 'Style_Header_ApparelSilhouette.xml',
StyleSchema = 'Style_ApparelSilhouette.xml',
StyleSchemaSearch = 'Style_Search_ApparelSilhouette.xml',
StyleSchemaPrint = 'Style_Print_ApparelSilhouette.xml',
StyleSchemaCoverPrint = 'Style_Cover_ApparelSilhouette.xml'
WHERE StyleTypeDescription = 'Apparel Silhouette'

UPDATE pStyleType
SET StyleIDSchema = 'Style_ID_AccessorySilhouette.xml',
StyleDevelopmentIDSchema = 'Style_Development_ID_AccessorySilhouette.xml',
StyleHeaderSchema = 'Style_Header_AccessorySilhouette.xml',
StyleSchema = 'Style_AccessorySilhouette.xml',
StyleSchemaSearch = 'Style_Search_AccessorySilhouette.xml',
StyleSchemaPrint = 'Style_Print_AccessorySilhouette.xml',
StyleSchemaCoverPrint = 'Style_Cover_AccessorySilhouette.xml'
WHERE StyleTypeDescription = 'Accessory Silhouette'
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08892', GetDate())
GO
