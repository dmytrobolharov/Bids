IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_MoveTo_Logic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_MoveTo_Logic_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlan_MoveTo_Logic_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LinePlan_MoveTo_Logic_SELECT](
	@StyleID UNIQUEIDENTIFIER 
)
AS 

	DECLARE @LinePlanID UNIQUEIDENTIFIER
	DECLARE @LinePlanAttributeText1 NVARCHAR(200)
	DECLARE @LinePlanAttributeText2 NVARCHAR(200)
	DECLARE @LinePlanAttributeText3 NVARCHAR(200)

	
	SELECT @LinePlanID = a.LinePlanID, @LinePlanAttributeText1 = c.LinePlanAttributeText1, 
	@LinePlanAttributeText2 = c.LinePlanAttributeText2, @LinePlanAttributeText3 = c.LinePlanAttributeText3
	FROM pStyleSeasonYear a
	INNER JOIN pLinePlanItem b ON a.LinePlanItemID =  b.LinePlanItemID
	INNER JOIN pLinePlanRange c ON c.LinePlanRangeID =  b.LinePlanRangeID 
	WHERE a.StyleID = @StyleID
	AND a.LinePlanItemID  IS NOT NULL 
	
	IF @LinePlanID IS NOT NULL 
	AND @LinePlanAttributeText1 IS NOT NULL 
	AND @LinePlanAttributeText2 IS NOT NULL 
	AND @LinePlanAttributeText3 IS NOT NULL 
	BEGIN
		
		SELECT DISTINCT a.LinePlanID, c.Description + '&nbsp;&nbsp;&nbsp;(' + c.Season + '/' + c.Year  + ')' AS Description 
		FROM  pLinePlanItem a
		INNER JOIN pLinePlanRange b  ON a.LinePlanRangeID =  b.LinePlanRangeID 
		INNER JOIN pLinePlan c ON c.LinePlanID =  a.LinePlanID 
		WHERE a.StyleID = '00000000-0000-0000-0000-000000000000'
		AND a.LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
		AND b.LinePlanAttributeText1 =  @LinePlanAttributeText1
		AND b.LinePlanAttributeText2 =  @LinePlanAttributeText2
		AND b.LinePlanAttributeText3 =  @LinePlanAttributeText3
		AND a.LinePlanID NOT IN (
			SELECT b.LinePlanID  
			FROM pStyleSeasonYear a
			INNER JOIN pLinePlanItem b ON b.LinePlanItemID =  a.LinePlanItemID 
			WHERE a.StyleID = @StyleID --'7ca997ee-5944-4c48-a918-83f85d324c32'
		)
		ORDER BY Description 
	
	END 
	ELSE
		SELECT NULL AS LinePlanID,  NULL AS Description


Go



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03378', GetDate())
GO