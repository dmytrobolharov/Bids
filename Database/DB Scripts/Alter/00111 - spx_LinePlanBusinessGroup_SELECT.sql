IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanBusinessGroup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanBusinessGroup_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_LinePlanBusinessGroup_SELECT]
(
@LinePlanId varchar(40),
@LinePlanIndex varchar(1),
@LinePlanAttributeItemId varchar(40)
)
AS 

DECLARE @LineRollup INT
DECLARE @LineHIndex INT 

SELECT @LineHIndex  = COUNT(*) FROM pLinePlanTemplateItem a 
INNER JOIN pLinePlan b ON a.LinePlanTemplateID = b.LinePlanTemplateID 
WHERE b.LinePlanID = @LinePlanId  AND a.Active =  1


IF @LinePlanIndex = @LineHIndex
BEGIN
	SET @LineRollup = 0
END
ELSE
BEGIN
	SET @LineRollup = 1
END



IF @LinePlanIndex = '1'
BEGIN
	SELECT LinePlanAttributeItemID1, '' AS LinePlanAttributeItemID2, '' AS LinePlanAttributeItemID3, '' AS LinePlanAttributeItemID4,
	LinePlanAttributeText1,
	@LineRollup AS LinePlanRollup
	FROM  pLinePlanBusiness WITH(NOLOCK)
	WHERE LinePlanID = @LinePlanId
	AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID
	GROUP BY LinePlanAttributeItemID1, 
	LinePlanAttributeText1,
	LinePlanAttributeItemSort1
	ORDER BY LinePlanAttributeItemSort1
END
ELSE IF @LinePlanIndex = '2'
BEGIN 
	SELECT LinePlanAttributeItemID1, LinePlanAttributeItemID2, '' AS LinePlanAttributeItemID3, '' AS LinePlanAttributeItemID4, 
	LinePlanAttributeText1, LinePlanAttributeText2, 
	@LineRollup AS LinePlanRollup
	FROM  pLinePlanBusiness WITH(NOLOCK)
	WHERE LinePlanID = @LinePlanId AND 
	LinePlanAttributeItemID2 = @LinePlanAttributeItemID
	GROUP BY LinePlanAttributeItemID1, LinePlanAttributeItemID2, 
	LinePlanAttributeText1, LinePlanAttributeText2, 
	LinePlanAttributeItemSort1, LinePlanAttributeItemSort2
	ORDER BY LinePlanAttributeItemSort1, LinePlanAttributeItemSort2
END
ELSE IF @LinePlanIndex = '3'
BEGIN 
	SELECT LinePlanAttributeItemID1, LinePlanAttributeItemID2, LinePlanAttributeItemID3,'' AS LinePlanAttributeItemID4, 
	LinePlanAttributeText1, LinePlanAttributeText2, LinePlanAttributeText3, 
	@LineRollup AS LinePlanRollup
	FROM  pLinePlanBusiness WITH(NOLOCK)
	WHERE LinePlanID = @LinePlanId AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID
	GROUP BY LinePlanAttributeItemID1, LinePlanAttributeItemID2, LinePlanAttributeItemID3,
	LinePlanAttributeText1, LinePlanAttributeText2, LinePlanAttributeText3, 
	LinePlanAttributeItemSort1, LinePlanAttributeItemSort2, LinePlanAttributeItemSort3
	ORDER BY LinePlanAttributeItemSort1, LinePlanAttributeItemSort2, LinePlanAttributeItemSort3
	
END
ELSE IF @LinePlanIndex = '4'
BEGIN 
	SELECT LinePlanAttributeItemID1, LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanAttributeItemID4,
	LinePlanAttributeText1, LinePlanAttributeText2, LinePlanAttributeText3, LinePlanAttributeText4,
	@LineRollup AS LinePlanRollup
	FROM  pLinePlanBusiness WITH(NOLOCK)
	WHERE LinePlanID = @LinePlanId AND LinePlanAttributeItemID4 = @LinePlanAttributeItemID
	GROUP BY LinePlanAttributeItemID1, LinePlanAttributeItemID2, LinePlanAttributeItemID3,LinePlanAttributeItemID4,
	LinePlanAttributeText1, LinePlanAttributeText2, LinePlanAttributeText3, LinePlanAttributeText4,
	LinePlanAttributeItemSort1, LinePlanAttributeItemSort2, LinePlanAttributeItemSort3, LinePlanAttributeItemSort4
	ORDER BY LinePlanAttributeItemSort1, LinePlanAttributeItemSort2, LinePlanAttributeItemSort3, LinePlanAttributeItemSort4
END



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '111', GetDate())

GO


