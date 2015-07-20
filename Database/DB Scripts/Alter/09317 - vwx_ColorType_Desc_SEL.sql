/****** Object:  View [dbo].[vwx_ColorType_Desc_SEL]    Script Date: 1/30/2015 3:44:43 PM ******/
DROP VIEW [dbo].[vwx_ColorType_Desc_SEL]
GO

CREATE VIEW [dbo].[vwx_ColorType_Desc_SEL]
AS

WITH ColorCounts AS (
	SELECT ColorFolderID, COUNT(*) AS ColorCount
	FROM pColorPalette cp
	GROUP BY ColorFolderID)
SELECT cf.ColorFolderID
	, cf.ColorFolderDescription
	, cf.ColorFolderDescription + ' <b>(' + CAST(ISNULL(cc.ColorCount, 0) AS NVARCHAR(10)) + ')</b>' AS ColorFolderDescriptionWithCount
	, cf.ColorSubFolder1
	, cf.ColorSubFolder2
	, cf.ColorSubFolder3
	, cf.ColorSubFolder4
	, cf.ColorSubFolder5
	, cf.ColorSubFolder6
	, cf.ColorSubFolder7
	, cf.ColorSubFolder8
	, cf.ColorSubFolder9
	, cf.CUser
	, cf.CDate
	, cf.MUser
	, cf.MDate
	, cf.MChange
	, cf.Active
	, cf.StyleColorway
	, cf.SystemServerStorageID
	, cf.ColorTypeID
	, cf.ColorTypeSort
	, ct.ColorTypeDescription
	, ISNULL(cc.ColorCount, 0) AS ColorCount
	, '' AS SeasonYearID
FROM dbo.pColorFolder cf
LEFT JOIN ColorCounts cc ON cf.ColorFolderID = cc.ColorFolderID
INNER JOIN dbo.pColorType ct ON cf.ColorTypeID = ct.ColorTypeID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09317', GetDate())
GO
