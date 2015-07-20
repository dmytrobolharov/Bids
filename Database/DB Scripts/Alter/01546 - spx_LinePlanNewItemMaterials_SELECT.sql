IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanNewItemMaterials_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanNewItemMaterials_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanNewItemMaterials_SELECT](
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@LinePlanItemID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@AllowMaterialAllocation INT
)
AS

DECLARE 
	@LinePlanIndex INT,
	@LinePlanAttributeItemID1 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID3 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID4 UNIQUEIDENTIFIER,
	@LinePlanMaterialRangeID UNIQUEIDENTIFIER

SELECT @LinePlanIndex  = COUNT(*),
@LinePlanAttributeItemID1 = c.LinePlanAttributeItemID1,
@LinePlanAttributeItemID2 = c.LinePlanAttributeItemID2,
@LinePlanAttributeItemID3 = c.LinePlanAttributeItemID3,
@LinePlanAttributeItemID4 = c.LinePlanAttributeItemID4
FROM pLinePlanTemplateItem  a WITH(NOLOCK)
	INNER JOIN dbo.pLinePlan b WITH(NOLOCK) ON a.LinePlanTemplateID = b.LinePlanTemplateID
	INNER JOIN dbo.pLinePlanRange c WITH(NOLOCK) ON c.LinePlanID= b.LinePlanID
WHERE c.LinePlanRangeID  = @LinePlanRangeID
GROUP BY c.LinePlanAttributeItemID1, c.LinePlanAttributeItemID2,
c.LinePlanAttributeItemID3, c.LinePlanAttributeItemID4


-- Get Material => LInePlanRangeID
IF @LinePlanIndex = 4
	SELECT @LinePlanMaterialRangeID = LinePlanRangeID FROM pLinePlanRange WITH(NOLOCK)
	WHERE  LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'
ELSE 	
	SELECT @LinePlanMaterialRangeID = LinePlanRangeID FROM pLinePlanRange WITH(NOLOCK)
	WHERE  LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanAttributeItemID4 IS NULL 
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'


IF @AllowMaterialAllocation = 1 

	SELECT a.MaterialID, a.MaterialImageID, a.MaterialImageVersion, a.MaterialImageDetailID, 
		a.MaterialImageDetailVersion, c.ComponentDescription AS MaterialType, a.MaterialNo, a.MaterialName, a.A, 
		a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, 
		a.J, a.K, a.L, a.M, a.N, a.O, a.P, a.Q, 
		a.R, a.S, a.T, a.U, a.V, a.W, a.X, a.Y, 
		a.Z, a.MaterialPlacement, b.LinePlanMaterialItemID, b.LinePlanID, 
		b.LinePlanRangeID, b.CUser, b.CDate, b.MUser, 
		b.MDate, a.MaterialCode
	FROM dbo.pMaterial a WITH(NOLOCK) 
		INNER JOIN dbo.pLinePlanMaterialItem b WITH(NOLOCK) ON a.MaterialID = b.MaterialID
		INNER JOIN dbo.pComponentType c WITH(NOLOCK)  ON c.ComponentTypeID = a.MaterialType
	WHERE LinePlanRangeID = @LinePlanMaterialRangeID
	ORDER BY a.MaterialNo

ELSE
BEGIN
	
	SELECT a.MaterialID, a.MaterialImageID, a.MaterialImageVersion, a.MaterialImageDetailID, 
		a.MaterialImageDetailVersion,c.ComponentDescription AS MaterialType, a.MaterialNo, a.MaterialName, a.A, 
		a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, 
		a.J, a.K, a.L, a.M, a.N, a.O, a.P, a.Q, 
		a.R, a.S, a.T, a.U, a.V, a.W, a.X, a.Y, 
		a.Z, a.MaterialPlacement, a.MaterialCode,
		b.LinePlanRangeID, b.CUser, b.CDate, b.MUser, 
		b.MDate, b.LinePlanMaterialItemID, b.LinePlanID
	FROM dbo.pMaterial a WITH (NOLOCK)
		INNER JOIN pLinePlanMaterialItemTemp b WITH (NOLOCK) ON a.MaterialID = b.MaterialID
		INNER JOIN dbo.pComponentType c WITH(NOLOCK)  ON c.ComponentTypeID = a.MaterialType
	WHERE b.LinePlanColorGroupID = @LinePlanItemID
		AND b.LinePlanRangeID = @LinePlanRangeID 
		AND b.TeamID = @TeamID
	ORDER BY a.MaterialNo
	
	
END 




GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01546'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01546', GetDate())
END	

GO







