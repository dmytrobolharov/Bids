IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SubCategory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SubCategory_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_Planning_SubCategory_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER, 
	@SeasonYearID UNIQUEIDENTIFIER,
	@BrandID UNIQUEIDENTIFIER,
	@DivisionID UNIQUEIDENTIFIER,
	@StyleTypeID INT,
	@StyleCategoryID UNIQUEIDENTIFIER
	
)
AS
BEGIN
	SELECT sbc.CustomID as SubCategoryId, sbc.Custom as SubCategory, CASE WHEN psctsc.SubCategoryID IS NOT NULL THEN 1 ELSE 0 END as IsSet
	FROM pSubCategory sbc
		LEFT JOIN pPlanningStyleCategoryToSubCategory psctsc ON sbc.CustomID = psctsc.SubCategoryID
		AND psctsc.PlanningID = @PlanningID
		AND psctsc.SeasonYearID = @SeasonYearID
		AND psctsc.PlanningBrandID = @BrandID
		AND psctsc.PlanningDivisionID = @DivisionID
		AND psctsc.PlanningStyleTypeID = @StyleTypeID
		AND psctsc.PlanningStyleCategoryID = @StyleCategoryID
		INNER JOIN pStyleCategorySubCategory scsc ON sbc.CustomId = scsc.SubCategoryId AND StyleCategoryId = @StyleCategoryID
	WHERE sbc.Active = 1
	ORDER BY sbc.CustomSort, sbc.Custom
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07348', GetDate())
GO
