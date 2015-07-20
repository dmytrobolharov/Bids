IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorType_Desc_SEL]') AND type = N'V')
DROP VIEW [dbo].[vwx_ColorType_Desc_SEL]
GO

CREATE VIEW [dbo].[vwx_ColorType_Desc_SEL]
AS
SELECT     a.ColorFolderID, a.ColorFolderDescription, a.ColorSubFolder1, a.ColorSubFolder2, a.ColorSubFolder3, a.ColorSubFolder4, a.ColorSubFolder5, a.ColorSubFolder6, 
                      a.ColorSubFolder7, a.ColorSubFolder8, a.ColorSubFolder9, a.CUser, a.CDate, a.MUser, a.MDate, a.MChange, a.Active, a.StyleColorway, a.SystemServerStorageID, 
                      a.ColorTypeID, a.ColorTypeSort, b.ColorTypeDescription,
                          (SELECT     COUNT(*) AS Colors
                            FROM          dbo.pColorPalette
                            WHERE      (ColorFolderID = a.ColorFolderID)) AS ColorCount, '' AS SeasonYearID
FROM         dbo.pColorFolder AS a INNER JOIN
                      dbo.pColorType AS b ON a.ColorTypeID = b.ColorTypeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09115', GetDate())
GO
