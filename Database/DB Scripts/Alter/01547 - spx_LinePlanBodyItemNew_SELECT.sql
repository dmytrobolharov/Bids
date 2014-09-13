IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanBodyItemNew_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanBodyItemNew_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanBodyItemNew_SELECT](
	@LinePlanRangeID UNIQUEIDENTIFIER
)
AS

DECLARE @LinePlanBodyRangeID  UNIQUEIDENTIFIER 
DECLARE @LPIndex INT

SELECT @LPIndex = COUNT(*) 
FROM dbo.pLinePlanRange a WITH(NOLOCK)
	INNER JOIN dbo.pLinePlan b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID 
	INNER JOIN dbo.pLinePlanTemplateItem c WITH(NOLOCK)  ON b.LinePlanTemplateID = b.LinePlanTemplateID
WHERE a.LinePlanRangeID = @LinePlanRangeID 


IF @LPIndex = 3 
	SELECT @LinePlanBodyRangeID = b.LinePlanRangeID 
	FROM dbo.pLinePlanRange a WITH(NOLOCK)
		INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON 
			a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 
		AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2
		AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
	WHERE a.LinePlanRangeID = @LinePlanRangeID
		AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000003' 
ELSE 
	SELECT @LinePlanBodyRangeID = b.LinePlanRangeID 
	FROM dbo.pLinePlanRange a WITH(NOLOCK)
		INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON 
			a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 
		AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2
		AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
		AND a.LinePlanAttributeItemID4 = b.LinePlanAttributeItemID4 
	WHERE a.LinePlanRangeID = @LinePlanRangeID
		AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000003' 


SELECT b.BodyID,  a.LinePlanBodyItemID,b.BodyNo, b.Description, b.CDate, b.MUser, b.MDate 
FROM pLinePlanBodyItem a WITH(NOLOCK)
	INNER JOIN dbo.pBody  b WITH(NOLOCK) ON a.BodyID = b.BodyID
WHERE LinePlanRangeID = @LinePlanBodyRangeID


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01547'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01547', GetDate())
END	

GO



