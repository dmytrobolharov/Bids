-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 25 May 2011                                                                                */
-- * WorkItem#3397 :Altered to include webservice for Image/Color                                                                                           */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--




/****** Object:  View [dbo].[vwx_StyleSourcing_MaterialSummary_SELECT]    Script Date: 05/24/2011 10:47:35 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSourcing_MaterialSummary_SELECT]'))
DROP VIEW [dbo].[vwx_StyleSourcing_MaterialSummary_SELECT]
GO


/****** Object:  View [dbo].[vwx_StyleSourcing_MaterialSummary_SELECT]    Script Date: 05/24/2011 10:47:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_StyleSourcing_MaterialSummary_SELECT]
AS
SELECT     a.StyleSourcingItemID, a.StyleSourcingID, a.CDate, a.CUser, a.MDate, a.MUser, a.StyleMaterialID, a.TradePartnerVendorID, b.UOM AS Expr1, b.Qty, 
                      a.MaterialPrice, a.Sort, a.StyleColorID, a.StyleSet, a.BOM, b.MainMaterial, b.MaterialType, '' AS GroupName, c.ComponentDescription, b.MaterialNo, 
                      b.MaterialName, b.UOM, b.MaterialID, '<img src=''http://' + @@SERVERNAME + '/plmOnImageServer/ImageStream.ashx?S=50&V=' + CAST(ISNULL(b.MaterialImageVersion, 0) 
                      AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(b.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '''  />' AS MaterialImage, ISNULL(b.MaterialSize, 'NA*') AS MaterialSize, 
                      '<img src=''http://' + @@SERVERNAME + '/plmOnImageServer/ColorStream.ashx?S=40&CFID=' + CAST(ISNULL(e.ColorFolderID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(e.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS Color, 
                      e.ColorPaletteID, ISNULL(b.MaterialSizeID, '00000000-0000-0000-0000-000000000000') AS MaterialSizeID, b.StyleID, b.MaterialSort, 
                      CASE WHEN b.MaterialSizeID IS NULL OR
                      b.MaterialSizeID = '00000000-0000-0000-0000-000000000000' THEN '*NA' ELSE f.MaterialSize END AS Expr2, a.CustomField1, h.SeasonYearID, 
                      e.MaterialColorID
FROM         dbo.pStyleSourcingItem AS a INNER JOIN
                      dbo.pStyleSourcing AS g ON g.StyleSourcingID = a.StyleSourcingID INNER JOIN
                      dbo.pStyleSeasonYear AS h ON g.StyleSeasonYearID = h.StyleSeasonYearID INNER JOIN
                      dbo.pStyleMaterials AS b ON a.StyleMaterialID = b.StyleMaterialID INNER JOIN
                      dbo.pComponentType AS c ON b.MaterialType = c.ComponentTypeID LEFT OUTER JOIN
                      dbo.pStyleColorwayItem AS d ON d.StyleColorID = a.StyleColorID AND d.StyleMaterialID = a.StyleMaterialID LEFT OUTER JOIN
                      dbo.pMaterialColor AS e ON e.MaterialColorID = d.MaterialColorID LEFT OUTER JOIN
                      dbo.pMaterialSize AS f ON b.MaterialSizeID = f.MaterialSizeID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01471', GetDate())
GO