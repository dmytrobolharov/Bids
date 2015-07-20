/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYear_SELECT_API]    Script Date: 11/05/2013 13:25:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYear_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYear_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYear_SELECT_API]    Script Date: 11/05/2013 13:25:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleSeasonYear_SELECT_API](@StyleId uniqueidentifier)
AS 

SELECT pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYear, pStyleSeasonYear.SeasonYearID, pStyleSeasonYear.StyleSeasonYearID
FROM  pStyleSeasonYear INNER JOIN
  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
WHERE StyleID = @StyleID
ORDER BY pStyleSeasonYear.Sort --pSeasonYear.CurrentSeason DESC, pSeasonYear.Year DESC  , pSeasonYear.Season

--ORDER BY pSeasonYear.Sort DESC


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06525', GetDate())
GO
