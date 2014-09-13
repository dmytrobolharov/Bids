/****** Object:  View [dbo].[vwx_LineFolderItem_SELECT]    Script Date: 06/05/2014 14:09:12 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderItem_SELECT]'))
DROP VIEW [dbo].[vwx_LineFolderItem_SELECT]
GO

/****** Object:  View [dbo].[vwx_LineFolderItem_SELECT]    Script Date: 06/05/2014 14:09:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[vwx_LineFolderItem_SELECT]
AS
SELECT     dbo.pLineFolderItem.LineFolderID, dbo.pLineFolderItem.LineFolderItemID, dbo.pLineFolderItem.LineItemFolder1, dbo.pLineFolderItem.LineItemFolder2, 
                      dbo.pLineFolderItem.LineItemFolder3, dbo.pLineFolderItem.LineItemFolder4, dbo.pLineFolderItem.LineItemFolder5, dbo.pLineFolderItem.LineItemFolder6, 
                      dbo.pLineFolderItem.LineItemFolder7, dbo.pLineFolderItem.LineItemFolder8, dbo.pLineFolderItem.LineItemFolder9, dbo.pLineFolderItem.LineFolderItemDrop, 
                      dbo.pLineFolderItem.LineFolderItemDropUser, dbo.pLineFolderItem.LineFolderItemDropDate, dbo.pLineFolderItem.LineFolderImageID, 
                      dbo.pLineFolderItem.LineFolderImageVersion, dbo.pLineFolderItem.CUser, dbo.pLineFolderItem.CDate, dbo.pLineFolderItem.MUser, dbo.pLineFolderItem.MDate, 
                      dbo.pLineFolderItem.MChange, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DevelopmentNo + '*' + CAST(dbo.pStyleDevelopmentItem.Variation AS NVARCHAR(5)) 
                      AS ConceptNo, dbo.pStyleHeader.DevelopmentNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField5 AS PatternRef, 
                      dbo.pStyleHeader.Description, dbo.pStyleHeader.CustomField8 AS DMCStyleType, dbo.pStyleMaterials.F AS FabricYarnType, 
                      dbo.pStyleMaterials.MaterialName AS MainMaterial, dbo.pStyleMaterials.H AS [Content], dbo.pStyleMaterials.I AS FabricWeight, dbo.pStyleHeader.SizeRange, 
                      dbo.pLineFolder.SeasonYearID, dbo.pLineFolder.LineFolderTypeID, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.DesignSketchID, 
                      dbo.pStyleHeader.DesignSketchVersion, dbo.pLineFolderItem.LineFolderItemSort, dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.StyleType, 
                      dbo.pStyleHeader.WorkflowType, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, dbo.pStyleHeader.TradePartnerID, dbo.pStyleHeader.IntroSeasonYearID, 
                      dbo.pLineFolderItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID AS ColorwaySeasonYearID, 
                      dbo.pStyleCategory.StyleCategory AS StyleCategoryName, c.TeamId, c.AccessRoleId, c.AccessModify, dbo.pStyleHeader.CustomField3 as styleStatus,
                      dbo.pLineFolderItem.StyleBOMDimensionID, dbo.pWorkFlowItem.WorkFlowItemName AS BOMName,
                      dbo.pStyleHeader.DivisionID, dbo.pStyleHeader.SubCategoryId, 
                      '<img src="' + REPLACE(dbo.fnx_GetStreamingImageSmallPath(dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.DesignSketchVersion), 'S=500', 'S=50') + '" alt="" />' AS [Image]
FROM         dbo.pLineFolderItem INNER JOIN
                      dbo.pStyleHeader ON dbo.pLineFolderItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
                      vwx_Permissions_ProductTypes AS c ON dbo.pStyleHeader.StyleType = c.IntProductTypeId AND c.PermissionFolderTypeId = 2 INNER JOIN
                      dbo.pStyleDevelopmentItem ON dbo.pStyleHeader.StyleID = dbo.pStyleDevelopmentItem.StyleID INNER JOIN
                      dbo.pLineFolder ON dbo.pLineFolderItem.LineFolderID = dbo.pLineFolder.LineFolderID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pLineFolderItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleMaterials ON dbo.pStyleHeader.StyleID = dbo.pStyleMaterials.StyleID AND dbo.pStyleHeader.StyleSet = dbo.pStyleMaterials.StyleSet AND 
                      dbo.pStyleMaterials.MainMaterial = 1 INNER JOIN
                      dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId LEFT JOIN
                      dbo.pStyleBOMDimension ON dbo.pLineFolderItem.StyleBOMDimensionID = dbo.pStyleBOMDimension.StyleBOMDimensionID LEFT JOIN
                      dbo.pWorkFlowItem ON dbo.pStyleBOMDimension.WorkFlowItemID = dbo.pWorkFlowItem.WorkFlowItemID





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07933', GetDate())
GO