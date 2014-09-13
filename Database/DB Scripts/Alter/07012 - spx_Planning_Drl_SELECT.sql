IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Drl_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Drl_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Drl_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @AttrLevel INT
	, @BrandID NVARCHAR (MAX) = NULL
	, @DivisionID NVARCHAR (MAX) = NULL
	, @StyleTypeID NVARCHAR (MAX) = NULL
	, @StyleCategoryID NVARCHAR (MAX) = NULL
)
AS

BEGIN
	CREATE TABLE #tmpDRL(
		BrandID UNIQUEIDENTIFIER
		, Brand NVARCHAR (MAX)
		, DivisionID UNIQUEIDENTIFIER
		, Division NVARCHAR (MAX)
		, StyleTypeID INT
		, StyleType NVARCHAR (MAX)
		, StyleCategoryID UNIQUEIDENTIFIER
		, StyleCategory NVARCHAR (MAX)
		, AttrLevel INT
		, IsVisible INT
		, SubCategoryID UNIQUEIDENTIFIER
		, SubCategory NVARCHAR (MAX)
		, SubCategoryCount INT
		, DeliveryID UNIQUEIDENTIFIER
		, Delivery NVARCHAR (MAX)
	)
		

	INSERT INTO #tmpDRL
	EXEC spx_Planning_LinePlanningAttribute_Full_SELECT @PlanningID, @SeasonYearID

	SELECT * FROM #tmpDRL
	WHERE IsVisible = 1	AND AttrLevel = @AttrLevel
		AND ((BrandID IN (SELECT value FROM dbo.fnx_Split(@BrandID, ',')) AND @AttrLevel > 0) OR @AttrLevel = 0)
		AND ((DivisionID IN (SELECT value FROM dbo.fnx_Split(@DivisionID, ',')) AND @AttrLevel > 1) OR @DivisionID IS NULL)
		AND ((StyleTypeID IN (SELECT value FROM dbo.fnx_Split(@StyleTypeID, ',')) AND @AttrLevel > 2) OR @StyleTypeID IS NULL)
		AND ((StyleCategoryID IN (SELECT value FROM dbo.fnx_Split(@StyleCategoryID, ',')) AND @AttrLevel > 3) OR @StyleCategoryID IS NULL)

	DROP TABLE #tmpDRL
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07012', GetDate())
GO
