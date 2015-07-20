IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingColorWays_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingColorWays_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleSourcingColorWays_SELECT] (
@StyleSourcingID UNIQUEIDENTIFIER
)
AS 
BEGIN 

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSourcing WHERE StyleSourcingID = @StyleSourcingID

	SELECT a.StyleColorID ,  a.StyleColorName, a.MainColor , a.Sort , c.StyleQuoteItemID, c.StyleCostingType, 
	d.StyleSourcingQuoteSchema, d.StyleCostingType 
	FROM pStyleColorway a 
	INNER JOIN pStyleSourcingItem b ON a.StyleColorID = b.StyleColorID 
	INNER JOIN pStyleColorwaySeasonYear e ON e.StyleColorwayID = a.StyleColorID
	LEFT OUTER JOIN pStyleQuoteItem c ON  (b.StyleColorID = c.StyleColorID AND  b.StyleSourcingID  =  c.StyleSourcingID) 
	LEFT OUTER JOIN pStyleCostingType d ON c.StyleCostingType = d.StyleCostingTypeID
	WHERE b.StyleSourcingID =  @StyleSourcingID  
	AND e.StyleSeasonYearID =  @StyleSeasonYearID
	AND b.StyleSet = 1  
	GROUP BY a.StyleColorID ,  a.StyleColorName, a.MainColor , a.Sort , c.StyleQuoteItemID, c.StyleCostingType, d.StyleSourcingQuoteSchema, d.StyleCostingType  
	ORDER BY a.Sort, a.StyleColorName 

END 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '061', GetDate())

GO