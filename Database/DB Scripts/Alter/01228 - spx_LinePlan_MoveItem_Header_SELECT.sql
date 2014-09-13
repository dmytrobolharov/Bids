IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_MoveItem_Header_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_MoveItem_Header_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlan_MoveItem_Header_SELECT] (
@StyleID UNIQUEIDENTIFIER, 
@ActionID INT 
)
as 

DECLARE 
	@LinePlanItemID UNIQUEIDENTIFIER,
	@LPIndex INT 


SELECT TOP 1 @LinePlanItemID = LinePlanItemID  FROM pStyleSeasonyear a WITH(NOLOCK)
WHERE a.StyleID = @StyleID 


SELECT @LPIndex = COUNT(*) 
FROM dbo.pLinePlanItem a WITH(NOLOCK)
	INNER JOIN pLIneplan b WITH(NOLOCK) ON a.LineplanID = b.LinePlanID 
	INNER JOIN dbo.pLinePlanTemplateItem c WITH(NOLOCK) ON c.LinePlanTemplateID =  b.LinePlanTemplateID
WHERE a.LinePlanItemID  =  @LinePlanItemID


IF @LPIndex = 3 
BEGIN 

	IF  @ActionID  = 1 
		SELECT 'Lineplan: '  + c.Description + ' (' + b.LinePlanAttributeText1 + ' / ' + LinePlanAttributeText2 + ' / ' + LinePlanAttributeText3 + ')' 
		as Description 
		FROM pLinePlanItem a WITH(NOLOCK)
		INNER JOIN pLinePlanRange b WITH(NOLOCK) ON a.LinePlanRangeID =  b.LinePlanRangeID
		INNER JOIN pLinePlan c WITH(NOLOCK) ON c.LinePlanID = a.LinePlanID 
		WHERE a.LinePlanItemID = @LinePlanItemID 
	ELSE 
		SELECT b.LinePlanAttributeText1 + ' / ' + LinePlanAttributeText2 + ' / ' + LinePlanAttributeText3 
		FROM pLinePlanItem a WITH(NOLOCK)
		INNER JOIN pLinePlanRange b WITH(NOLOCK) ON a.LinePlanRangeID =  b.LinePlanRangeID
		INNER JOIN pLinePlan c WITH(NOLOCK) ON c.LinePlanID = a.LinePlanID 
		WHERE a.LinePlanItemID = @LinePlanItemID 

END 
ELSE 
BEGIN 

	IF  @ActionID  = 1 
		SELECT 'Lineplan: '  + c.Description + ' (' + b.LinePlanAttributeText1 + ' / ' + LinePlanAttributeText2 + 
		' / ' + LinePlanAttributeText3 + ' / ' + LinePlanAttributeText4 +  ')' 
		as Description 
		FROM pLinePlanItem a WITH(NOLOCK) 
		INNER JOIN pLinePlanRange b  WITH(NOLOCK) ON a.LinePlanRangeID =  b.LinePlanRangeID
		INNER JOIN pLinePlan c  WITH(NOLOCK) ON c.LinePlanID = a.LinePlanID 
		WHERE a.LinePlanItemID = @LinePlanItemID 
	ELSE 
		SELECT b.LinePlanAttributeText1 + ' / ' + LinePlanAttributeText2 + ' / ' + LinePlanAttributeText3  
		+ ' / ' + LinePlanAttributeText4
		FROM pLinePlanItem a WITH(NOLOCK) 
		INNER JOIN pLinePlanRange b WITH(NOLOCK)  ON a.LinePlanRangeID =  b.LinePlanRangeID
		INNER JOIN pLinePlan c WITH(NOLOCK)  ON c.LinePlanID = a.LinePlanID 
		WHERE a.LinePlanItemID = @LinePlanItemID 

END 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01228', GetDate())
GO
