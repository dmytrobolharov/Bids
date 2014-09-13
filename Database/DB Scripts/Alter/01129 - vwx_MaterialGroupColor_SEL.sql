IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialGroupColor_SEL]'))
DROP VIEW [dbo].[vwx_MaterialGroupColor_SEL]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialGroupColor_SEL]
AS

SELECT a.MaterialCoreColorID, 
       a.MaterialCoreID, 
       '<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(b.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(b.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, 
       b.ColorCode, 
       b.ColorName

FROM dbo.pMaterialCoreColor AS a INNER JOIN
     dbo.pColorPalette AS b ON a.ColorPaletteID = b.ColorPaletteID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01129', GetDate())
GO
