IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemAgentLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemAgentLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteItemAgentLogic_UPDATE]
(
	@StyleQuoteItemID uniqueidentifier,
	@StyleID uniqueidentifier = NULL, 
	@LinePlanID uniqueidentifier = NULL, 
	@LinePlanRangeID uniqueidentifier = NULL, 
	@LinePlanAttributeItemID1 uniqueidentifier = NULL, 
	@LinePlanAttributeItemID2 uniqueidentifier= NULL, 
	@LinePlanAttributeItemID3 uniqueidentifier= NULL, 
	@LinePlanAttributeItemID4 uniqueidentifier = NULL
)
AS 

Select 1

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '161', GetDate())
GO

