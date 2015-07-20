IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningMaterial_SEL]'))
DROP VIEW [dbo].[vwx_PlanningMaterial_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningMaterial_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pPlanningMaterial.PlanningMaterialID, dbo.pPlanningMaterial.PlanningID, dbo.pPlanningMaterial.CUser, dbo.pPlanningMaterial.CDate, 
                      dbo.pPlanningMaterial.MUser, dbo.pPlanningMaterial.MDate, dbo.pPlanningMaterial.MaterialID, dbo.pMaterial.MaterialType, 
                      dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.MaterialCode, dbo.pMaterial.MultiDimension, dbo.pMaterial.Notes, dbo.pMaterial.B,
                      dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.Active, 
                      dbo.pPlanningMaterial.PlanningMaterialDrop, dbo.pPlanningMaterial.PlanningMaterialDropUser, dbo.pPlanningMaterial.PlanningMaterialDropDate,
                      '../System/Control/ImageStream.ashx?S=25&IID=' + CAST(ISNULL(dbo.pMaterial.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&V=' + CAST(ISNULL(dbo.pMaterial.MaterialImageVersion, '0') AS NVARCHAR(50)) AS MaterialImageUrl,
                      '<img src=''../System/Control/ImageStream.ashx?S=25&IID=' + CAST(ISNULL(dbo.pMaterial.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&V=' + CAST(ISNULL(dbo.pMaterial.MaterialImageVersion, '0') AS NVARCHAR(50)) + '''  />' AS MaterialImagePath,
                      dbo.pPlanningMaterial.SeasonYearID, dbo.pComponentType.ComponentDescription, pActive.Custom AS ActiveLabel, pMaterial.DueDate
FROM dbo.pPlanningMaterial
	INNER JOIN dbo.pMaterial ON dbo.pPlanningMaterial.MaterialID = dbo.pMaterial.MaterialID
	INNER JOIN dbo.pComponentType ON dbo.pMaterial.MaterialType = dbo.pComponentType.ComponentTypeID
	LEFT JOIN pActive ON pMaterial.Active = pActive.CustomKey
 
ORDER BY dbo.pComponentType.ComponentOrder, dbo.pMaterial.MaterialNo


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07705', GetDate())
GO
