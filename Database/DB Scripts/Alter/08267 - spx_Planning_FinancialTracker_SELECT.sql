IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FinancialTracker_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FinancialTracker_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_FinancialTracker_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@BrandID UNIQUEIDENTIFIER,
	@DivisionID UNIQUEIDENTIFIER,
	@StyleTypeID INT,
	@StyleCategoryID UNIQUEIDENTIFIER,
	@SubCategoryID UNIQUEIDENTIFIER,
	@IsMerchandise INT
AS
BEGIN
	
	SELECT * FROM vwx_PlanningBusiness_SEL
	WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
	AND (PlanningBrandID = @BrandID OR (@BrandID IS NULL AND PlanningBrandID IS NULL))
	AND (PlanningDivisionID = @DivisionID OR (@DivisionID IS NULL AND PlanningDivisionID IS NULL))
	AND (PlanningStyleTypeID = @StyleTypeID OR (@StyleTypeID IS NULL AND PlanningStyleTypeID IS NULL))
	AND (PlanningStyleCategoryID = @StyleCategoryID OR (@StyleCategoryID IS NULL AND PlanningStyleCategoryID IS NULL))
	AND (PlanningSubCategoryID = @SubCategoryID OR (@SubCategoryID IS NULL AND PlanningSubCategoryID IS NULL))
	AND ((@IsMerchandise = 1 AND IsMerchandise = 1) OR (@IsMerchandise = 0 AND IsFinancial = 1))
	ORDER BY PlanningFinancialSort
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08267', GetDate())
GO
