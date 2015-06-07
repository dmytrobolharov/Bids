IF OBJECT_ID(N'[dbo].[spx_Planning_AutoGenerate_Logic_Update]') IS NOT NULL
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
		SubCategoryId = LOWER(CAST(pc.SubCategoryID AS NVARCHAR(50))),
		IntroSeasonYearID = @SeasonYearID,
		MUser = @MUser,
		MDate = @MDate,

		Description = pc.Description,
		SizeClassId = pc.SizeClassId,
		SizeRangeId = pc.SizeRangeId,
		CustomField3 = pc.Status,
		StyleThemeID = pc.StyleThemeID
	
	FROM pPlanningConfig pc
	WHERE pStyleHeader.StyleID = @StyleID
		AND pc.PlanningConfigID = @PlanningConfigID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10001', GetUTCDate())
GO
