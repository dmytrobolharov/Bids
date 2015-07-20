IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningColor_SEL]'))
DROP VIEW [dbo].[vwx_PlanningColor_SEL]
GO


CREATE VIEW [dbo].[vwx_PlanningColor_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pPlanningColor.PlanningColorID, dbo.pPlanningColor.PlanningID, dbo.pPlanningColor.CUser, dbo.pPlanningColor.CDate, 
                      dbo.pPlanningColor.MUser, dbo.pPlanningColor.MDate, dbo.pColorPalette.ColorPaletteID, dbo.pColorPalette.ColorFolderID, 
                      dbo.pColorPalette.ColorCode, dbo.pColorPalette.ColorName, dbo.pColorPalette.ColorSource, dbo.pColorPalette.ColorNotes, dbo.pColorPalette.Hex, 
                      dbo.pColorPalette.ColorImage, dbo.pColorPalette.ColorImageType, dbo.pColorPalette.CopyColorPaletteID, dbo.pColorPalette.Active, 
                      dbo.pColorPalette.Sort, dbo.pColorFolder.ColorTypeID, 
                      '../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pPlanningColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&CPID=' + CAST(ISNULL(dbo.pPlanningColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImageUrl,
                      '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(dbo.pPlanningColor.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&CPID=' + CAST(ISNULL(dbo.pPlanningColor.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath
FROM         dbo.pColorPalette INNER JOIN
                      dbo.pPlanningColor ON dbo.pColorPalette.ColorPaletteID = dbo.pPlanningColor.ColorPaletteID INNER JOIN
                      dbo.pColorFolder ON dbo.pColorPalette.ColorFolderID = dbo.pColorFolder.ColorFolderID
ORDER BY dbo.pColorPalette.ColorName
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06334', GetDate())
GO
