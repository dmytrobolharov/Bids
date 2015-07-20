IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialListHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialListHistory_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialListHistory_SELECT]
(
 @TeamID UNIQUEIDENTIFIER,
 @MaterialFolderType INT
)
AS
BEGIN
SELECT pMaterial.MaterialID, pMaterial.MaterialNo, pMaterial.MaterialName, pMaterialHistory.TeamID
                                    FROM pMaterial INNER JOIN  pMaterialHistory ON pMaterial.MaterialID = pMaterialHistory.MaterialID
                                    WHERE (pMaterialHistory.TeamID = @TeamID)
                                    AND pMaterial.MaterialType IN (SELECT ProductTypeId FROM fnx_Permissions_GetIntProductTypePermissions(@TeamID, @MaterialFolderType) WHERE PermissionRoleId <> 0 ) 
                                    ORDER BY pMaterialHistory.CDate DESC

END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07948', GetDate())
GO
