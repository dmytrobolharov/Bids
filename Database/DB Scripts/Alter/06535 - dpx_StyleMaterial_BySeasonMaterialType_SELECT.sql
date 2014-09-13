IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleMaterial_BySeasonMaterialType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleMaterial_BySeasonMaterialType_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleMaterial_BySeasonMaterialType_SELECT] (
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @MaterialTypeID INT = NULL
	)
AS
IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

SELECT COUNT(*) AS StyleCount, dbo.pStyleType.StyleTypeDescription
FROM (SELECT MaterialID, StyleID, MaterialType FROM dbo.pStyleMaterials UNION SELECT MaterialID, StyleID, MaterialType FROM dbo.pStyleBOM) AS mat
	INNER JOIN dbo.pMaterialSeasonYear ON mat.MaterialID = dbo.pMaterialSeasonYear.MaterialID
	INNER JOIN dbo.pStyleHeader ON mat.StyleID = dbo.pStyleHeader.StyleID
	INNER JOIN dbo.pStyleType ON dbo.pStyleHeader.StyleType = dbo.pStyleType.StyleTypeID
WHERE dbo.pMaterialSeasonYear.SeasonYearID = @SeasonYearID AND mat.MaterialType = @MaterialTypeID
GROUP BY dbo.pStyleType.StyleTypeDescription

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06535', GetDate())
GO
