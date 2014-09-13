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

UPDATE pComponentType 
SET ComponentSchema = 'Material_Wovens.xml',
ComponentHeaderSchema = 'Material_Header_Wovens.xml',
ComponentSearchSchema = 'Material_Search_Wovens.xml',
ComponentStyleSchema = 'Material_Style_Wovens.xml',
ComponentPrintSchema = 'Material_Print_Wovens.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Wovens.xml',
ComponentIDSchema = 'Material_ID_Wovens.xml',
ComponentLinkSchema = 'Material_Link_Wovens.xml',
ComponentSizeSchema = 'Material_Size_Wovens.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Wovens.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Wovens.xml'
WHERE ComponentDescription = 'Wovens'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Knits.xml',
ComponentHeaderSchema = 'Material_Header_Knits.xml',
ComponentSearchSchema = 'Material_Search_Knits.xml',
ComponentStyleSchema = 'Material_Style_Knits.xml',
ComponentPrintSchema = 'Material_Print_Knits.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Knits.xml',
ComponentIDSchema = 'Material_ID_Knits.xml',
ComponentLinkSchema = 'Material_Link_Knits.xml',
ComponentSizeSchema = 'Material_Size_Knits.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Knits.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Knits.xml'
WHERE ComponentDescription = 'Knits'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Yarns.xml',
ComponentHeaderSchema = 'Material_Header_Yarns.xml',
ComponentSearchSchema = 'Material_Search_Yarns.xml',
ComponentStyleSchema = 'Material_Style_Yarns.xml',
ComponentPrintSchema = 'Material_Print_Yarns.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Yarns.xml',
ComponentIDSchema = 'Material_ID_Yarns.xml',
ComponentLinkSchema = 'Material_Link_Yarns.xml',
ComponentSizeSchema = 'Material_Size_Yarns.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Yarns.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Yarns.xml'
WHERE ComponentDescription = 'Yarns'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Other.xml',
ComponentHeaderSchema = 'Material_Header_Other.xml',
ComponentSearchSchema = 'Material_Search_Other.xml',
ComponentStyleSchema = 'Material_Style_Other.xml',
ComponentPrintSchema = 'Material_Print_Other.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Other.xml',
ComponentIDSchema = 'Material_ID_Other.xml',
ComponentLinkSchema = 'Material_Link_Other.xml',
ComponentSizeSchema = 'Material_Size_Other.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Other.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Other.xml'
WHERE ComponentDescription = 'Other'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Interlining.xml',
ComponentHeaderSchema = 'Material_Header_Interlining.xml',
ComponentSearchSchema = 'Material_Search_Interlining.xml',
ComponentStyleSchema = 'Material_Style_Interlining.xml',
ComponentPrintSchema = 'Material_Print_Interlining.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Interlining.xml',
ComponentIDSchema = 'Material_ID_Interlining.xml',
ComponentLinkSchema = 'Material_Link_Interlining.xml',
ComponentSizeSchema = 'Material_Size_Interlining.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Interlining.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Interlining.xml'
WHERE ComponentDescription = 'Interlining'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Thread.xml',
ComponentHeaderSchema = 'Material_Header_Thread.xml',
ComponentSearchSchema = 'Material_Search_Thread.xml',
ComponentStyleSchema = 'Material_Style_Thread.xml',
ComponentPrintSchema = 'Material_Print_Thread.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Thread.xml',
ComponentIDSchema = 'Material_ID_Thread.xml',
ComponentLinkSchema = 'Material_Link_Thread.xml',
ComponentSizeSchema = 'Material_Size_Thread.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Thread.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Thread.xml'
WHERE ComponentDescription = 'Thread'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Artwork.xml',
ComponentHeaderSchema = 'Material_Header_Artwork.xml',
ComponentSearchSchema = 'Material_Search_Artwork.xml',
ComponentStyleSchema = 'Material_Style_Artwork.xml',
ComponentPrintSchema = 'Material_Print_Artwork.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Artwork.xml',
ComponentIDSchema = 'Material_ID_Artwork.xml',
ComponentLinkSchema = 'Material_Link_Artwork.xml',
ComponentSizeSchema = 'Material_Size_Artwork.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Artwork.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Artwork.xml'
WHERE ComponentDescription = 'Artwork'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Embroidery.xml',
ComponentHeaderSchema = 'Material_Header_Embroidery.xml',
ComponentSearchSchema = 'Material_Search_Embroidery.xml',
ComponentStyleSchema = 'Material_Style_Embroidery.xml',
ComponentPrintSchema = 'Material_Print_Embroidery.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Embroidery.xml',
ComponentIDSchema = 'Material_ID_Embroidery.xml',
ComponentLinkSchema = 'Material_Link_Embroidery.xml',
ComponentSizeSchema = 'Material_Size_Embroidery.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Embroidery.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Embroidery.xml'
WHERE ComponentDescription = 'Embroidery'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Trimmings.xml',
ComponentHeaderSchema = 'Material_Header_Trimmings.xml',
ComponentSearchSchema = 'Material_Search_Trimmings.xml',
ComponentStyleSchema = 'Material_Style_Trimmings.xml',
ComponentPrintSchema = 'Material_Print_Trimmings.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Trimmings.xml',
ComponentIDSchema = 'Material_ID_Trimmings.xml',
ComponentLinkSchema = 'Material_Link_Trimmings.xml',
ComponentSizeSchema = 'Material_Size_Trimmings.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Trimmings.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Trimmings.xml'
WHERE ComponentDescription = 'Trimmings'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Labels.xml',
ComponentHeaderSchema = 'Material_Header_Labels.xml',
ComponentSearchSchema = 'Material_Search_Labels.xml',
ComponentStyleSchema = 'Material_Style_Labels.xml',
ComponentPrintSchema = 'Material_Print_Labels.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Labels.xml',
ComponentIDSchema = 'Material_ID_Labels.xml',
ComponentLinkSchema = 'Material_Link_Labels.xml',
ComponentSizeSchema = 'Material_Size_Labels.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Labels.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Labels.xml'
WHERE ComponentDescription = 'Labels'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Packaging.xml',
ComponentHeaderSchema = 'Material_Header_Packaging.xml',
ComponentSearchSchema = 'Material_Search_Packaging.xml',
ComponentStyleSchema = 'Material_Style_Packaging.xml',
ComponentPrintSchema = 'Material_Print_Packaging.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Packaging.xml',
ComponentIDSchema = 'Material_ID_Packaging.xml',
ComponentLinkSchema = 'Material_Link_Packaging.xml',
ComponentSizeSchema = 'Material_Size_Packaging.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Packaging.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Packaging.xml'
WHERE ComponentDescription = 'Packaging'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Zippers.xml',
ComponentHeaderSchema = 'Material_Header_Zippers.xml',
ComponentSearchSchema = 'Material_Search_Zippers.xml',
ComponentStyleSchema = 'Material_Style_Zippers.xml',
ComponentPrintSchema = 'Material_Print_Zippers.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Zippers.xml',
ComponentIDSchema = 'Material_ID_Zippers.xml',
ComponentLinkSchema = 'Material_Link_Zippers.xml',
ComponentSizeSchema = 'Material_Size_Zippers.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Zippers.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Zippers.xml'
WHERE ComponentDescription = 'Zippers'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Lining.xml',
ComponentHeaderSchema = 'Material_Header_Lining.xml',
ComponentSearchSchema = 'Material_Search_Lining.xml',
ComponentStyleSchema = 'Material_Style_Lining.xml',
ComponentPrintSchema = 'Material_Print_Lining.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Lining.xml',
ComponentIDSchema = 'Material_ID_Lining.xml',
ComponentLinkSchema = 'Material_Link_Lining.xml',
ComponentSizeSchema = 'Material_Size_Lining.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Lining.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Lining.xml'
WHERE ComponentDescription = 'Lining'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Lasts.xml',
ComponentHeaderSchema = 'Material_Header_Lasts.xml',
ComponentSearchSchema = 'Material_Search_Lasts.xml',
ComponentStyleSchema = 'Material_Style_Lasts.xml',
ComponentPrintSchema = 'Material_Print_Lasts.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Lasts.xml',
ComponentIDSchema = 'Material_ID_Lasts.xml',
ComponentLinkSchema = 'Material_Link_Lasts.xml',
ComponentSizeSchema = 'Material_Size_Lasts.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Lasts.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Lasts.xml'
WHERE ComponentDescription = 'Lasts'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Leather.xml',
ComponentHeaderSchema = 'Material_Header_Leather.xml',
ComponentSearchSchema = 'Material_Search_Leather.xml',
ComponentStyleSchema = 'Material_Style_Leather.xml',
ComponentPrintSchema = 'Material_Print_Leather.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Leather.xml',
ComponentIDSchema = 'Material_ID_Leather.xml',
ComponentLinkSchema = 'Material_Link_Leather.xml',
ComponentSizeSchema = 'Material_Size_Leather.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Leather.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Leather.xml'
WHERE ComponentDescription = 'Leather'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Upper.xml',
ComponentHeaderSchema = 'Material_Header_Upper.xml',
ComponentSearchSchema = 'Material_Search_Upper.xml',
ComponentStyleSchema = 'Material_Style_Upper.xml',
ComponentPrintSchema = 'Material_Print_Upper.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Upper.xml',
ComponentIDSchema = 'Material_ID_Upper.xml',
ComponentLinkSchema = 'Material_Link_Upper.xml',
ComponentSizeSchema = 'Material_Size_Upper.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Upper.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Upper.xml'
WHERE ComponentDescription = 'Upper'

