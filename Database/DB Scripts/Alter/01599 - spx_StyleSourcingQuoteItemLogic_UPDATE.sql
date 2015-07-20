IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingQuoteItemLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSourcingQuoteItemLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingQuoteItemLogic_UPDATE](
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@ChangeTransID UNIQUEIDENTIFIER, 
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@RollUpLinePlan INT = 1 
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


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01599'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01599', GetDate())
END	

GO
