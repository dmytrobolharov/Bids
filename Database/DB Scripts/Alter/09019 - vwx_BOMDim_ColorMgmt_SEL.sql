IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BOMDim_ColorMgmt_SEL]'))
DROP VIEW [dbo].[vwx_BOMDim_ColorMgmt_SEL]
GO

CREATE VIEW [dbo].[vwx_BOMDim_ColorMgmt_SEL]
AS
SELECT     stylematerialId AS styleMaterialPKId, stylematerialId, materialId, materialno, materialname, '00000000-0000-0000-0000-000000000000' AS StyleMaterialMiscID, 
                      0 AS SubMaterial, Placement, Colorway, AUTOCOLOR, StyleBOMDimensionId, WorkflowId, WorkflowItemId, ComponentOrder, MaterialSort, MainMaterial,MaterialImageID
FROM         pStyleBOM INNER JOIN
                      pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
UNION
SELECT     p.StyleMaterialMiscID AS styleMaterialPKId, b.stylematerialId, b.materialId, p.materialno, p.materialname, p.StyleMaterialMiscID, 1 AS SubMaterial, b.Placement, 
                      b.Colorway, b.AutoColor, b.StyleBOMDimensionId, b.WorkflowId, b.WorkflowItemId, ComponentOrder, MaterialSort, MainMaterial,b.MaterialImageID
FROM         pStyleBOM b INNER JOIN
                      pStyleBOMMiscItem p ON b.stylematerialId = p.stylematerialId AND b.StyleBOMDimensionId = p.StyleBOMDimensionId INNER JOIN
                      pComponentType ON b.MaterialType = pComponentType.ComponentTypeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09019', GetDate())
GO
