SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_StyleBOL_SELECT]
AS
/* SELECT Linked Macro*/ SELECT PageOperationId, MacroCode AS Code, MacroName AS Name, Sort, PageOperationId AS Sort1, '0' AS Sort2, 
                      pStyleBOLPageOperations.Comments, Image AS ImageID, 'BOLMOP' AS ImageType,
                          (SELECT     SUM(SAM)
                            FROM          pBOLOperations INNER JOIN
                                                   pBOLOpToMacro ON pBOLOperations.OperationId = pBOLOpToMacro.OperationId
                            WHERE      pBOLOpToMacro.MacroId = pBOLMacro.MacroId) AS SAM, pStyleBOLPageOperations.Coef, pStyleBOLPageOperations.Adj, NULL AS BaseRateId, NULL 
                      AS MachineId, pStyleBOLPageOperations.IsLinked, pStyleBOLPageOperations.MacroId, NULL AS OperationId, NULL AS MacroParentId, StyleID, StyleSet, pStyleBOLPageOperations.IsException 
FROM         pStyleBOLPageOperations INNER JOIN
                      pBOLMacro ON pStyleBOLPageOperations.MacroId = pBOLMacro.MacroId
WHERE     IsLinked = 1 AND pStyleBOLPageOperations.MacroId IS NOT NULL
UNION
/* SELECT Operations of Linked Macro*/ SELECT PageOperationId, pBOLOperations.OperationCode AS Code, pBOLOperations.OperationName AS Name, 
                      pStyleBOLPageOperations.Sort, pStyleBOLPageOperations.PageOperationId AS Sort1, pBOLOpToMacro.Sort AS Sort2, pStyleBOLPageOperations.Comments, 
                      pBOLOperations.Image AS ImageID, 'BOLOP' AS ImageType, pBOLOperations.SAM, NULL AS Coef, NULL AS Adj, pBOLOperations.BaseRateId, 
                      pBOLOperations.MachineId, pStyleBOLPageOperations.IsLinked, NULL AS MacroId, pBOLOperations.OperationId, PageOperationId AS MacroParentId, StyleID, 
                      StyleSet, pStyleBOLPageOperations.IsException
FROM         pStyleBOLPageOperations INNER JOIN
                      pBOLOpToMacro ON pStyleBOLPageOperations.MacroId = pBOLOpToMacro.MacroId INNER JOIN
                      pBOLOperations ON pBOLOpToMacro.OperationId = pBOLOperations.OperationId
WHERE     IsLinked = 1 AND pStyleBOLPageOperations.MacroId IS NOT NULL
UNION
/* SELECT Linked Operations*/ SELECT PageOperationId, OperationCode AS Code, OperationName AS Name, pStyleBOLPageOperations.Sort, NULL AS Sort1, '0' AS Sort2, 
                      pStyleBOLPageOperations.Comments, Image AS ImageID, 'BOLOP' AS ImageType, pBOLOperations.SAM, pStyleBOLPageOperations.Coef, 
                      pStyleBOLPageOperations.Adj, pBOLOperations.BaseRateId, pBOLOperations.MachineId, pStyleBOLPageOperations.IsLinked, NULL AS MacroId, 
                      pStyleBOLPageOperations.OperationId, NULL AS MacroParentId, StyleID, StyleSet, pStyleBOLPageOperations.IsException
FROM         pStyleBOLPageOperations INNER JOIN
                      pBOLOperations ON pStyleBOLPageOperations.OperationId = pBOLOperations.OperationId
WHERE     IsLinked = 1 AND pStyleBOLPageOperations.OperationId IS NOT NULL
UNION
/* SELECT Operations of Unlinked Macro*/ SELECT T1.PageOperationId, T1.Code, T1.Name, T2.Sort, T1.MacroParentId AS Sort1, T1.Sort AS Sort2, T1.Comments, T1.ImageID, 
                      T1.ImageType, T1.SAM, T1.Coef, T1.Adj, T1.BaseRateId, T1.MachineId, T1.IsLinked, T1.MacroId, T1.OperationId, T1.MacroParentId, T1.StyleID, T1.StyleSet, T1.IsException
FROM         pStyleBOLPageOperations AS T1 INNER JOIN
                      pStyleBOLPageOperations AS T2 ON T1.MacroParentId = T2.PageOperationId
WHERE     T1.IsLinked = 0 AND T1.MacroParentId IS NOT NULL
UNION
/* SELECT Unlinked Operations or Unlinked Macro*/ SELECT T4.PageOperationId, T4.Code, T4.Name, T4.Sort, T4.PageOperationId AS Sort1, '0' AS Sort2, T4.Comments, 
                      T4.ImageID, T4.ImageType, SAM = CASE WHEN MacroId IS NOT NULL THEN
                          (SELECT     SUM((T3.SAM * ISNULL(T3.Coef, 1)) + (T3.SAM * ISNULL(T3.Coef, 1) * ISNULL(cast(T3.Adj AS numeric(10, 2)), 0) / 100))
                            FROM          pStyleBOLPageOperations AS T3
                            WHERE      T3.MacroParentId = T4.PageOperationId) ELSE SAM END, T4.Coef, T4.Adj, T4.BaseRateId, T4.MachineId, T4.IsLinked, T4.MacroId, T4.OperationId, 
                      T4.MacroParentId, T4.StyleID, T4.StyleSet, T4.IsException
FROM         pStyleBOLPageOperations AS T4
WHERE     T4.IsLinked = 0 AND T4.MacroParentId IS NULL


GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[5] 4[18] 2[51] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 3480
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_StyleBOL_SELECT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_StyleBOL_SELECT'

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01816'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01816', GetDate())
END

GO
