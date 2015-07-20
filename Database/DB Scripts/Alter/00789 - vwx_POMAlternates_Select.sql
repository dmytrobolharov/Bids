
/****** Object:  View [dbo].[vwx_POMAlternates_Select]    Script Date: 11/30/2010 17:03:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOM' and COLUMN_NAME = N'ImageId')
       BEGIN 
            ALTER TABLE pGRPOM ADD ImageId UniqueIdentifier Null
       END
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_POMAlternates_Select')
DROP VIEW vwx_POMAlternates_Select
GO

CREATE VIEW [dbo].[vwx_POMAlternates_Select]
AS
SELECT     TOP (100) PERCENT dbo.pGRPOM.POMGuidId, dbo.pGRPOM.RefCode, dbo.pGRAlternates.AlternatesCode, dbo.pGRPOM.POMDesc, dbo.pGRPOM.How2MeasText, 
                      dbo.pGRPOM.SortField AS Sort, dbo.pGRPOM.Muser, dbo.pGRPOM.MDate, dbo.pGRAlternates.AlternatesGuidId, dbo.pGRAlternates.AlternatesDesc, 
                      dbo.pGRPOMAlternates.POMAlternatesId, dbo.pGRCompany.Company, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(dbo.pGRPOM.ImageId, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS POMImage
FROM         dbo.pGRPOM INNER JOIN
                      dbo.pGRPOMAlternates ON dbo.pGRPOM.POMGuidId = dbo.pGRPOMAlternates.POMGuidId INNER JOIN
                      dbo.pGRAlternates ON dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId LEFT OUTER JOIN
                      dbo.pGRCompany ON dbo.pGRPOM.CompanyGuidId = dbo.pGRCompany.CompanyGuidID
ORDER BY Sort, dbo.pGRPOM.RefCode, dbo.pGRAlternates.AlternatesCode

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[3] 2[41] 3) )"
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
         Begin Table = "pGRPOM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pGRPOMAlternates"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 125
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pGRAlternates"
            Begin Extent = 
               Top = 6
               Left = 470
               Bottom = 125
               Right = 640
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pGRCompany"
            Begin Extent = 
               Top = 6
               Left = 678
               Bottom = 125
               Right = 844
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
      Begin ColumnWidths = 14
         Width = 284
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
         SortOrder =' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'vwx_POMAlternates_Select'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'vwx_POMAlternates_Select'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'vwx_POMAlternates_Select'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '789', GetDate())
GO

