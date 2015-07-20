IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningAttribute_SELECT]'))
DROP VIEW [dbo].[vwx_PlanningAttribute_SELECT]
GO

CREATE VIEW [dbo].[vwx_PlanningAttribute_SELECT]
AS
SELECT PlanningID, SeasonYearID, PlanningSeasonYearID, 
	UPPER(AttributeID) AS AttributeID, AttributeName, Lvl, MAX(AttributeIsVisible) AS AttributeIsVisible 
FROM (
	SELECT DISTINCT pb.PlanningID, pb.SeasonYearID, psy.PlanningSeasonYearID, V.*
	FROM pPlanningBusiness pb
	INNER JOIN pPlanningSeasonYear psy ON pb.PlanningID = psy.PlanningID
		AND pb.SeasonYearID = psy.SeasonYearID	
	CROSS APPLY (VALUES (CAST(pb.PlanningBrandID AS VARCHAR(40)), pb.PlanningBrand, 0, 1),
						(CAST(pb.PlanningDivisionID AS VARCHAR(40)), pb.PlanningDivision, 1, 1),
						(CAST(pb.PlanningStyleTypeID AS VARCHAR(40)), pb.PlanningStyleTypeDescription, 2, 1),
						(CAST(pb.PlanningStyleCategoryID AS VARCHAR(40)), pb.PlanningStyleCategory, 3,
							CASE WHEN pb.PlanningPlanningCh > 0 OR pb.PlanningDIPCh > 0 OR pb.PlanningActualCh > 0 THEN 1 ELSE 0 END),
						(CAST(pb.PlanningSubCategoryID AS VARCHAR(40)), pb.PlanningSubCategory, 4,
							CASE WHEN pb.PlanningPlanningCh > 0 OR pb.PlanningDIPCh > 0 OR pb.PlanningActualCh > 0 THEN 1 ELSE 0 END))
					   V(AttributeID, AttributeName, Lvl, AttributeIsVisible)
	WHERE ((pb.PlanningSubCategoryID IS NULL AND pb.PlanningStyleCategory IS NOT NULL) OR pb.PlanningSubCategoryID IS NOT NULL)
		AND V.AttributeID IS NOT NULL 
		AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000') tbl -- Number of Styles		
GROUP BY PlanningID, SeasonYearID, PlanningSeasonYearID, AttributeID, AttributeName, Lvl

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07339', GetDate())
GO
