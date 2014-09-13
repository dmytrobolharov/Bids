IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingColorADD_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingColorADD_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
	SELECT StyleColorID FROM pStyleSourcingColor
	WHERE StyleSourcingID = @StyleSourcingID 
	AND StyleColorID IS NOT NULL
)

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03090'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03090', GetDate())

END
GO