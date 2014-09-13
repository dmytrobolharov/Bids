

IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteVariationSeasonal_INSERT]'))
DROP PROCEDURE spx_StyleQuoteVariationSeasonal_INSERT
GO



CREATE PROCEDURE [dbo].[spx_StyleQuoteVariationSeasonal_INSERT]
(@StyleCostingID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleQuoteID uniqueidentifier,
@StyleDevelopmentID uniqueidentifier,
@TradePartnerID uniqueidentifier,
@SeasonYearID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime)
AS


/************************************************************************/
/*Add a record to pStyleQuoteVariation if one does not already exist.	*/
/************************************************************************/


DECLARE @StyleSeasonYearID uniqueidentifier
SET @StyleSeasonYearID = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID) 

IF  (SELECT Count(*) FROM  dbo.pStyleQuoteVariation  
		WHERE StyleCostingID = @StyleCostingID AND StyleID = @StyleID AND StyleQuoteID = @StyleQuoteID 
		AND StyleSeasonYearID = @StyleSeasonYearID) =  0 
	BEGIN
		INSERT INTO pStyleQuoteVariation(
			StyleCostingID, StyleID, StyleCostingType, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleQuoteID,
			StyleDevelopmentID, TradePartnerID, CUser, CDate, MUser, MDate, StyleSeasonYearID
		)
		SELECT
			StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, @StyleQuoteID,
			@StyleDevelopmentID, @TradePartnerID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @StyleSeasonYearID
		FROM pStyleCosting
		WHERE StyleCostingID = @StyleCostingID
	END

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '912', GetDate())
GO 

