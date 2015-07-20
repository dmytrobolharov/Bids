IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanRangeMaterialsUsed_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanRangeMaterialsUsed_SELECT]
GO

CREATE PROCEDURE  dbo.spx_LinePlanRangeMaterialsUsed_SELECT(
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
)
AS 


-- Get Material - LineplanRangeID
DECLARE 
	@LinePlanIndex INT,
	@LinePlanMaterialRangeID UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID1 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID3 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID4 UNIQUEIDENTIFIER

SELECT 
	@LinePlanIndex = COUNT(*),
	@LinePlanAttributeItemID1 = a.LinePlanAttributeItemID1, 
	@LinePlanAttributeItemID2 = a.LinePlanAttributeItemID2,
	@LinePlanAttributeItemID3 = a.LinePlanAttributeItemID3, 
	@LinePlanAttributeItemID4 = a.LinePlanAttributeItemID4
FROM pLinePlanRange a WITH(NOLOCK) 
	INNER JOIN dbo.pLinePlan b WITH(NOLOCK)  ON a.LinePlanID =  b.LinePlanID 
	INNER JOIN dbo.pLinePlanTemplateItem c WITH(NOLOCK)  ON b.LinePlanTemplateID = c.LinePlanTemplateID
WHERE a.LinePlanRangeID = @LinePlanRangeID 	
GROUP BY  a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2, 
	a.LinePlanAttributeItemID3, a.LinePlanAttributeItemID4

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



SELECT a.MaterialID, b.MaterialCode , b.MaterialName, b.MaterialNo,  b.A, c.ComponentDescription AS MaterialType
FROM dbo.pLinePlanMaterialItem a WITH(NOLOCK)
	INNER JOIN dbo.pMaterial b WITH(NOLOCK)  ON a.MaterialID = b.MaterialID
	INNER JOIN dbo.pComponentType  c WITH(NOLOCK) ON c.ComponentTypeID = b.MaterialType
WHERE a.LinePlanRangeID  = @LinePlanMaterialRangeID





GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01611'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01611', GetDate())
END	

GO
