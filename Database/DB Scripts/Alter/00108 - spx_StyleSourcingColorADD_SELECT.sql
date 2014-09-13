
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingColorADD_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingColorADD_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_StyleSourcingColorADD_SELECT] (
@StyleSourcingID UNIQUEIDENTIFIER 
)
AS 

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSourcing Where StyleSourcingID = @StyleSourcingID


select b.StyleColorID ,  b.StyleColorNo,  b.StyleColorName,  b.MainColor 
from pStyleColorwaySeasonYear a 
INNER JOIN pStyleColorway b ON b.StyleColorID = a.StyleColorwayID
Where a.StyleSeasonYearID = @StyleSeasonYearID
AND a.StylecolorwayID NOT IN (
	SELECT distinct StyleColorID FROM pStyleSourcingItem 
	WHERE StyleSourcingID = @StyleSourcingID 
	AND StyleColorID IS NOT NULL
)




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '108', GetDate())

GO





