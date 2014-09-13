/****** Object:  View [dbo].[vwx_LineFolderItem_SELECT]    Script Date: 11/29/2012 14:17:19 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderItem_SELECT]'))
DROP VIEW [dbo].[vwx_LineFolderItem_SELECT]
GO


/****** Object:  View [dbo].[vwx_LineFolderItem_SELECT]    Script Date: 11/29/2012 14:17:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
                      dbo.pStyleHeader.DesignSketchVersion, dbo.pLineFolderItem.LineFolderItemSort, dbo.pStyleHeader.StyleCategory, 
                      dbo.pStyleCategory.StyleCategory AS StyleCategoryName
FROM         dbo.pLineFolderItem INNER JOIN
                      dbo.pStyleHeader ON dbo.pLineFolderItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
                      dbo.pStyleDevelopmentItem ON dbo.pStyleHeader.StyleID = dbo.pStyleDevelopmentItem.StyleID INNER JOIN
                      dbo.pLineFolder ON dbo.pLineFolderItem.LineFolderID = dbo.pLineFolder.LineFolderID LEFT OUTER JOIN
                      dbo.pStyleMaterials ON dbo.pStyleHeader.StyleID = dbo.pStyleMaterials.StyleID AND dbo.pStyleHeader.StyleSet = dbo.pStyleMaterials.StyleSet AND 
                      dbo.pStyleMaterials.MainMaterial = 1 INNER JOIN
                      dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId AND 
                      dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pLineFolderItem"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleHeader"
            Begin Extent = 
               Top = 6
               Left = 273
               Bottom = 114
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "pStyleDevelopmentItem"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pLineFolder"
            Begin Extent = 
               Top = 114
               Left = 276
               Bottom = 222
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleMaterials"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 330
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleCategory"
            Begin Extent = 
               Top = 102
               Left = 496
               Bottom = 210
               Right = 717
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 43
         Width = 284
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_LineFolderItem_SELECT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1155
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_LineFolderItem_SELECT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_LineFolderItem_SELECT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04488', GetDate())
GO
