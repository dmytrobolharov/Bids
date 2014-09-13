IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_AttributeName_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_AttributeName_SELECT]
GO

CREATE PROCEDURE dbo.spx_LinePlan_AttributeName_SELECT(
	@StyleID   UNIQUEIDENTIFIER
)
AS



SELECT TOP  1 
	d.AttributeName
FROM dbo.pStyleSeasonYear  a
	INNER JOIN pLinePlanItem b ON a.LinePlanItemID = b.LinePlanItemID
	INNER JOIN dbo.pLinePlanRange e ON e.LinePlanRangeID =  b.LinePlanRangeID
	INNER JOIN dbo.pLinePlanStyleAttributeItem c ON c.LinePlanStyleAttributeItemID = b.LinePlanStyleAttributeItemID
	INNER JOIN  pLinePlanStyleAttribute d ON d.LinePlanStyleAttributeID = c.LineplanStyleAttributeID
WHERE a.StyleID = @StyleID 




	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01136', GetDate())
GO







