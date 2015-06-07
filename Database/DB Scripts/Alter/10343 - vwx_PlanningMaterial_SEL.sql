IF OBJECT_ID(N'[dbo].[vwx_PlanningMaterial_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_PlanningMaterial_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningMaterial_SEL]
AS
SELECT TOP (100) PERCENT pm.PlanningMaterialID, pm.PlanningID, pm.CUser, pm.CDate, pm.MUser, pm.MDate, pm.MaterialID, 
       pm.Sort, m.MaterialType, ct.ComponentDescription AS MaterialTypeName, m.MaterialNo AS MaterialNumber, 
	   '<a custom="' + m.MaterialNo + '" href=''../Material/Material_Frame.aspx?MTID=' + CAST(m.MaterialID AS NVARCHAR(50)) + 
	   ''' target=''_blank''>' + m.MaterialNo + '</a>' AS MaterialNo, 
	   m.MaterialCode, m.MultiDimension, m.Notes, m.B, m.MaterialImageID, m.MaterialImageVersion, m.Active, 
	   pm.PlanningMaterialDrop, pm.PlanningMaterialDropUser, pm.PlanningMaterialDropDate, 
	   dbo.fnx_GetStreamingImagePath(m.MaterialImageID, m.MaterialImageVersion, 25) AS MaterialImageUrl, 
	   dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 25, '') AS MaterialImagePath, 
	   pm.SeasonYearID, ct.ComponentDescription AS Expr1, a.Custom AS ActiveLabel, m.DueDate,
       (SELECT COUNT(*) AS Expr1
        FROM dbo.pPlanningItem AS pli 
		INNER JOIN dbo.pStyleBOM AS sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId 
		INNER JOIN dbo.pStyleSeasonYear AS ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID 
		INNER JOIN dbo.pPlanningMaterial AS pm ON pli.PlanningID = pm.PlanningID AND ssy.SeasonYearID = pm.SeasonYearID AND sb.MaterialID = pm.MaterialID
        WHERE (pm.PlanningMaterialID = pm.PlanningMaterialID) AND (pli.PlanningItemDrop = 'No')) AS MaterialUsedInBOMCount, 
		m.MaterialName, m.A, m.C, m.D, m.F, m.E, m.G, m.H, m.I, m.K, m.J, m.L, m.M, m.N, m.O, m.P, m.Q, m.R, m.S, m.T, m.V, 
		m.U, m.W, m.X, m.Y, m.Z, m.VendorPrice, m.VendorProductionMin, m.VendorProductionLeadTime, m.UOM, m.VolumePrice
FROM dbo.pPlanningMaterial pm 
INNER JOIN dbo.pMaterial m ON pm.MaterialID = m.MaterialID 
INNER JOIN dbo.pComponentType ct ON m.MaterialType = ct.ComponentTypeID 
LEFT OUTER JOIN dbo.pActive a ON m.Active = a.CustomKey
ORDER BY pm.Sort, ct.ComponentOrder, MaterialNo


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10343', GetUTCDate())
GO
