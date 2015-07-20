

/****** Object:  View [dbo].[vwx_ChangeLogItemMR_SEL]    Script Date: 10/09/2012 11:06:39 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItemMR_SEL]'))
DROP VIEW [dbo].[vwx_ChangeLogItemMR_SEL]
GO


/****** Object:  View [dbo].[vwx_ChangeLogItemMR_SEL]    Script Date: 10/09/2012 11:06:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_ChangeLogItemMR_SEL]
AS
SELECT     b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate, a.ChangeLogItemID, a.ChangeTransID, a.ChangeLogID, a.ChangeFieldName, 
                      a.ChangeFieldAlias, a.ChangeBeforeValue, a.ChangeAfterValue, a.ChangeBeforeText, a.ChangeAfterText, a.ChangeSort, a.Custom_SMat_Name, a.Custom_SMat_Type, 
                      a.Custom_SMat_No, c.ChangeTransTablePKID, CASE ISNULL(b.ChangeTransTypeID, c.ChangeTransTypeID) 
                      WHEN 0 THEN 'Update' WHEN 1 THEN 'Add' WHEN 2 THEN 'Remove' WHEN 3 THEN 'Copy' WHEN 4 THEN 'Replace' END AS ActionType, c.ChangeSessionID, 
                      c.ChangeSessionNo, c.ChangeTransNo, e.MaterialRequestWorkflowID AS WorkflowID, e.MaterialRequestWorkflow AS Workflow
FROM         dbo.pChangeLogItem AS a WITH (NOLOCK) INNER JOIN
                      dbo.pChangeLog AS b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID INNER JOIN
                      dbo.pChangeTransaction AS c WITH (NOLOCK) ON c.ChangeTransID = a.ChangeTransID LEFT OUTER JOIN
                      dbo.pMaterialRequestToChangeTable AS d WITH (nolock) ON d.ChangeTableID = b.ChangeTableID LEFT OUTER JOIN
                      dbo.pMaterialRequestWorkflow AS e ON e.MaterialRequestWorkflowID = d.MaterialRequestWorkflowID

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[10] 2[46] 3) )"
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
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 114
               Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 488
               Bottom = 114
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 910
               Bottom = 114
               Right = 1194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 192
               Right = 263
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_ChangeLogItemMR_SEL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_ChangeLogItemMR_SEL'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04126', GetDate())
GO

