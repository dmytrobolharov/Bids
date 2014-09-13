IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingStyle_SEL]'))
DROP VIEW [dbo].[vwx_SourcingStyle_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_SEL]
AS
SELECT     styleHeader.StyleMasterID, styleHeader.StyleWorkflowID, styleHeader.StyleType, styleHeader.OwnerGroup, styleHeader.StyleLinkID, 
                      styleHeader.IntroSeasonYearID, styleHeader.SeasonYearID, styleHeader.StyleSeasonYearID, styleHeader.HeaderLocked, styleHeader.Season, styleHeader.Year, 
                      styleHeader.TradePartnerVendorID, styleHeader.TradePartnerID, styleHeader.BodyID, styleHeader.StyleStatusID, styleHeader.LinePlanItemID, 
                      styleHeader.StyleCopyID, styleHeader.PackagingNo, styleHeader.CustomField30, styleHeader.CustomField29, styleHeader.CustomField28, 
                      styleHeader.CustomField27, styleHeader.CustomField20, styleHeader.CustomField21, styleHeader.CustomField19, styleHeader.CustomField18, 
                      styleHeader.CustomField17, styleHeader.CustomField23, styleHeader.CustomField22, styleHeader.CustomField24, styleHeader.CustomField25, 
                      styleHeader.CustomField26, styleHeader.CustomField16, styleHeader.LinePlanSketchVersion, styleHeader.LinePlanSketchID, styleHeader.LinePlanNo, 
                      styleHeader.LinePlanID, styleHeader.StyleAttribute, styleHeader.StyleDetail2, styleHeader.StyleDetail1, styleHeader.StyleDetail, styleHeader.StyleVersion, 
                      styleHeader.NoColorCombo, styleHeader.Action, styleHeader.Change, styleHeader.Pc4, styleHeader.Pc3, styleHeader.Pc2, styleHeader.Pc1, 
                      styleHeader.CustomField15, styleHeader.CustomField14, styleHeader.CustomField13, styleHeader.CustomField12, styleHeader.CustomField11, 
                      styleHeader.CustomField10, styleHeader.CustomField9, styleHeader.CustomField8, styleHeader.CustomField6, styleHeader.CustomField7, 
                      styleHeader.CustomField5, styleHeader.CustomField4, styleHeader.CustomField3, styleHeader.CustomField2, styleHeader.CustomField1, styleHeader.SellingPrice, 
                      styleHeader.Markup, styleHeader.TargetPrice, styleHeader.SpecSketchVersion4, styleHeader.SpecSketchVersion3, styleHeader.SpecSketchVersion1, 
                      styleHeader.SpecSketchVersion2, styleHeader.SpecSketchID4, styleHeader.SpecSketchID3, styleHeader.SpecSketchID2, styleHeader.DetailSketchVersion4, 
                      styleHeader.SpecSketchID1, styleHeader.DetailSketchVersion3, styleHeader.DetailSketchVersion2, styleHeader.DetailSketchVersion1, styleHeader.DetailSketchID4, 
                      styleHeader.DetailSketchID3, styleHeader.DetailSketchID2, styleHeader.DetailSketchID1, styleHeader.ColorSketchVersion, styleHeader.ConceptSketchVersion, 
                      styleHeader.TechSketchVersion, styleHeader.DesignSketchVersion, styleHeader.ColorSketchID, styleHeader.ConceptSketchID, styleHeader.TechSketchID, 
                      styleHeader.StyleMaterialID, styleHeader.DesignSketchID, styleHeader.POMTempSizeClass4, styleHeader.POMTempVersion4, styleHeader.POMTempID4, 
                      styleHeader.POMTempSizeClass3, styleHeader.POMTempVersion3, styleHeader.POMTempID3, styleHeader.POMTempSizeClass2, styleHeader.POMTempVersion2, 
                      styleHeader.POMTempID2, styleHeader.POMTempVersion1, styleHeader.POMTempID1, styleHeader.POMTempSizeClass1, styleHeader.POMTempGroupID4, 
                      styleHeader.POMTempGroupID3, styleHeader.POMTempGroupID2, styleHeader.POMTempGroupID1, styleHeader.MaterialName, styleHeader.MaterialNo, 
                      styleHeader.MaterialImageVersion, styleHeader.MaterialImageID, styleHeader.WashType, styleHeader.StyleLocation, styleHeader.MaterialID, styleHeader.Pitch, 
                      styleHeader.StyleStatus, styleHeader.TechnicalDesigner, styleHeader.PatternMaker, styleHeader.ProductionManager, styleHeader.SampleMaker, 
                      styleHeader.Designer, styleHeader.Buyer, styleHeader.Customer, styleHeader.RecDate, styleHeader.DueDate, styleHeader.TechPackId, styleHeader.TechPackDate, 
                      styleHeader.SizeRange, styleHeader.SizeClass, styleHeader.StyleCategory, styleHeader.Description, styleHeader.SpecNo, styleHeader.ConceptNo, 
                      styleHeader.ConceptID, styleHeader.DevelopmentNo, styleHeader.DevelopmentID, styleHeader.CustomerNo, styleHeader.TempID, styleHeader.StyleNo, 
                      styleHeader.TempNo, styleHeader.WorkflowType, styleHeader.RefNo, dbo.pSourcingStyle.SourcingStyleID, dbo.pSourcingStyle.SourcingHeaderID, 
                      dbo.pSourcingStyle.StyleID, dbo.pSourcingStyle.Styleset, dbo.pSourcingStyle.Progress, dbo.pSourcingStyle.Complexity, dbo.pSourcingStyle.Priority, 
                      dbo.pSourcingStyle.Active, dbo.pSourcingStyle.CUser, dbo.pSourcingStyle.CDate, dbo.pSourcingStyle.MUser, dbo.pSourcingStyle.MDate, 
                      dbo.pSourcingStyle.Custom1, dbo.pSourcingStyle.Custom2, dbo.pSourcingStyle.Custom3, dbo.pSourcingStyle.Custom4, dbo.pSourcingStyle.Custom5
FROM         dbo.pSourcingStyle LEFT OUTER JOIN
                      dbo.vwx_StyleHeader_SEL AS styleHeader ON styleHeader.StyleID = dbo.pSourcingStyle.StyleID

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
         Left = -243
      End
      Begin Tables = 
         Begin Table = "styleHeader"
            Begin Extent = 
               Top = 6
               Left = 281
               Bottom = 197
               Right = 470
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pSourcingStyle"
            Begin Extent = 
               Top = 6
               Left = 508
               Bottom = 114
               Right = 675
            End
            DisplayFlags = 280
            TopColumn = 13
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
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
         Column = 2070
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_SourcingStyle_SEL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_SourcingStyle_SEL'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04112', GetDate())
GO
