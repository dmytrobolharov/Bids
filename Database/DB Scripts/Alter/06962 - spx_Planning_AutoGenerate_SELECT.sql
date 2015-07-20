IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_AutoGenerate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_AutoGenerate_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_AutoGenerate_SELECT]
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	CREATE TABLE #tmpAttributeList (BrandID UNIQUEIDENTIFIER, 
								Brand NVARCHAR(200) COLLATE database_default, 
								DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT, 
								IsVisible INT,
								SubCategoryID UNIQUEIDENTIFIER,
								SubCategory NVARCHAR(200) COLLATE database_default,
								SubCategoriesCount INT
								)

	CREATE TABLE #tmpAttrbuteNoOfStyles (DivisionID UNIQUEIDENTIFIER, 
								StyleTypeID INT, 
								StyleCategoryID UNIQUEIDENTIFIER,
								SubCategoryID UNIQUEIDENTIFIER,
								PlanningPlanningCh DECIMAL(18,5),
								PlanningDIPCh DECIMAL(18,5),
								PlanningActualCh DECIMAL(18,5),
								SubCategoriesCount INT)

	CREATE TABLE #tmpAttrbuteOverDevStyles (DivisionID UNIQUEIDENTIFIER, 
								StyleTypeID INT, 
								StyleCategoryID UNIQUEIDENTIFIER,
								SubCategoryID UNIQUEIDENTIFIER,
								PlanningPlanningCh DECIMAL(18,5),
								PlanningDIPCh DECIMAL(18,5),
								PlanningActualCh DECIMAL(18,5),
								SubCategoriesCount INT)

	CREATE TABLE #tmpAttrbuteCarryOverStyles (DivisionID UNIQUEIDENTIFIER, 
								StyleTypeID INT, 
								StyleCategoryID UNIQUEIDENTIFIER,
								SubCategoryID UNIQUEIDENTIFIER,
								PlanningPlanningCh DECIMAL(18,5),
								PlanningDIPCh DECIMAL(18,5),
								PlanningActualCh DECIMAL(18,5),
								SubCategoriesCount INT)


	INSERT INTO #tmpAttrbuteNoOfStyles
	SELECT * FROM (
	SELECT vw.DivisionID,  vw.StyleTypeID, vw.StyleCategoryID, pb.PlanningSubCategoryID, 
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh,
		(
			SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
			WHERE psctsc.PlanningID = pb.PlanningID
				AND psctsc.PlanningBrandID = pb.PlanningBrandID
				AND psctsc.PlanningDivisionID = pb.PlanningDivisionID
				AND psctsc.PlanningStyleTypeID = pb.PlanningStyleTypeID 
				AND psctsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID
				AND psctsc.SeasonYearID = pb.SeasonYearID
		) AS SubCategoriesCount		
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID
		INNER JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
			AND vw.StyleTypeID = pb.PlanningStyleTypeID
			AND vw.StyleCategoryID = pb.PlanningStyleCategoryID
		WHERE pb.PlanningID = @PlanningID
			AND pb.SeasonYearID = @SeasonYearID
			AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- # of Planned Styles
		) t
		WHERE SubCategoriesCount = 0 OR (SubCategoriesCount > 0 AND PlanningSubCategoryID IS NOT NULL)
			

	INSERT INTO #tmpAttrbuteOverDevStyles
	SELECT * FROM (
	SELECT vw.DivisionID,  vw.StyleTypeID, vw.StyleCategoryID, pb.PlanningSubCategoryID, 
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh,
		(
			SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
			WHERE psctsc.PlanningID = pb.PlanningID
				AND psctsc.PlanningBrandID = pb.PlanningBrandID
				AND psctsc.PlanningDivisionID = pb.PlanningDivisionID
				AND psctsc.PlanningStyleTypeID = pb.PlanningStyleTypeID 
				AND psctsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID
				AND psctsc.SeasonYearID = pb.SeasonYearID
		) AS SubCategoriesCount		
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID
		INNER JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
			AND vw.StyleTypeID = pb.PlanningStyleTypeID
			AND vw.StyleCategoryID = pb.PlanningStyleCategoryID
		WHERE pb.PlanningID = @PlanningID
			AND pb.SeasonYearID = @SeasonYearID
			AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000020' -- # of Over Dev. Styles
		) t
		WHERE SubCategoriesCount = 0 OR (SubCategoriesCount > 0 AND PlanningSubCategoryID IS NOT NULL)

	INSERT INTO #tmpAttrbuteCarryOverStyles
	SELECT * FROM (
	SELECT vw.DivisionID,  vw.StyleTypeID, vw.StyleCategoryID, pb.PlanningSubCategoryID, 
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh,
		(
			SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
			WHERE psctsc.PlanningID = pb.PlanningID
				AND psctsc.PlanningBrandID = pb.PlanningBrandID
				AND psctsc.PlanningDivisionID = pb.PlanningDivisionID
				AND psctsc.PlanningStyleTypeID = pb.PlanningStyleTypeID 
				AND psctsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID
				AND psctsc.SeasonYearID = pb.SeasonYearID
		) AS SubCategoriesCount		
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID
		INNER JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
			AND vw.StyleTypeID = pb.PlanningStyleTypeID
			AND vw.StyleCategoryID = pb.PlanningStyleCategoryID
		WHERE pb.PlanningID = @PlanningID
			AND pb.SeasonYearID = @SeasonYearID
			AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000001' -- # of Carry Over Styles
		) t
		WHERE SubCategoriesCount = 0 OR (SubCategoriesCount > 0 AND PlanningSubCategoryID IS NOT NULL)

	

	INSERT INTO #tmpAttributeList
	EXEC spx_Planning_LinePlanningAttribute_WithSubCategory_SELECT @PlanningID, @SeasonYearID
	
	SELECT pc.PlanningConfigID, pc.WorkflowTemplateID,
		CASE WHEN pc.PlanningConfigID IS NULL THEN 0 ELSE 1 END as ConfigExists,
		((tmp1.PlanningPlanningCh + tmp2.PlanningPlanningCh - tmp3.PlanningPlanningCh) - (tmp1.PlanningDIPCh + tmp1.PlanningActualCh)) as NoOfStyles
	FROM #tmpAttributeList attr
		LEFT JOIN pPlanningConfig pc ON attr.DivisionID = pc.DivisionID 
			AND attr.StyleTypeID = pc.StyleTypeID
			AND attr.StyleCategoryID = pc.StyleCategoryID
			AND ISNULL(attr.SubCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(pc.SubCategoryID, '00000000-0000-0000-0000-000000000000')
			AND pc.PlanningID = @PlanningID
		INNER JOIN #tmpAttrbuteNoOfStyles tmp1 ON attr.DivisionID = tmp1.DivisionID 
			AND attr.StyleTypeID = tmp1.StyleTypeID
			AND attr.StyleCategoryID = tmp1.StyleCategoryID
			AND ISNULL(attr.SubCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(tmp1.SubCategoryID, '00000000-0000-0000-0000-000000000000')
		INNER JOIN #tmpAttrbuteOverDevStyles tmp2 ON attr.DivisionID = tmp2.DivisionID 
			AND attr.StyleTypeID = tmp2.StyleTypeID
			AND attr.StyleCategoryID = tmp2.StyleCategoryID
			AND ISNULL(attr.SubCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(tmp2.SubCategoryID, '00000000-0000-0000-0000-000000000000')
		INNER JOIN #tmpAttrbuteCarryOverStyles tmp3 ON attr.DivisionID = tmp3.DivisionID 
			AND attr.StyleTypeID = tmp3.StyleTypeID
			AND attr.StyleCategoryID = tmp3.StyleCategoryID
			AND ISNULL(attr.SubCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(tmp3.SubCategoryID, '00000000-0000-0000-0000-000000000000')
	WHERE attr.DivisionID IS NOT NULL AND attr.StyleTypeID IS NOT NULL AND attr.StyleCategoryID IS NOT NULL
	ORDER BY DivisionName, StyleTypeDescription, StyleCategory


	
	DROP TABLE #tmpAttributeList
	DROP TABLE #tmpAttrbuteNoOfStyles
	DROP TABLE #tmpAttrbuteOverDevStyles
	DROP TABLE #tmpAttrbuteCarryOverStyles
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06962', GetDate())
GO
