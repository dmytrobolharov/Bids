IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningAttribute_Check_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_Check_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_Check_INSERT]
	@PlanningID UNIQUEIDENTIFIER
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
										PlanningStyleCategoryID, PlanningStyleCategory)
	SELECT @PlanningID, pf.PlanningFinancialID, pf.PlanningFinancialText, pf.PlanningFinancialSort, tal.DivisionID, tal.DivisionName,
			tal.StyleTypeID, tal.StyleTypeDescription, tal.StyleCategoryID, tal.StyleCategory
	FROM pPlanningFinancial pf, #tmpAttributeList tal
	WHERE NOT EXISTS(
		SELECT * FROM pPlanningBusiness pb
		WHERE ISNULL(pb.PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
			ISNULL(pb.PlanningStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
			ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000') AND
			pb.PlanningFinancialID = pf.PlanningFinancialID AND
			pb.PlanningID = @PlanningID
	)
	
	DELETE FROM pPlanningBusiness WHERE 
		NOT EXISTS(
				SELECT * FROM #tmpAttributeList tal WHERE 
					ISNULL(pPlanningBusiness.PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
					ISNULL(pPlanningBusiness.PlanningStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
					ISNULL(pPlanningBusiness.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000')
			)
		AND pPlanningBusiness.PlanningID = @PlanningID
		

	DROP TABLE #tmpAttributeList
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06189', GetDate())
GO
