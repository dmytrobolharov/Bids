/****** Object:  View [dbo].[vwx_SourcingStyle_Commitment_Default_SELECT]    Script Date: 11/21/2012 17:23:04 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingStyle_Commitment_Default_SELECT]'))
DROP VIEW [dbo].[vwx_SourcingStyle_Commitment_Default_SELECT]
GO


/****** Object:  View [dbo].[vwx_SourcingStyle_Commitment_Default_SELECT]    Script Date: 11/21/2012 17:23:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_Commitment_Default_SELECT]
AS
SELECT DISTINCT 
                      TOP (100) PERCENT '<img src=''../System/Icons/' + dbo.pStyleQuoteItemStatus.CustomIcon + ''' />' AS ImagePath, dbo.pSourcingCommitmentItem.StyleID, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemShare, dbo.pSourcingCommitmentItem.StyleQuoteItemStatusId, dbo.pSourcingCommitmentItem.StyleQuoteVariationId, 
                      dbo.pSourcingCommitmentItem.StyleQuoteID, dbo.pSourcingCommitmentItem.StyleQuotaDutyID, dbo.pSourcingCommitmentItem.StyleDevelopmentID, 
                      dbo.pSourcingCommitmentItem.StyleQuoteTradePartnerID, dbo.pSourcingCommitmentItem.StyleCostingID, dbo.pSourcingCommitmentItem.StyleCostingType, 
                      dbo.pSourcingCommitmentItem.StyleCostingFreightTypeID, dbo.pSourcingCommitmentItem.TradePartnerID, dbo.pSourcingCommitmentItem.TradePartnerVendorID, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField1, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField2, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField3, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField4, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField5, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField6, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField8, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField9, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField10, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField11, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField12, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField13, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField14, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField15, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField16, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField17, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField18, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField19, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField7, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField20, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField21, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField22, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField23, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField24, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField25, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField26, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField27, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField28, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField29, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField30, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField1, dbo.pSourcingCommitmentItem.StyleCostingCustomField2, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField3, dbo.pSourcingCommitmentItem.StyleCostingCustomField4, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField5, dbo.pSourcingCommitmentItem.StyleCostingCustomField6, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField7, dbo.pSourcingCommitmentItem.StyleCostingCustomField8, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField9, dbo.pSourcingCommitmentItem.StyleCostingCustomField10, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField11, dbo.pSourcingCommitmentItem.StyleCostingCustomField12, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField13, dbo.pSourcingCommitmentItem.StyleCostingCustomField14, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField15, dbo.pSourcingCommitmentItem.StyleCostingCustomField16, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField17, dbo.pSourcingCommitmentItem.StyleCostingCustomField18, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField19, dbo.pSourcingCommitmentItem.StyleCostingCustomField20, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField21, dbo.pSourcingCommitmentItem.StyleCostingCustomField22, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField23, dbo.pSourcingCommitmentItem.StyleCostingCustomField24, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField25, dbo.pSourcingCommitmentItem.StyleCostingCustomField26, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField27, dbo.pSourcingCommitmentItem.StyleCostingCustomField28, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField29, dbo.pSourcingCommitmentItem.StyleCostingCustomField30, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField31, dbo.pSourcingCommitmentItem.StyleCostingCustomField32, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField33, dbo.pSourcingCommitmentItem.StyleCostingCustomField34, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField35, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.SizeClass, dbo.pStyleCategory.StyleCategory, 
                      dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.Description, dbo.pSourcingCommitmentItem.StyleQuoteItemDueDate, dbo.pSourcingCommitmentItem.MDate, 
                      dbo.pSourcingCommitmentItem.StyleColorID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pSourcingCommitmentItem.StyleSourcingID, 
                      dbo.pSourcingCommitmentItem.SourcingHeaderID, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField31, dbo.pSourcingCommitmentItem.StyleSeasonYearID, 
                      dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleSeasonYear.StyleSeason + ' ' + dbo.pStyleSeasonYear.StyleYear AS StyleSeasonYear, 
                      dbo.pSourcingCommitmentItem.StyleCommitmentNo, dbo.pSourcingCommitmentItem.SourcingCommitmentItemID, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemID
FROM         dbo.pSourcingCommitmentItem INNER JOIN
                      dbo.pSourcingHeader ON dbo.pSourcingCommitmentItem.SourcingHeaderID = dbo.pSourcingHeader.SourcingHeaderID INNER JOIN
                      dbo.pSourcingStyle ON dbo.pSourcingCommitmentItem.StyleSourcingID = dbo.pSourcingStyle.SourcingStyleID INNER JOIN
                      dbo.pSourcingTradePartner ON dbo.pSourcingCommitmentItem.StyleQuoteTradePartnerID = dbo.pSourcingTradePartner.SourcingTradePartnerID INNER JOIN
                      dbo.pStyleHeader ON dbo.pSourcingCommitmentItem.StyleID = dbo.pStyleHeader.StyleID LEFT OUTER JOIN
                      dbo.pStyleBOMDimension ON dbo.pSourcingCommitmentItem.StyleColorID = dbo.pStyleBOMDimension.StyleBOMDimensionID LEFT OUTER JOIN
                      dbo.pWorkFlowItem ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pStyleBOMDimension.WorkFlowItemID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN
                      dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId LEFT OUTER JOIN
                      dbo.pStyleQuoteItemStatus ON dbo.pSourcingCommitmentItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[8] 2[29] 3) )"
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
         Begin Table = "pSourcingHeader"
            Begin Extent = 
               Top = 6
               Left = 302
               Bottom = 114
               Right = 523
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pSourcingStyle"
            Begin Extent = 
               Top = 6
               Left = 561
               Bottom = 114
               Right = 728
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pSourcingTradePartner"
            Begin Extent = 
               Top = 6
               Left = 766
               Bottom = 114
               Right = 962
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleHeader"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleBOMDimension"
            Begin Extent = 
               Top = 6
               Left = 1000
               Bottom = 114
               Right = 1185
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pWorkFlowItem"
            Begin Extent = 
               Top = 114
               Left = 277
               Bottom = 222
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleSeasonYear"
            Begin Extent = 
               Top = 114
               Left = 496
               Bottom = 222
               Ri' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_SourcingStyle_Commitment_Default_SELECT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ght = 685
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleCategory"
            Begin Extent = 
               Top = 114
               Left = 723
               Bottom = 222
               Right = 944
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pStyleQuoteItemStatus"
            Begin Extent = 
               Top = 114
               Left = 982
               Bottom = 222
               Right = 1193
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pSourcingCommitmentItem"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 101
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
         Width = 2445
         Width = 1965
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_SourcingStyle_Commitment_Default_SELECT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwx_SourcingStyle_Commitment_Default_SELECT'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04405', GetDate())
GO

