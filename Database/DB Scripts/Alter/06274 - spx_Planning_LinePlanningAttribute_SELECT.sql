IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningAttribute_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_SELECT]
	@PlanningID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT vw.*, CASE 
	WHEN vw.AttributeLevel = 1 THEN 1 -- divisions level
	WHEN vw.AttributeLevel IN (2,3) AND pb.PlanningPlanningCh > 0 THEN 1 
	ELSE 0 
	END IsVisible 
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID
		LEFT JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
			AND ISNULL(vw.StyleTypeID,'0') = ISNULL(pb.PlanningStyleTypeID, '0')
			AND ISNULL(vw.StyleCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000')
			AND pb.PlanningID = @PlanningID
			AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- Number of Styles
	ORDER BY vw.DivisionName, vw.StyleTypeDescription, vw.StyleCategory
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06274', GetDate())
GO
