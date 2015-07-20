IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanBreadCrumb_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanBreadCrumb_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanBreadCrumb_SELECT] (
@LinePlanAttributeItemID UNIQUEIDENTIFIER,
@LinePlanIndex INT
)
AS
BEGIN

	DECLARE @LineRollup INT
	DECLARE @LineHIndex INT
	DECLARE @LinePlanTemplateID UNIQUEIDENTIFIER 
	
	SELECT @LinePlanTemplateID  = b.LinePlanTemplateID
	FROM pLinePlanAttributeItem a
	INNER JOIN pLinePlan b ON a.LinePlanId = b.LinePlanID 
	WHERE a.LinePlanAttributeItemID = @LinePlanAttributeItemID
	
	SELECT @LineHIndex = COUNT(*) FROM pLinePlanTemplateItem  WHERE LinePlanTemplateID = @LinePlanTemplateID
	

	IF @LinePlanIndex = @LineHIndex
		SET @LineRollup = 0
	ELSE
		SET @LineRollup = 1


	SELECT LinePlanID, LinePlanAttributeItemParentID, LinePlanAttributeID , @LineRollup AS Rollup  
	FROM pLinePlanAttributeItem where LinePlanAttributeItemID = @LinePlanAttributeItemID  


END 



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '109', GetDate())

GO

