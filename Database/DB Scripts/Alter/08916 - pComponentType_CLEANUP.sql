-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 August, 2014                                                                            */
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

UPDATE pComponentType 
SET ComponentSchema = 'Material_Trimming.xml',
ComponentHeaderSchema = 'Material_Header_Trimming.xml',
ComponentSearchSchema = 'Material_Search_Trimming.xml',
ComponentStyleSchema = 'Material_Style_Trimming.xml',
ComponentPrintSchema = 'Material_Print_Trimming.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Trimming.xml',
ComponentIDSchema = 'Material_ID_Trimming.xml',
ComponentLinkSchema = 'Material_Link_Trimmings.xml',
ComponentSizeSchema = 'Material_Size_Trimmings.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Trimming.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Trimming.xml'
WHERE ComponentDescription = 'Trimmings'
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08916', GetDate())
GO
