IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_AutoGenerate_Logic_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_AutoGenerate_Logic_Update]
GO

CREATE PROCEDURE [dbo].[spx_Planning_AutoGenerate_Logic_Update]
	@PlanningConfigID UNIQUEIDENTIFIER, 
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN

	UPDATE pStyleHeader 
	SET 
		DivisionID = pc.DivisionID,
		StyleType = pc.StyleTypeID,
		StyleCategory = pc.StyleCategoryID,
		IntroSeasonYearID = @SeasonYearID,
		MUser = @MUser,
		MDate = @MDate,

		Description = pc.Description,
		SizeClass = pc.SizeClass,
		SizeRange = pc.SizeRange,
		CustomField3 = pc.Status,
		StyleThemeID = pc.StyleThemeID
	
	FROM pPlanningConfig pc
	WHERE pStyleHeader.StyleID = @StyleID
		AND pc.PlanningConfigID = @PlanningConfigID

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06393', GetDate())
GO
