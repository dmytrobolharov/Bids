IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYear_AVAILABLE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYear_AVAILABLE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSeasonYear_AVAILABLE]  (
@StyleID UNIQUEIDENTIFIER
)
AS 

SELECT  SeasonYearID , [Season] + ' ' + [Year] AS SeasonYear FROM  pSeasonYear 
WHERE SeasonYearID NOT IN (SELECT SeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID) AND Active = 1
ORDER BY Sort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03760', GetDate())
GO
