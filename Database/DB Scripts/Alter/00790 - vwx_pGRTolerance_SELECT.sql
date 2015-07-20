
/****** Object:  View [dbo].[vwx_pGRTolerance_SELECT]    Script Date: 12/01/2010 10:39:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRTolerance_SELECT]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_pGRTolerance_SELECT]
GO

CREATE VIEW [dbo].[vwx_pGRTolerance_SELECT]
AS
SELECT     t.ToleranceGuidId, b.POMAlternatesId, a.POMGuidId AS pomid, a.ImageSerialNumber AS GISNo, a.RefCode AS GRRefcode, g.AlternatesCode AS Alternates, 
                      a.SortField AS GTSortField, a.POMDesc, g.AlternatesDesc, t.TolPlus, t.TolMinus, t.IsOnQA, c.SizeClassGuidId, t.IsPrimaryKeyMeas, t.ProductClassImageId
FROM         dbo.pGRPOMCompany INNER JOIN
                      dbo.pGRTolerance AS t ON dbo.pGRPOMCompany.POMCompanyId = t.POMCompanyId INNER JOIN
                      dbo.pGRProductClassImage AS c ON t.ProductClassImageId = c.ProductClassImageID INNER JOIN
                      dbo.pGRPOMAlternates AS b INNER JOIN
                      dbo.pGRAlternates AS g ON b.AlternatesGuidId = g.AlternatesGuidId INNER JOIN
                      dbo.pGRPOM AS a ON a.POMGuidId = b.POMGuidId ON dbo.pGRPOMCompany.POMAlternatesId = b.POMAlternatesId

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[56] 2[19] 3) )"
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
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
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
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -103
      End
      Begin Tables = 
         Begin Table = "pGRPOMCompany"
            Begin Extent = 
               Top = 45
               Left = 98
               Bottom = 177
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 0
               Left = 468
               Bottom = 119
               Right = 673
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 14
               Left = 753
               Bottom = 133
               Right = 945
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 218
               Left = 298
               Bottom = 337
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 297
               Left = 635
               Bottom = 416
               Right = 805
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 158
               Left = 632
               Bottom = 277
               Right = 814
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
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
  ' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'vwx_pGRTolerance_SELECT'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2655
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
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
' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'vwx_pGRTolerance_SELECT'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'vwx_pGRTolerance_SELECT'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '790', GetDate())
GO
