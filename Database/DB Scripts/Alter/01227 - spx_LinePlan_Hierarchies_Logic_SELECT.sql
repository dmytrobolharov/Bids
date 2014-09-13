IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_Hierarchies_Logic_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_Hierarchies_Logic_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlan_Hierarchies_Logic_SELECT] (
	@StyleID UNIQUEIDENTIFIER 
)
AS 

DECLARE @LinePlanItemID  UNIQUEIDENTIFIER 

IF ( SELECT COUNT(*) FROM pStyleSeasonYear WITH(NOLOCK) WHERE StyleID = @StyleID AND LinePlanItemID IS NOT NULL)= 1
BEGIN

	SELECT @LinePlanItemID = LinePlanItemID  FROM pStyleSeasonyear a WITH(NOLOCK) 
	WHERE a.StyleID = @StyleID 


	IF @LinePlanItemID  IS NOT NULL
	BEGIN

		/***
		*** Style is in a lineplan 
		***/
		DECLARE @LinePlanID UNIQUEIDENTIFIER 
		DECLARE @LinePlanRangeID UNIQUEIDENTIFIER 
		DECLARE @LinePlanIndex INT 
		

		SELECT @LinePlanRangeID = a.LinePlanRangeID, @LinePlanID = a.LinePlanID
		FROM pLinePlanItem a WITH(NOLOCK) 
		WHERE a.LinePlanItemID = @LinePlanItemID 
		
		SELECT @LinePlanIndex = COUNT(*)
		FROM pLinePlan	a WITH(NOLOCK) 
			INNER JOIN	pLinePlanTemplateItem  b  WITH(NOLOCK) ON a.LinePlanTemplateID = b.LinePlanTemplateID 
		WHERE LinePlanID = @LinePlanID
			
						
			
		
		IF @LinePlanIndex = 4
			SELECT DISTINCT b.LinePlanAttributeText1 + ' / ' + b.LinePlanAttributeText2 + ' / '  + 
			b.LinePlanAttributeText3 + ' / ' + b.LinePlanAttributeText4  AS Hierarchy, b.LinePlanRangeID 
			FROM pLinePlanItem a WITH(NOLOCK) 
			INNER JOIN pLinePlanRange b  WITH(NOLOCK) ON a.LinePlanRangeID =  b.LinePlanRangeID 
			WHERE a.LinePlanID = @LinePlanID 
			AND a.LinePlanRangeID <>  @LinePlanRangeID 
			AND a.StyleID = '00000000-0000-0000-0000-000000000000'
			AND a.LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
			ORDER BY b.LinePlanAttributeText1 + ' / ' + b.LinePlanAttributeText2 + ' / '  + b.LinePlanAttributeText3  + ' / ' + b.LinePlanAttributeText4 
		ELSE 
			SELECT DISTINCT b.LinePlanAttributeText1 + ' / ' + b.LinePlanAttributeText2 + ' / '  + 
			b.LinePlanAttributeText3 AS Hierarchy, b.LinePlanRangeID 
			FROM pLinePlanItem a WITH(NOLOCK) 
			INNER JOIN pLinePlanRange b  WITH(NOLOCK) ON a.LinePlanRangeID =  b.LinePlanRangeID 
			WHERE a.LinePlanID = @LinePlanID 
			AND a.LinePlanRangeID <>  @LinePlanRangeID 
			AND a.StyleID = '00000000-0000-0000-0000-000000000000'
			AND a.LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
			ORDER BY b.LinePlanAttributeText1 + ' / ' + b.LinePlanAttributeText2 + ' / '  + b.LinePlanAttributeText3 
			
	END 
	ELSE 
		SELECT NULL AS  Hierarchy, NULL AS LinePlanRangeID
END 
ELSE 
	SELECT NULL AS  Hierarchy, NULL AS LinePlanRangeID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01227', GetDate())
GO
