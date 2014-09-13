IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningAttribute_Check_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_Check_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_Check_INSERT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	CREATE TABLE #tmpAttributeList (DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT, 
								IsVisible INT)


	INSERT INTO #tmpAttributeList
	EXEC spx_Planning_LinePlanningAttribute_SELECT @PlanningID
	
	INSERT INTO pPlanningBusiness (PlanningID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
										PlanningDivisionID, PlanningDivision, PlanningStyleTypeID, PlanningStyleTypeDescription,
										PlanningStyleCategoryID, PlanningStyleCategory, SeasonYearID)
	SELECT @PlanningID, pf.PlanningFinancialID, pf.PlanningFinancialText, pf.PlanningFinancialSort, tal.DivisionID, tal.DivisionName,
			tal.StyleTypeID, tal.StyleTypeDescription, tal.StyleCategoryID, tal.StyleCategory, @SeasonYearID
	FROM pPlanningFinancial pf, #tmpAttributeList tal
	WHERE NOT EXISTS(
		SELECT * FROM pPlanningBusiness pb
		WHERE ISNULL(pb.PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
			ISNULL(pb.PlanningStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
			ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000') AND
			pb.PlanningFinancialID = pf.PlanningFinancialID AND
			pb.SeasonYearID = @SeasonYearID AND
			pb.PlanningID = @PlanningID
	)
	
	DELETE FROM pPlanningBusiness WHERE 
		NOT EXISTS(
				SELECT * FROM #tmpAttributeList tal WHERE 
					ISNULL(pPlanningBusiness.PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
					ISNULL(pPlanningBusiness.PlanningStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
					ISNULL(pPlanningBusiness.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000')
			)
		AND NOT (PlanningBrandID IS NOT NULL AND PlanningDivisionID IS NULL)
		AND SeasonYearID = @SeasonYearID
		AND pPlanningBusiness.PlanningID = @PlanningID
		
	
	INSERT INTO pPlanningBusiness (
		PlanningID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
		PlanningBrandID, PlanningBrand, SeasonYearID)
	SELECT @PlanningID, pf.PlanningFinancialID, pf.PlanningFinancialText, pf.PlanningFinancialSort, tal.CustomID, tal.Custom, @SeasonYearID
	FROM pPlanningFinancial pf, (SELECT DISTINCT b.CustomID, b.Custom FROM (SELECT DISTINCT DivisionID FROM #tmpAttributeList) d 
								 INNER JOIN vwx_Division_SEL vd ON d.DivisionID = vd.CustomID
								 INNER JOIN pBrand b ON vd.BrandID = b.CustomID) tal
	WHERE NOT EXISTS(
		SELECT * FROM pPlanningBusiness pb
		WHERE pb.PlanningBrandID = tal.CustomID
			AND pb.PlanningDivisionID IS NULL
			AND pb.PlanningStyleTypeID IS NULL
			AND pb.PlanningStyleCategoryID IS NULL 
			AND pb.PlanningFinancialID = pf.PlanningFinancialID
			AND pb.SeasonYearID = @SeasonYearID
			AND pb.PlanningID = @PlanningID
	)
	
	DELETE FROM pPlanningBusiness 
	WHERE PlanningBrandID NOT IN (
			SELECT vd.BrandID FROM (SELECT DISTINCT DivisionID FROM #tmpAttributeList) d 
			INNER JOIN vwx_Division_SEL vd ON d.DivisionID = vd.CustomID)
		AND PlanningDivisionID IS NULL
		AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL
		AND SeasonYearID = @SeasonYearID
		AND PlanningID = @PlanningID
		
	UPDATE pPlanningBusiness SET PlanningBrandID = b.CustomID, PlanningBrand = b.Custom
	FROM pPlanningBusiness pb
	INNER JOIN vwx_Division_SEL d ON pb.PlanningDivisionID = d.CustomID
	INNER JOIN pBrand b ON d.BrandID = b.CustomID
	WHERE pb.PlanningID = @PlanningID 
		AND (pb.PlanningBrandID <> b.CustomID OR pb.PlanningBrandID IS NULL)
		AND pb.SeasonYearID = @SeasonYearID
		

	DROP TABLE #tmpAttributeList
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06408', GetDate())
GO