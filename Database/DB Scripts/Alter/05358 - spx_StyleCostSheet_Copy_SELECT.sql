IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostSheet_Copy_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostSheet_Copy_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCostSheet_Copy_SELECT]
	@StyleID UNIQUEIDENTIFIER
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
AS
BEGIN

	IF @StyleSeasonYearID IS NOT NULL
	BEGIN
		SELECT StyleCostingID, StyleCostingName + ' (' + StyleSeason + ' ' + StyleYear + ')' as StyleCostingName FROM pStyleCosting 
			INNER JOIN pStyleSeasonYear ON pStyleCosting.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleCosting.StyleID = @StyleID
		AND pStyleSeasonYear.StyleSeasonYearID <> @StyleSeasonYearID
		AND pStyleCosting.StyleCostingHeaderId IS NOT NULL
		ORDER BY pStyleCosting.CDate
	END
	ELSE
	BEGIN
		SELECT StyleCostingID, StyleCostingName FROM pStyleCosting 
		WHERE pStyleCosting.StyleID = @StyleID
		AND pStyleCosting.StyleCostingHeaderId IS NOT NULL
		ORDER BY pStyleCosting.CDate
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05358', GetDate())
GO