UPDATE pComponentType 
SET ComponentSchema = 'Material_ToeBox.xml',
ComponentHeaderSchema = 'Material_Header_ToeBox.xml',
ComponentSearchSchema = 'Material_Search_ToeBox.xml',
ComponentStyleSchema = 'Material_Style_ToeBox.xml',
ComponentPrintSchema = 'Material_Print_ToeBox.xml',
ComponentStylePrintSchema = 'Material_StylePrint_ToeBox.xml',
ComponentIDSchema = 'Material_ID_ToeBox.xml',
ComponentLinkSchema = 'Material_Link_ToeBox.xml',
ComponentSizeSchema = 'Material_Size_ToeBox.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_ToeBox.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_ToeBox.xml'
WHERE ComponentDescription = 'Toe Box'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Heel.xml',
ComponentHeaderSchema = 'Material_Header_Heel.xml',
ComponentSearchSchema = 'Material_Search_Heel.xml',
ComponentStyleSchema = 'Material_Style_Heel.xml',
ComponentPrintSchema = 'Material_Print_Heel.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Heel.xml',
ComponentIDSchema = 'Material_ID_Heel.xml',
ComponentLinkSchema = 'Material_Link_Heel.xml',
ComponentSizeSchema = 'Material_Size_Heel.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Heel.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Heel.xml'
WHERE ComponentDescription = 'Heel'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Sole.xml',
ComponentHeaderSchema = 'Material_Header_Sole.xml',
ComponentSearchSchema = 'Material_Search_Sole.xml',
ComponentStyleSchema = 'Material_Style_Sole.xml',
ComponentPrintSchema = 'Material_Print_Sole.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Sole.xml',
ComponentIDSchema = 'Material_ID_Sole.xml',
ComponentLinkSchema = 'Material_Link_Sole.xml',
ComponentSizeSchema = 'Material_Size_Sole.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Sole.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Sole.xml'
WHERE ComponentDescription = 'Sole'

UPDATE pComponentType 
SET ComponentSchema = 'Material_Tooling.xml',
ComponentHeaderSchema = 'Material_Header_Tooling.xml',
ComponentSearchSchema = 'Material_Search_Tooling.xml',
ComponentStyleSchema = 'Material_Style_Tooling.xml',
ComponentPrintSchema = 'Material_Print_Tooling.xml',
ComponentStylePrintSchema = 'Material_StylePrint_Tooling.xml',
ComponentIDSchema = 'Material_ID_Tooling.xml',
ComponentLinkSchema = 'Material_Link_Tooling.xml',
ComponentSizeSchema = 'Material_Size_Tooling.xml',
ComponentStyleBOMSchema = 'Material_StyleBOM_Tooling.xml',
ComponentStyleBOMPrintSchema = 'Material_StyleBOMPrint_Tooling.xml'
WHERE ComponentDescription = 'Tooling'
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08891', GetDate())
GO
