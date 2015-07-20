
ALTER PROCEDURE [dbo].[spx_StyleSourcingQuoteItemLogic_UPDATE]
(
@StyleQuoteItemID uniqueidentifier
)
AS 


--BEGIN

--		EXEC spx_LinePlanBusinessItem_QUEUE 
--		@StyleQuoteItemID = @StyleQuoteItemID,
--		@StyleID = @StyleID,
--		@LinePlanID = @LinePlanID, 
--		@LinePlanRangeID = @LinePlanRangeID,
--		@LinePlanAttributeItemID1 = @LinePlanAttributeItemID1, 
--		@LinePlanAttributeItemID2 = @LinePlanAttributeItemID2,
--		@LinePlanAttributeItemID3 = @LinePlanAttributeItemID3,
--		@LinePlanAttributeItemID4 = @LinePlanAttributeItemID4,
--		@StyleSeasonYearID = @StyleSeasonYearID,
--		@Cmd  = ''

--END 


-- UPDATE StyleQuoteItemVersion 
EXEC dbo.spx_StyleSourcingQuoteItemVersion_UPDATE  @StyleQuoteItemID = @StyleQuoteItemID

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01161', GetDate())
GO

