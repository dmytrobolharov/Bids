IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanAttribute_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanAttribute_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanAttribute_DELETE]
(@LinePlanId nvarchar(50),
@LinePlanTemplateItemId nvarchar(50),
@CustomKey nvarchar(50))
AS 




IF  (SELECT COUNT(*) FROM pLinePlanAttributeItem WHERE LinePlanAttributeID IN ( 
	SELECT LinePlanAttributeId FROM pLinePlanAttribute 
	WHERE LinePlanID = @LinePlanID 
	AND	LinePlanTemplateItemId = @LinePlanTemplateItemId 
	AND	LinePlanAttributeValue = @CustomKey ) ) = 0
BEGIN

	--***
	--** Attribute not used in the hierarchy => delete it 
	--***
	DELETE FROM pLinePlanAttribute 
	WHERE LinePlanID = @LinePlanID 
	AND	LinePlanTemplateItemId = @LinePlanTemplateItemId 
	AND	LinePlanAttributeValue = @CustomKey

END 

	
--***
--** REMOVE orphaned records 
--***
DELETE FROM  pLinePlanAttributeItem  	
WHERE LinePlanId = @LinePlanId 
AND  LinePlanAttributeID NOT IN (
	SELECT LinePlanAttributeID FROM pLinePlanAttribute 
	WHERE LinePlanID = @LinePlanID 
)



/*
DELETE FROM  pLinePlanAttributeItem  
WHERE  LinePlanAttributeItemID IN (
	SELECT LinePlanAttributeItemID
	FROM  pLinePlanAttributeItem 
	WHERE LinePlanID = @LinePlanID
	AND LinePlanAttributeValue = @CustomKey
	AND LinePlanAttributeItemParentID = '00000000-0000-0000-0000-000000000000'
)
*/

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '066', GetDate())

GO

