IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_SELECT]'))
DROP VIEW [dbo].[vwx_Planning_SELECT]
GO

CREATE VIEW [dbo].[vwx_Planning_SELECT]
AS
		SELECT     p.*, psy.PlanningSeason, psy.PlanningYear, psy.SeasonYearID, STUFF
      ((SELECT     ', ' + d .Custom
          FROM         iCustom1 d INNER JOIN
                                pPlanningDivision ON d .CustomID = pPlanningDivision.DivisionID
          WHERE     pPlanningDivision.PlanningID = p.PlanningID FOR XML PATH('')), 1, 2, '') AS Divisions, STUFF
      ((SELECT     ', ' + stype.StyleTypeDescription
          FROM         (SELECT DISTINCT st.StyleTypeDescription
                                 FROM          pStyleType st INNER JOIN
                                                        pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID INNER JOIN
                                                        pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
                                 WHERE      pPlanningDivision.PlanningID = p.PlanningID) stype FOR XML PATH('')), 1, 2, '') AS StyleTypes, STUFF
      ((SELECT     ', ' + scategory.StyleCategory
          FROM         (SELECT DISTINCT sc.StyleCategory
		 FROM          pStyleCategory sc INNER JOIN
								pStyleCategoryStyleType scst ON sc.StyleCategoryId = scst.StyleCategoryID INNER JOIN
								pDivisionStyleType dst ON scst.StyleTypeID = dst.StyleTypeID INNER JOIN
								pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
		 WHERE      pPlanningDivision.PlanningID = p.PlanningID) scategory FOR XML PATH('')), 1, 2, '') AS StyleCategories, pt.PlanningType 
		FROM pPlanning p 
		LEFT JOIN pPlanningSeasonYear psy ON p.PlanningID = psy.PlanningID
		LEFT JOIN pPlanningType pt ON p.PlanningTypeID = pt.PlanningTypeID

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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_Planning_SELECT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_Planning_SELECT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07482', GetDate())
GO