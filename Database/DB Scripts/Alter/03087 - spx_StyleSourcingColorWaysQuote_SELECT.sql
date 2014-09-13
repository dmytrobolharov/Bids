IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingColorWaysQuote_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingColorWaysQuote_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingColorWaysQuote_SELECT] (
@StyleSourcingID UNIQUEIDENTIFIER
)
AS 
BEGIN 


/***************** OLD CODE **********************/
-- Comment: it was used when there was BOM in Sourcing
/**************************************************/   
	--SELECT a.StyleColorID ,  a.StyleColorName, a.MainColor , a.Sort , c.StyleQuoteItemID, c.StyleCostingType, d.StyleSourcingQuoteSchema, d.StyleCostingType 
	--FROM pStyleColorway a INNER JOIN  pStyleSourcingItem b ON a.StyleColorID = b.StyleColorID 
	--LEFT OUTER JOIN pStyleQuoteItem c ON  (b.StyleColorID = c.StyleColorID AND  b.StyleSourcingID  =  c.StyleSourcingID) 
	--INNER JOIN pStyleCostingType d ON c.StyleCostingType = d.StyleCostingTypeID
	--WHERE b.StyleSourcingID =  @StyleSourcingID  
	--AND b.StyleSet = 1  
	--GROUP BY a.StyleColorID ,  a.StyleColorName, a.MainColor , a.Sort , c.StyleQuoteItemID, c.StyleCostingType, d.StyleSourcingQuoteSchema, d.StyleCostingType  
	--ORDER BY a.Sort, a.StyleColorName 
/**************************************************/

	SELECT a.StyleColorID ,  a.StyleColorName, a.MainColor , a.Sort , c.StyleQuoteItemID, c.StyleCostingType, d.StyleSourcingQuoteSchema, d.StyleCostingType 
	FROM pStyleColorway a INNER JOIN  pStyleSourcingColor b ON a.StyleColorID = b.StyleColorID 
	LEFT OUTER JOIN pStyleQuoteItem c ON  (b.StyleColorID = c.StyleColorID AND  b.StyleSourcingID  =  c.StyleSourcingID) 
	INNER JOIN pStyleCostingType d ON c.StyleCostingType = d.StyleCostingTypeID
	WHERE b.StyleSourcingID =  @StyleSourcingID  
	ORDER BY a.Sort, a.StyleColorName 

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03087'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03087', GetDate())

END
GO