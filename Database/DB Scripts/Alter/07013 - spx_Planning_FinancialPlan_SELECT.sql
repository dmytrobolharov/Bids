IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FinancialPlan_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FinancialPlan_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_FinancialPlan_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @BrandID NVARCHAR (MAX)
	, @DivisionID NVARCHAR (MAX)
	, @StyleTypeID NVARCHAR (MAX)
	, @StyleCategoryID NVARCHAR (MAX)
	, @SubCategoryID NVARCHAR (MAX)
)
AS
BEGIN
	DECLARE @PlanningFinancialIDList NVARCHAR(MAX)

	SELECT @PlanningFinancialIDList = COALESCE(@PlanningFinancialIDList + ',', '') + 
	'[' + CAST(PlanningFinancialID AS NVARCHAR(50)) + ']'
	FROM pPlanningFinancial WHERE Active = 1 ORDER BY PlanningFinancialSort

	DECLARE @sql NVARCHAR(MAX) = 
		'SELECT PlanningStyleCategory, PlanningStyleTypeDescription, PlanningDivision
				, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningBrandID, PlanningBrand
				, PlanningSubCategoryID, PlanningSubCategory,' + @PlanningFinancialIDList + '
				, (SELECT COUNT(*) FROM pStyleCategoryStyleType scst WHERE scst.StyleTypeID = pvt.PlanningStyleTypeID) AS CategoriesCount
		FROM (SELECT PlanningPlanningCh, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningFinancialID, PlanningStyleCategory
					, PlanningStyleTypeDescription, PlanningDivision, PlanningBrandID, PlanningBrand, PlanningSubCategoryID, PlanningSubCategory
			FROM pPlanningBusiness pb
			WHERE PlanningDivisionID IS NOT NULL
				AND PlanningStyleTypeID IS NOT NULL
				AND PlanningStyleCategoryID IS NOT NULL
				AND ((PlanningSubCategoryID IS NULL AND
					(SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
						WHERE psctsc.PlanningID = @PlanningID
						AND psctsc.SeasonYearID = @SeasonYearID
						AND psctsc.PlanningDivisionID = pb.PlanningDivisionID
						AND psctsc.PlanningStyleTypeID = pb.PlanningStyleTypeID 
						AND psctsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID
					) = 0) OR PlanningSubCategoryID IS NOT NULL)
				AND PlanningID = @PlanningID
				AND SeasonYearID = @SeasonYearID
				AND (PlanningBrandID IN (SELECT value FROM dbo.fnx_Split(@BrandID, '','')) OR @BrandID IS NULL)
				AND (PlanningDivisionID IN (SELECT value FROM dbo.fnx_Split(@DivisionID, '','')) OR @DivisionID IS NULL)
				AND (PlanningStyleTypeID IN (SELECT value FROM dbo.fnx_Split(@StyleTypeID, '','')) OR @StyleTypeID IS NULL)
				AND (PlanningStyleCategoryID IN (SELECT value FROM dbo.fnx_Split(@StyleCategoryID, '','')) OR @StyleCategoryID IS NULL)
				AND (PlanningSubCategoryID IN (SELECT value FROM dbo.fnx_Split(@SubCategoryID, '','')) OR @SubCategoryID IS NULL)
		) tbl
		PIVOT (MAX(PlanningPlanningCh) FOR PlanningFinancialID IN (' + @PlanningFinancialIDList + ')) pvt
		WHERE pvt.[10000000-0000-0000-0000-000000000000] > 0
			OR pvt.[10000000-0000-0000-0000-000000000020] > 0
			OR pvt.[10000000-0000-0000-0000-000000000001] > 0
		ORDER BY CASE WHEN PlanningStyleTypeID IS NULL AND PlanningStyleCategoryID IS NULL THEN 1 ELSE 0 END
			, PlanningStyleTypeDescription, PlanningStyleCategory, PlanningSubCategory'

	exec sp_executesql @sql, N'@PlanningID UNIQUEIDENTIFIER, @SeasonYearID UNIQUEIDENTIFIER, @BrandID NVARCHAR (MAX), @DivisionID NVARCHAR (MAX), @StyleTypeID NVARCHAR (MAX), @StyleCategoryID NVARCHAR (MAX), @SubCategoryID NVARCHAR (MAX)'
							, @PlanningID = @PlanningID, @SeasonYearID = @SeasonYearID, @BrandID = @BrandID, @DivisionID = @DivisionID, @StyleTypeID = @StyleTypeID, @StyleCategoryID = @StyleCategoryID, @SubCategoryID = @SubCategoryID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07013', GetDate())
GO
