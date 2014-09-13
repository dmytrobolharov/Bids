/****** Object:  View [dbo].[vwx_PlanningImportMaterial_SEL]    Script Date: 06/10/2014 22:10:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


ALTER VIEW [dbo].[vwx_PlanningImportMaterial_SEL]
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
	, '../System/Control/ImageStream.ashx?S=25&IID=' + CAST(ISNULL(m.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&V=' + CAST(ISNULL(m.MaterialImageVersion, '0') AS NVARCHAR(50)) AS MaterialImageUrl
	, '<img src=''../System/Control/ImageStream.ashx?S=25&IID=' + CAST(ISNULL(m.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&V=' + CAST(ISNULL(m.MaterialImageVersion, '0') AS NVARCHAR(50)) + '''  />' AS MaterialImagePath
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
VALUES ('DB_Version', '0.5.0000', '08002', GetDate())
GO