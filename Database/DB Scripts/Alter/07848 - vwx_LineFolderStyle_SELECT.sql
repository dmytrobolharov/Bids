/****** Object:  View [dbo].[vwx_LineFolderStyle_SELECT]    Script Date: 06/03/2014 20:27:56 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderStyle_SELECT]'))
DROP VIEW [dbo].[vwx_LineFolderStyle_SELECT]
GO

/****** Object:  View [dbo].[vwx_LineFolderStyle_SELECT]    Script Date: 06/03/2014 20:27:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_LineFolderStyle_SELECT]
AS
SELECT DISTINCT 
                      dbo.pLineFolderItem.LineFolderItemID, dbo.pLineFolderItem.LineFolderID, dbo.pLineFolderItem.LineFolderItemDrop, dbo.pStyleHeader.StyleID, 
                      dbo.pStyleHeader.DevelopmentNo + '*' + CAST(dbo.pStyleDevelopmentItem.Variation AS NVARCHAR(5)) AS ConceptNo, dbo.pStyleHeader.DevelopmentNo, 
                      dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField5 AS PatternRef, dbo.pStyleHeader.Description, 
                      dbo.pStyleHeader.CustomField8 AS DMCStyleType, dbo.pStyleMaterials.F AS FabricYarnType, dbo.pStyleMaterials.MaterialName AS MainMaterial, 
                      dbo.pStyleMaterials.H AS [Content], dbo.pStyleMaterials.I AS FabricWeight, dbo.pStyleHeader.SizeRange, dbo.pLineFolder.SeasonYearID, 
                      dbo.pLineFolder.LineFolderTypeID, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.DesignSketchVersion, 
                      dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.WorkflowType, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, 
                      dbo.pStyleHeader.TradePartnerID, dbo.pStyleHeader.IntroSeasonYearID, dbo.pStyleCategory.StyleCategory AS StyleCategoryName, c.TeamId, c.AccessRoleId, 
                      c.AccessModify, dbo.pLineFolderItem.LineFolderImageID, dbo.pLineFolderItem.LineFolderImageVersion, dbo.pLineFolderItem.LineFolderItemSort, 
                      dbo.pStyleCategory.StyleCategoryId, dbo.pLineFolderItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID AS ColorwaySeasonYearID
FROM         dbo.pLineFolderItem INNER JOIN
                      dbo.pStyleHeader ON dbo.pLineFolderItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
                          (SELECT ptm.IntProductTypeId, pt.PermissionProductTypeName, u.TeamID, 
								MAX(workflow.PermissionRoleId) AS AccessRoleID, MAX(workflow.PermissionModify) AS AccessModify
								FROM sPermissionWorkflow AS workflow
								INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
								INNER JOIN sPermissionProductTypeMap as ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId
								INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId
								INNER JOIN uUserGroup AS ugr ON workflow.GroupId = ugr.GroupID
								INNER JOIN Users AS u ON ugr.TeamID = u.TeamID
								WHERE folders.PermissionFolderTypeId = 2
								AND pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1 
								GROUP BY ptm.IntProductTypeId, pt.PermissionProductTypeName, u.TeamID) 
						AS c ON dbo.pStyleHeader.StyleType = c.IntProductTypeId INNER JOIN
                      dbo.pStyleDevelopmentItem ON dbo.pStyleHeader.StyleID = dbo.pStyleDevelopmentItem.StyleID INNER JOIN
                      dbo.pLineFolder ON dbo.pLineFolderItem.LineFolderID = dbo.pLineFolder.LineFolderID LEFT OUTER JOIN
                      dbo.pStyleMaterials ON dbo.pStyleHeader.StyleID = dbo.pStyleMaterials.StyleID AND dbo.pStyleHeader.StyleSet = dbo.pStyleMaterials.StyleSet AND 
                      dbo.pStyleMaterials.MainMaterial = 1 INNER JOIN
                      dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId INNER JOIN
                      dbo.pStyleSeasonYear ON dbo.pLineFolderItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07848', GetDate())
GO