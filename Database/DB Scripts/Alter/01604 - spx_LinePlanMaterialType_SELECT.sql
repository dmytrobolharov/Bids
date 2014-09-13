IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMaterialType_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMaterialType_SELECT]
GO

CREATE PROCEDURE dbo.spx_LinePlanMaterialType_SELECT(
	@TeamID UNIQUEIDENTIFIER
)
AS 


    SELECT DISTINCT a.ComponentTypeID, a.ComponentDescription, a.ComponentOrder
    FROM dbo.pComponentType a WITH(NOLOCK) 
		INNER JOIN dbo.sAccessMaterialFolder b WITH(NOLOCK) ON a.ComponentTypeID = b.ComponentTypeId
			AND b.AccessRoleId <> 0 AND b.TeamId = @TeamID
	WHERE a.ComponentTypeID IN (10,11,42,40,13) 
	ORDER BY a.ComponentOrder


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01604'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01604', GetDate())
END	

GO
