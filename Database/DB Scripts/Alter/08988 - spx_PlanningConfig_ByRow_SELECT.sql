IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningConfig_ByRow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningConfig_ByRow_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_PlanningConfig_ByRow_SELECT]
	@PlanningConfigID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT
		IntroSeasonYearID = pc.SeasonYearID,
		DivisionID = pc.DivisionID,
		StyleType = pc.StyleTypeID,
		StyleCategory = pc.StyleCategoryID,
		SubCategoryId = LOWER(CAST(pc.SubCategoryID AS NVARCHAR(50))),
		Description = pc.Description,
		SizeClass = pc.SizeClass,
		SizeRange = pc.SizeRange,
		CustomField3 = pc.Status,
		StyleThemeID = pc.StyleThemeID
	FROM pPlanningConfig pc
	WHERE pc.PlanningConfigID = @PlanningConfigID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08988', GetDate())
GO
