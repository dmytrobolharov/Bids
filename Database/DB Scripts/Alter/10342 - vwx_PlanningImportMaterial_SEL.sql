IF OBJECT_ID(N'[dbo].[vwx_PlanningImportMaterial_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_PlanningImportMaterial_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningImportMaterial_SEL]
AS
SELECT TOP 100 PERCENT
	pssiy.PlanningID
	, pssy.SeasonYearID
	, pssiy.SeasonYearID AS ImportSeasonYearID
	, pmi.PlanningMaterialID
	, pmi.CUser
	, pmi.CDate
	, pmi.MUser
	, pmi.MDate
	, pmi.PlanningMaterialDrop
	, m.MaterialID
	, m.MaterialType
	, m.MaterialNo
	, m.MaterialName
	, m.MaterialCode
	, m.MultiDimension
	, m.Notes
	, m.B
	, m.MaterialImageID
	, m.MaterialImageVersion
	, m.Active
	, dbo.fnx_GetStreamingImagePath(m.MaterialImageID, m.MaterialImageVersion, 25) AS MaterialImageUrl
	, dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 25, '') AS MaterialImagePath
	, ct.ComponentDescription
FROM pPlanningSeasonYear pssy
	INNER JOIN pPlanningSeasonYear pssiy ON pssiy.PlanningID = pssy.PlanningID AND pssy.SeasonYearID <> pssiy.SeasonYearID
	INNER JOIN pPlanningMaterial pmi ON pssiy.PlanningID = pmi.PlanningID AND pssiy.SeasonYearID = pmi.SeasonYearID
	LEFT JOIN pPlanningMaterial pm ON pmi.PlanningID = pm.PlanningID AND pssy.SeasonYearID = pm.SeasonYearID AND pmi.MaterialID = pm.MaterialID	
	LEFT JOIN pMaterial m
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
	ON pmi.MaterialID = m.MaterialID
WHERE pm.MaterialID IS NULL	
ORDER BY ct.ComponentOrder, m.MaterialNo


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10342', GetUTCDate())
GO
