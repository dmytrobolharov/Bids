/****** Object:  StoredProcedure [dbo].[spx_Planning_StylesWithBOMs_Seasonal_SELECT]    Script Date: 06/05/2014 15:43:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_StylesWithBOMs_Seasonal_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_StylesWithBOMs_Seasonal_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Planning_StylesWithBOMs_Seasonal_SELECT]    Script Date: 06/05/2014 15:43:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_Planning_StylesWithBOMs_Seasonal_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@StyleSeasonYearIDs nVARCHAR(MAX)
AS
BEGIN
	
	SELECT * FROM pStyleHeader sh
	INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
	INNER JOIN dbo.fnx_Split(@StyleSeasonYearIDs, N',') styles ON ssy.StyleSeasonYearID = styles.value	
	ORDER BY sh.StyleNo
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07896', GetDate())
GO