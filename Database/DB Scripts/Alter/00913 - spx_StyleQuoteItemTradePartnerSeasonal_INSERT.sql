


IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemTradePartnerSeasonal_INSERT]'))
DROP PROCEDURE spx_StyleQuoteItemTradePartnerSeasonal_INSERT
GO

CREATE  PROCEDURE spx_StyleQuoteItemTradePartnerSeasonal_INSERT
(@StyleQuoteItemID uniqueidentifier,
@StyleQuoteVariationID uniqueidentifier,
@StyleID uniqueidentifier,
@SeasonYearID uniqueidentifier,
@TradePartnerVendorID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime)
AS 


/************************/
/*Declare variables.	*/
/************************/
DECLARE @StyleQuoteId UNIQUEIDENTIFIER
DECLARE @StyleQuoteDueDate DATETIME
DECLARE @StyleCostingTypeID INT
DECLARE @StyleCostingID UNIQUEIDENTIFIER
--DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
DECLARE @StyleCostingHeaderID UNIQUEIDENTIFIER

DECLARE @pStyleQuoteItem_StyleQuoteItemCustomField2 DECIMAL(18,3)
DECLARE @pStyleQuoteItem_StyleQuoteItemCustomField3 NVARCHAR(200)
DECLARE @pStyleQuoteItem_StyleQuoteItemCustomField4 NVARCHAR(200)
DECLARE @pStyleQuoteItem_StyleQuoteItemCustomField5 DECIMAL(18,3)
DECLARE @pStyleQuoteItem_StyleQuoteItemCustomField6 DECIMAL(18,3)
DECLARE @pStyleQuoteItem_StyleQuoteItemCustomField11 DECIMAL(18,5)



/************************/
/*Get initial values.	*/
/************************/

/*Get the 'StyleQuoteId' to get the RFQ Due Date and 'StyleCostingID' and 'StyleCostingTypeID'.*/
SELECT @StyleQuoteId = StyleQuoteId
	,@StyleCostingID = StyleCostingID
	,@StyleCostingTypeID = StyleCostingType
FROM pStyleQuoteVariation
WHERE StyleQuoteVariationId = @StyleQuoteVariationId


/*Get the 'StyleQuoteDueDate' to use for the 'StyleQuoteItemDueDate'.*/
SELECT @StyleQuoteDueDate = StyleQuoteDueDate
FROM pStyleQuote
WHERE StyleQuoteId = @StyleQuoteId


/*Get the 'StyleId' and 'StyleSeasonYearId'.*/
SELECT @StyleId = StyleId
	,@StyleSeasonYearID = StyleSeasonYearID
FROM pStyleCosting
WHERE StyleCostingID = @StyleCostingID


/*Get the 'StyleCostingHeaderID'.*/
SELECT @StyleCostingHeaderID = StyleCostingHeaderID
FROM pStyleCostingHeader
WHERE StyleID = @StyleID
	AND StyleSeasonYearID = @StyleSeasonYearID


/********************************/
/*Logic for initial inserts.	*/
/********************************/
--IF (@StyleCostingTypeID = 1)	--Import
	BEGIN
		/*Initial pulls from costing header.*/
		SELECT @pStyleQuoteItem_StyleQuoteItemCustomField2 = ISNULL(StyleCostingCustomField1, 0)
			,@pStyleQuoteItem_StyleQuoteItemCustomField6 = ISNULL(StyleCostingCustomField2, 0)
		FROM pStyleCostingHeader
		WHERE StyleCostingHeaderId = @StyleCostingHeaderId
		
		
		/*Initial pulls from quote item.*/
		SELECT @pStyleQuoteItem_StyleQuoteItemCustomField3 = StyleQuoteItemCustomField34
			,@pStyleQuoteItem_StyleQuoteItemCustomField4 = StyleQuoteItemCustomField35
			,@pStyleQuoteItem_StyleQuoteItemCustomField5 = ISNULL(StyleQuoteItemCustomField30, 0)
			,@pStyleQuoteItem_StyleQuoteItemCustomField11 = ISNULL(StyleQuoteItemCustomField32, 0)
		FROM pStyleQuoteItem
		WHERE StyleQuoteItemId = @StyleQuoteItemId
		
	
		/*Add record.*/
		INSERT INTO pStyleQuoteItem(
			StyleQuoteItemID, StyleQuoteID, StyleQuotaDutyID, StyleQuoteItemStatusId, TradePartnerID, TradePartnerVendorID,
			StyleCostingID, StyleCostingType, StyleID, StyleDevelopmentID, StyleQuoteVariationId, CUser, CDate,
			MUser, MDate, StyleCostingFreightTypeID, StyleQuoteItemDueDate,
			StyleQuoteItemCustomField2, StyleQuoteItemCustomField3,
			StyleQuoteItemCustomField4, StyleQuoteItemCustomField5,
			StyleQuoteItemCustomField6, StyleQuoteItemCustomField11, StyleSeasonYearID
		)
		SELECT
			@StyleQuoteItemID, StyleQuoteID, StyleQuotaDutyID, 0, TradePartnerID, @TradePartnerVendorID,
			StyleCostingID, StyleCostingType, StyleID, StyleDevelopmentID, @StyleQuoteVariationId, @CreatedBy, @CreatedDate,
			@CreatedBy, @CreatedDate, StyleCostingFreightTypeID, @StyleQuoteDueDate,
			@pStyleQuoteItem_StyleQuoteItemCustomField2, @pStyleQuoteItem_StyleQuoteItemCustomField3,
			@pStyleQuoteItem_StyleQuoteItemCustomField4, @pStyleQuoteItem_StyleQuoteItemCustomField5,
			@pStyleQuoteItem_StyleQuoteItemCustomField6, @pStyleQuoteItem_StyleQuoteItemCustomField11, @StyleSeasonYearID
		FROM    pStyleQuoteVariation
		WHERE  StyleQuoteVariationID = @StyleQuoteVariationID
	END

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '913', GetDate())
GO 




