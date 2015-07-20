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

UPDATE pColorType 
SET ColorFolderSearchSchema = 'Color_Folder_Search_Trim.xml', 
ColorFolderSchema = 'Color_Folder_Trim.xml', 
ColorFolderHeaderSchema = 'Color_Folder_Header_Trim.xml', 
ColorFolderPrintSchema = 'Color_Folder_Print_Trim.xml',
ColorPaletteSchema = 'Color_Palette_Edit_Trim.xml',
ColorPaletteItemSchema = 'Color_PaletteItem_Trim.xml',
ColorPaletteSearchSchema = 'Color_Palette_Search_Trim.xml',
ColorPaletteImageSchema = 'Color_Palette_Image_Edit_Trim.xml',
ColorPaletteGridSearchSchema = 'Color_Palette_GridSearch_Trim.xml'
WHERE ColorTypeDescription = 'Trim'

UPDATE pColorType 
SET ColorFolderSearchSchema = 'Color_Folder_Search_CompanyLibrary.xml', 
--ColorFolderSchema = 'Color_Folder_CompanyLibrary.xml', 
ColorFolderHeaderSchema = 'Color_Folder_Header_CompanyLibrary.xml', 
ColorFolderPrintSchema = 'Color_Folder_Print_CompanyLibrary.xml',
ColorPaletteSchema = 'Color_Palette_Edit_CompanyLibrary.xml',
ColorPaletteItemSchema = 'Color_PaletteItem_CompanyLibrary.xml',
ColorPaletteSearchSchema = 'Color_Palette_Search_CompanyLibrary.xml',
ColorPaletteImageSchema = 'Color_Palette_Image_Edit_CompanyLibrary.xml',
ColorPaletteGridSearchSchema = 'Color_Palette_GridSearch_CompanyLibrary.xml'
WHERE ColorTypeDescription = 'Company Library'

UPDATE pColorType 
SET ColorFolderSearchSchema = 'Color_Folder_Search_Seasonal.xml', 
ColorFolderSchema = 'Color_Folder_Seasonal.xml', 
ColorFolderHeaderSchema = 'Color_Folder_Header_Seasonal.xml', 
ColorFolderPrintSchema = 'Color_Folder_Print_Seasonal.xml',
ColorPaletteSchema = 'Color_Palette_Edit_Seasonal.xml',
ColorPaletteItemSchema = 'Color_PaletteItem_Seasonal.xml',
ColorPaletteSearchSchema = 'Color_Palette_Search_Seasonal.xml',
ColorPaletteImageSchema = 'Color_Palette_Image_Edit_Seasonal.xml',
ColorPaletteGridSearchSchema = 'Color_Palette_GridSearch_Seasonal.xml'
WHERE ColorTypeDescription = 'Seasonal'

UPDATE pColorType 
SET ColorFolderSearchSchema = 'Color_Folder_Search_Textile.xml', 
ColorFolderSchema = 'Color_Folder_Textile.xml', 
ColorFolderHeaderSchema = 'Color_Folder_Header_Textile.xml', 
ColorFolderPrintSchema = 'Color_Folder_Print_Textile.xml',
ColorPaletteSchema = 'Color_Palette_Edit_Textile.xml',
ColorPaletteItemSchema = 'Color_PaletteItem_Textile.xml',
ColorPaletteSearchSchema = 'Color_Palette_Search_Textile.xml',
ColorPaletteImageSchema = 'Color_Palette_Image_Edit_Textile.xml',
ColorPaletteGridSearchSchema = 'Color_Palette_GridSearch_Textile.xml'
WHERE ColorTypeDescription = 'Textile'
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08889', GetDate())
GO
