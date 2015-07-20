/****** Object:  StoredProcedure [dbo].[spx_MaterialNew_SeasonYearSearch_SELECT]    Script Date: 05/24/2013 13:11:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNew_SeasonYearSearch_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNew_SeasonYearSearch_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_MaterialNew_SeasonYearSearch_SELECT]    Script Date: 05/24/2013 13:11:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialNew_SeasonYearSearch_SELECT]
	@SearchCondition NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER
AS
BEGIN
	SET @SearchCondition = '%' + @SearchCondition + '%'
	
	;WITH Colors AS (
		SELECT Season, Year, SeasonYearID, 
		ROW_NUMBER() OVER (PARTITION BY Season, Year ORDER BY SeasonYearID) AS RowNumber
		FROM pSeasonYear
		WHERE (Year LIKE @SearchCondition OR Season LIKE @SearchCondition) AND NOT SeasonYearID IN (SELECT SeasonYearID FROM tmpMaterialSeasonYear WHERE MaterialID = @MaterialID )
	)
	SELECT * FROM Colors WHERE RowNumber = 1
	ORDER BY Season, Year
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05745', GetDate())
GO
