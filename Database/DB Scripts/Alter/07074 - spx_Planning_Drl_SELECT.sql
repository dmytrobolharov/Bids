IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Drl_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Drl_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Drl_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @AttrLevel INT
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

	SELECT DISTINCT UPPER(V.ID) AS ID, v.Name FROM #tmpDRL
	CROSS APPLY (VALUES (CAST(BrandID AS NVARCHAR(40)), Brand, 0)
						, (CAST(DivisionID AS NVARCHAR(40)), Division, 1)
						, (CAST(StyleTypeID AS NVARCHAR(40)), StyleType, 2)
						, (CAST(StyleCategoryID AS NVARCHAR(40)), StyleCategory, 3)
						, (CAST(SubCategoryID AS NVARCHAR(40)), SubCategory, 4))
				V(ID, Name, lvl)
	WHERE IsVisible = 1 AND ID IS NOT NULL AND lvl = @AttrLevel
	ORDER BY Name

	DROP TABLE #tmpDRL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07074', GetDate())
GO
