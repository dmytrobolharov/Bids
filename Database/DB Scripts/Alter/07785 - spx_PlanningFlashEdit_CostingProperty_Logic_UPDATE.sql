IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningFlashEdit_CostingProperty_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningFlashEdit_CostingProperty_Logic_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_PlanningFlashEdit_CostingProperty_Logic_UPDATE]
(
	@StyleCostingHeaderID UNIQUEIDENTIFIER
	, @PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @MUser NVARCHAR(200)
	, @MDate DATETIME
	, @CalcType INT = 1 /* 0 - Fixed Markup, 1 - Fixed Price */
)
AS
BEGIN
	DECLARE @StyleID UNIQUEIDENTIFIER
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	
	SELECT @StyleID = pli.StyleID, @StyleSeasonYearID = pli.StyleSeasonYearID
	FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleID = ssy.StyleID AND pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleCostingHeader sch ON pli.StyleID = sch.StyleID AND pli.StyleSeasonYearID = sch.StyleSeasonYearID 
	WHERE pli.PlanningID = @PlanningID
		AND ssy.SeasonYearID = @SeasonYearID
		AND sch.StyleCostingHeaderID = @StyleCostingHeaderID
	
	EXEC spx_StyleCostingHeaderLogic_UPDATE @StyleID, @MUser, @MDate, @StyleSeasonYearID, @CalcType
	
	DECLARE @tmpStyleCostingID TABLE (N INT IDENTITY(0, 1), StyleCostingID UNIQUEIDENTIFIER)
	
	INSERT INTO @tmpStyleCostingID (StyleCostingID)
	SELECT StyleCostingID
	FROM pStyleCosting
	WHERE StyleCostingHeaderId = @StyleCostingHeaderID
	
	DECLARE @Row INT = 0
	DECLARE @Total INT = (SELECT COUNT(*) FROM @tmpStyleCostingID)
	DECLARE @StyleCostingID UNIQUEIDENTIFIER
	
	WHILE @Row < @Total
	BEGIN
		SELECT @StyleCostingID = StyleCostingID FROM @tmpStyleCostingID WHERE N = @Row
		EXEC spx_StyleCostingScenariosLogic_UPDATE @StyleCostingID
		EXEC spx_StyleCostingLogic_UPDATE2 @StyleCostingID
		SET @Row = @Row + 1
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07785', GetDate())
GO
