IF EXISTS (select * from sysobjects where id = object_id('spx_StyleCostingTypeLogic_CopyFrom_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_StyleCostingTypeLogic_CopyFrom_SELECT
GO


CREATE PROCEDURE spx_StyleCostingTypeLogic_CopyFrom_SELECT(
@StyleID UNIQUEIDENTIFIER,
@StyleSeasonYearID UNIQUEIDENTIFIER, 
@SourceStyleID UNIQUEIDENTIFIER,
@SourceStyleSeasonYearID UNIQUEIDENTIFIER  
)
AS 

	
	
	
	SELECT c.Season, c.Year, d.StyleCostingType, a.StyleCostingTypeID, a.StyleCostingID
	FROM dbo.pStyleCosting a
	INNER JOIN dbo.pStyleSeasonYear b ON a.StyleSeasonYearID =  b.StyleSeasonYearID
	INNER JOIN dbo.pSeasonYear  c ON c.SeasonYearID = b.SeasonYearID
	INNER JOIN dbo.pStyleCostingType  d ON d.StyleCostingTypeID = a.StyleCostingTypeID
	WHERE a.StyleSeasonYearID = @SourceStyleSeasonYearID
	AND a.StyleCostingTypeID NOT  IN ( 
		SELECT StyleCostingTypeID FROM dbo.pStyleCosting WHERE StyleSeasonYearID = @StyleSeasonYearID 
	)
	ORDER BY c.Year, c.Season
	

go