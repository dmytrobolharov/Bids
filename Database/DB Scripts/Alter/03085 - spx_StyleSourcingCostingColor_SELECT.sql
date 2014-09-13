IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingCostingColor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingCostingColor_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingCostingColor_SELECT] (
@StyleSourcingID UNIQUEIDENTIFIER  
)
AS
BEGIN 

/***************** OLD CODE **********************/
-- Comment: it was uset when there was BOM in Sourcing
/**************************************************/    

	--SELECT a.StyleColorID ,  a.StyleColorName, a.MainColor , a.Sort 
 --   FROM pStyleColorway a INNER JOIN  pStyleSourcingItem b ON a.StyleColorID = b.StyleColorID 
 --   WHERE b.StyleSourcingID = @StyleSourcingID
 --   AND b.StyleSet = 1  
	--AND a.StyleColorID  NOT IN ( 
	--		SELECT StyleColorID  
	--		FROM pStyleQuoteItem  
	--		WHERE StyleSourcingID = @StyleSourcingID
	--) 
 --   GROUP BY a.StyleColorID ,  a.StyleColorName, a.MainColor , a.Sort 
 --   ORDER BY a.Sort, a.StyleColorName 
/**************************************************/


	SELECT a.StyleColorID, a.StyleColorName, a.MainColor, a.Sort
	FROM pStyleColorway a INNER JOIN  pStyleSourcingColor b ON a.StyleColorID = b.StyleColorID 
    WHERE b.StyleSourcingID = @StyleSourcingID
	AND a.StyleColorID  NOT IN ( 
			SELECT StyleColorID  
			FROM pStyleQuoteItem  
			WHERE StyleSourcingID = @StyleSourcingID
	) 
    ORDER BY a.Sort, a.StyleColorName 


END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03085'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03085', GetDate())

END
GO