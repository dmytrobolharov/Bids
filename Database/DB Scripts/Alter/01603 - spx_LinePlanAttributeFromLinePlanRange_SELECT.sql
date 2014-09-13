IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanAttributeFromLinePlanRange_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanAttributeFromLinePlanRange_SELECT]
GO

CREATE PROCEDURE dbo.spx_LinePlanAttributeFromLinePlanRange_SELECT(
	@LinePlanRangeID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@LinePlanIndex INT,
	@LinePlanID UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID1 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID3 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID4 UNIQUEIDENTIFIER


SELECT @LinePlanIndex = COUNT(*), @LinePlanID = a.LinePlanID, 
	@LinePlanAttributeItemID1 = a.LinePlanAttributeItemID1, @LinePlanAttributeItemID2 = a.LinePlanAttributeItemID2,
	@LinePlanAttributeItemID3 = a.LinePlanAttributeItemID3, @LinePlanAttributeItemID4 = a.LinePlanAttributeItemID4
FROM dbo.pLinePlanRange a WITH(NOLOCK)
	INNER JOIN dbo.pLinePlan b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID 
	INNER JOIN dbo.pLinePlanTemplateItem c WITH(NOLOCK) ON c.LinePlanTemplateID = b.LinePlanTemplateID
WHERE a.LinePlanRangeID = @LinePlanRangeID
GROUP BY a.LinePlanID, a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2,
a.LinePlanAttributeItemID3, a.LinePlanAttributeItemID4


IF @LinePlanIndex = 3 
	SELECT @LinePlanIndex AS LinePlanIndex, LinePlanAttributeItemID, LinePlanAttributeItemParentID, LinePlanAttributeID
	FROM dbo.pLinePlanAttributeItem WITH(NOLOCK)
	WHERE LinePlanAttributeItemID = @LinePlanAttributeItemID3
ELSE 
	SELECT @LinePlanIndex AS LinePlanIndex, LinePlanAttributeItemID, LinePlanAttributeItemParentID, LinePlanAttributeID
	FROM dbo.pLinePlanAttributeItem WITH(NOLOCK)
	WHERE LinePlanAttributeItemID = @LinePlanAttributeItemID4

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01603'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01603', GetDate())
END	

GO
