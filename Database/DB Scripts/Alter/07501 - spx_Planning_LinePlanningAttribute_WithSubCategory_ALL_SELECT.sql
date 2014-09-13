IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningAttribute_WithSubCategory_ALL_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_WithSubCategory_ALL_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_WithSubCategory_ALL_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	WITH dsc as (
		SELECT b.CustomID as BrandID, b.Custom as Brand,
		vw.DivisionID, vw.DivisionName, vw.StyleTypeID, vw.StyleTypeDescription, vw.StyleCategoryID, vw.StyleCategory, 
		CASE 
			WHEN pb.PlanningSubCategoryID IS NOT NULL THEN 4 ELSE vw.AttributeLevel END as AttributeLevel,
		CASE 
			WHEN vw.AttributeLevel = 1 THEN 1 -- divisions level
			WHEN vw.AttributeLevel IN (2,3) AND (pb.PlanningPlanningCh > 0 OR pb.PlanningDIPCh > 0 OR pb.PlanningActualCh > 0) THEN 1 
		ELSE 0 
		END IsVisible, 
		sc.CustomID AS SubCategoryId, sc.Custom AS SubCategory
		FROM vwx_Division_StyleType_StyleCategory_SELECT vw
			INNER JOIN pStyleType st ON vw.StyleTypeID = st.StyleTypeID OR vw.StyleTypeID IS NULL
			INNER JOIN pStyleTypeTemplate stt ON st.StyleTypeTemplateID = stt.StyleTypeTemplateID AND stt.StyleTypeTemplateName = 'Style'
			INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID	
			INNER JOIN vwx_Division_SEL d ON pd.DivisionID = d.CustomID
			INNER JOIN pBrand b ON d.BrandID = b.CustomID	
			LEFT JOIN (SELECT StyleCategoryId, SubCategoryId FROM pStyleCategorySubCategory UNION SELECT StyleCategoryId, NULL FROM pStyleCategorySubCategory) scsc ON vw.StyleCategoryID = scsc.StyleCategoryId
			LEFT JOIN pSubCategory sc ON scsc.SubCategoryId = sc.CustomID
			LEFT JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
				AND SeasonYearID = @SeasonYearID
				AND ISNULL(vw.StyleTypeID,'0') = ISNULL(pb.PlanningStyleTypeID, '0')
				AND ISNULL(vw.StyleCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000')
				AND pb.PlanningID = @PlanningID
				AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- Number of Styles
				
				AND pb.PlanningSubCategoryID IS NULL) -- in order to take all subcategories from pStyleCategorySubCategory (not only from pPlanningBusiness table)
				
	SELECT DISTINCT b.CustomID AS BrandID, b.Custom AS Brand, NULL AS DivisionID, NULL AS DivisionName, 
		NULL AS StyleTypeID, NULL AS StyleTypeDescription, 
		NULL AS StyleCategoryID, NULL AS StyleCategory, 
		0 AS AttributeLevel, 1 as IsVisible,
		NULL AS SubCategoryID, NULL AS SubCategory
	FROM pPlanningDivision pd
	INNER JOIN vwx_Division_SEL d ON pd.DivisionID = d.CustomID
	INNER JOIN pBrand b ON d.BrandID = b.CustomID
	WHERE pd.PlanningID = @PlanningID
	
	UNION 
	
	SELECT * FROM dsc 
	
	ORDER BY Brand, DivisionName, StyleTypeDescription, StyleCategory, SubCategory

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07501', GetDate())
GO
