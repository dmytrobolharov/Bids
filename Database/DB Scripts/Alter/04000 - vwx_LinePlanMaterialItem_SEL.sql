IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanMaterialItem_SEL]'))
DROP VIEW [dbo].[vwx_LinePlanMaterialItem_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_LinePlanMaterialItem_SEL]
AS
SELECT     dbo.pMaterial.MaterialID, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.MaterialImageDetailID, 
                      dbo.pMaterial.MaterialImageDetailVersion, dbo.pMaterial.MaterialType, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.A, dbo.pMaterial.B, 
                      dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, dbo.pMaterial.K, 
                      dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, dbo.pMaterial.T, 
                      dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, dbo.pMaterial.Y, dbo.pMaterial.Z, dbo.pMaterial.MaterialPlacement, 
                      dbo.pLinePlanMaterialItem.LinePlanMaterialItemID, dbo.pLinePlanMaterialItem.LinePlanID, dbo.pLinePlanMaterialItem.LinePlanRangeID, 
                      dbo.pMaterial.CUser, dbo.pMaterial.CDate, dbo.pMaterial.MUser, dbo.pMaterial.MDate, dbo.pMaterial.MaterialCode, 
                      dbo.pMaterial.MaterialCodeNo
FROM         dbo.pMaterial INNER JOIN
                      dbo.pLinePlanMaterialItem ON dbo.pMaterial.MaterialID = dbo.pLinePlanMaterialItem.MaterialID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04000', GetDate())
GO
