IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanAttribute_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanAttribute_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_LinePlanAttribute_DELETE]
(@LinePlanId nvarchar(50),
@LinePlanTemplateItemId nvarchar(50),
@CustomKey nvarchar(50))
AS 



/*
IF  (SELECT COUNT(*) FROM pLinePlanAttributeItem WHERE LinePlanAttributeID IN ( 
	SELECT LinePlanAttributeId FROM pLinePlanAttribute 
	WHERE LinePlanID = @LinePlanID 
	AND	LinePlanTemplateItemId = @LinePlanTemplateItemId 
	AND	LinePlanAttributeValue = @CustomKey ) ) = 0
*/

IF  (SELECT COUNT(*) FROM pLinePlanAttributeItem WHERE LinePlanAttributeItemParentID = (
	SELECT LinePlanAttributeItemID FROM pLinePlanAttributeItem
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




IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03136'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03136', GetDate())
END
GO