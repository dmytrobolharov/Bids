IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingQuoteVariation_CHECK_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingQuoteVariation_CHECK_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
'***********************************************************************
' Object name	   : spx_StyleSourcingQuoteVariation_CHECK_INSERT
' Author           : 
' Created          : 
'
' Last Modified By : Oleg Pechenevsky
' Last Modified On : 02-02-2012
' Description      : Insert the StyleSourcing quote variation,
' Comments		   :
		#01  -	Artemio Gomez - December 11, 2009
				Add Parameter @OUTPUT INT with default = 1
				Add Parameter @StyleQuoteVariationID UNIQUEIDENTIFIER as an Output parameter
		#02  -  Oleg Pechenevsky - February 02, 2012
				#WI 6519 - Error popup when select colorway in sourcing
				Changed this stored procedure because creation of Quotes from Sourcing didn't work
				(now it will work like creation Quotes in RFQ Folder)
' Copyright        : (c) Yunique Solutions, Inc. All rights reserved.
'***********************************************************************
*/

CREATE PROCEDURE [dbo].[spx_StyleSourcingQuoteVariation_CHECK_INSERT] (
@StyleCostingID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleQuoteID UNIQUEIDENTIFIER,
@StyleDevelopmentID UNIQUEIDENTIFIER,
@TradePartnerID UNIQUEIDENTIFIER,
@CreatedBy nvarchar(200),
@CreatedDate DATETIME,
@OUTPUT INT = 1,
@StyleQuoteVariationID UNIQUEIDENTIFIER = NULL OUTPUT
)
AS

DECLARE @TradePartnerClass varchar(50)
DECLARE @TradePartnerCommission decimal(19,3) 
DECLARE @TradePartnerVendorCountry varchar(50)
DECLARE @TradePartnerState varchar(50)
DECLARE @TradePartnerCountry varchar(50)

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER

--DECLARE @StyleQuoteVariationID AS UNIQUEIDENTIFIER 

SELECT @StyleQuoteVariationID = StyleQuoteVariationID 
FROM  dbo.pStyleQuoteVariation  
WHERE StyleCostingID = @StyleCostingID 
AND StyleID =  @StyleID 
AND StyleQuoteID = @StyleQuoteID  

SELECT @StyleSeasonYearID = StyleSeasonYearID
FROM pStyleCosting WHERE StyleCostingID = @StyleCostingID


IF  @StyleQuoteVariationID IS NULL 
BEGIN 

	SET @StyleQuoteVariationID  = NEWID() 

	SELECT @TradePartnerClass = TradePartnerClass, 
			@TradePartnerCommission = TradePartnerCommision, 
			@TradePartnerState = State,
			@TradePartnerCountry = Country 
	FROM uTradePartner 
	WHERE TradePartnerID = @TradePartnerID


	/* Get initial info from pStyleCosting. */  
	DECLARE @StyleQuoteItemCustomField2 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField3 NVARCHAR(200)  
	DECLARE @StyleQuoteItemCustomField5 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField6 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField7 DECIMAL(18,5)  
	DECLARE @StyleQuoteItemCustomField8 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField9 DECIMAL(18,5)  
	DECLARE @StyleQuoteItemCustomField10 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField11 DECIMAL(18,5)  
	DECLARE @StyleQuoteItemCustomField12 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField13 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField14 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField15 DECIMAL(18,5)  
	DECLARE @StyleQuoteItemCustomField16 INT  
	DECLARE @StyleQuoteItemCustomField17 DECIMAL(18,5)  
	DECLARE @StyleQuoteItemCustomField18 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField19 DECIMAL(18,3)  
	DECLARE @StyleQuoteItemCustomField20 DECIMAL(18,3)  
  
	SELECT @StyleQuoteItemCustomField2 = ISNULL(StyleCostingCustomField15, 0)  
	 ,@StyleQuoteItemCustomField5 = ISNULL(StyleCostingCustomField6, 0)  
	 ,@StyleQuoteItemCustomField6 = ISNULL(StyleCostingCustomField16, 0)  
	 ,@StyleQuoteItemCustomField7 = ISNULL(StyleCostingCustomField7, 0)  
	 ,@StyleQuoteItemCustomField8 = ISNULL(StyleCostingCustomField8, 0)  
	 ,@StyleQuoteItemCustomField9 = ISNULL(StyleCostingCustomField9, 0)  
	 ,@StyleQuoteItemCustomField10 = ISNULL(StyleCostingCustomField10, 0)  
	 ,@StyleQuoteItemCustomField11 = ISNULL(StyleCostingCustomField11, 0)  
	 ,@StyleQuoteItemCustomField12 = ISNULL(StyleCostingCustomField12, 0)  
	 ,@StyleQuoteItemCustomField13 = ISNULL(StyleCostingCustomField13, 0)  
	 ,@StyleQuoteItemCustomField14 = ISNULL(StyleCostingCustomField14, 0)  
	 ,@StyleQuoteItemCustomField15 = ISNULL(StyleCostingCustomField23, 0)  
	 ,@StyleQuoteItemCustomField16 = ISNULL(StyleCostingCustomField19, 0)  
	 ,@StyleQuoteItemCustomField17 = ISNULL(StyleCostingCustomField18, 0)  
	 ,@StyleQuoteItemCustomField18 = ISNULL(StyleCostingCustomField20, 0)  
	 ,@StyleQuoteItemCustomField19 = ISNULL(StyleCostingCustomField21, 0)  
	 ,@StyleQuoteItemCustomField20 = ISNULL(StyleCostingCustomField22, 0)  
	FROM pStyleCosting  
	WHERE StyleCostingID = @StyleCostingID  

	/* Get initial info from pStyleCostingHeader. */  
	SELECT @StyleQuoteItemCustomField3 = ISNULL(StyleCostingCustomField3, 0)  
	FROM pStyleCostingHeader  
	WHERE StyleID = @StyleID  
	AND StyleSeasonYearID = @StyleSeasonYearID  
  
	/* Insert new record into pStyleQuoteVariation. */  
	INSERT INTO pStyleQuoteVariation(  
		StyleQuoteVariationID, StyleCostingID, StyleID, StyleCostingType, StyleCostingFreightTypeID, 
		StyleQuotaDutyID, StyleQuoteID, StyleDevelopmentID, TradePartnerID, CUser, CDate, MUser, MDate, StyleSeasonYearID,  
		StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField5,  
		StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, StyleQuoteItemCustomField8,  
		StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, StyleQuoteItemCustomField11,  
		StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14,  
		StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, StyleQuoteItemCustomField17,  
		StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, StyleQuoteItemCustomField20,  
		StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3,   
		StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6,   
		StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9,   
		StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12,   
		StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15,   
		StyleCostingCustomField16, StyleCostingCustomField18, StyleCostingCustomField19,   
		StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22,   
		StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25,   
		StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, 
		StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, 
		StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, 
		StyleCostingCustomField35, 
		BOMCost, BOLCost, BOLCurr
	)  
	SELECT  
		@StyleQuoteVariationID, StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, 
		StyleQuotaDutyID, @StyleQuoteID, @StyleDevelopmentID, @TradePartnerID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @StyleSeasonYearID,  
		@StyleQuoteItemCustomField2, @StyleQuoteItemCustomField3, @StyleQuoteItemCustomField5,  
		@StyleQuoteItemCustomField6, @StyleQuoteItemCustomField7, @StyleQuoteItemCustomField8,  
		@StyleQuoteItemCustomField9, @StyleQuoteItemCustomField10, @StyleQuoteItemCustomField11,  
		@StyleQuoteItemCustomField12, @StyleQuoteItemCustomField13, @StyleQuoteItemCustomField14,  
		@StyleQuoteItemCustomField15, @StyleQuoteItemCustomField16, @StyleQuoteItemCustomField17,  
		@StyleQuoteItemCustomField18, @StyleQuoteItemCustomField19, @StyleQuoteItemCustomField20,  
		ISNULL(StyleCostingCustomField1, 0), ISNULL(StyleCostingCustomField2, 0), ISNULL(StyleCostingCustomField3, 0),   
		ISNULL(StyleCostingCustomField4, 0), ISNULL(StyleCostingCustomField5, 0), ISNULL(StyleCostingCustomField6, 0),   
		ISNULL(StyleCostingCustomField7, 0), ISNULL(StyleCostingCustomField8, 0), ISNULL(StyleCostingCustomField9, 0),   
		ISNULL(StyleCostingCustomField10, 0), ISNULL(StyleCostingCustomField11, 0), ISNULL(StyleCostingCustomField12, 0),   
		ISNULL(StyleCostingCustomField13, 0), ISNULL(StyleCostingCustomField14, 0), ISNULL(StyleCostingCustomField15, 0),   
		ISNULL(StyleCostingCustomField16, 0), ISNULL(StyleCostingCustomField18, 0), ISNULL(StyleCostingCustomField19, 0),   
		ISNULL(StyleCostingCustomField20, 0), ISNULL(StyleCostingCustomField21, 0), ISNULL(StyleCostingCustomField22, 0),   
		ISNULL(StyleCostingCustomField23, 0), ISNULL(StyleCostingCustomField24, 0), StyleCostingCustomField25,   
		StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, 
		StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, 
		StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, 
		StyleCostingCustomField35, 
		BOMCost, BOLCost, BOLCurr
	FROM pStyleCosting  
	WHERE StyleCostingID = @StyleCostingID AND StyleID = @StyleID
	
	IF @TradePartnerClass = 1
		BEGIN
			UPDATE pStyleQuoteVariation SET
				StyleQuoteItemCustomField1 = @TradePartnerCountry
				--StyleQuoteItemCustomField9 = @TradePartnerCommission
			WHERE StyleID = @StyleID AND StyleCostingID = @StyleCostingID AND TradePartnerID=@TradePartnerID
		END
	ELSE
		BEGIN
			UPDATE pStyleQuoteVariation SET
				StyleQuoteItemCustomField1 = @TradePartnerCountry
				--StyleQuoteItemCustomField9 = @TradePartnerCommission
			WHERE StyleID = @StyleID AND StyleCostingID = @StyleCostingID AND TradePartnerID=@TradePartnerID
		END	
	
	--------------
	-- OLD CODE --
	--------------
	--INSERT INTO dbo.pStyleQuoteVariation
	--    (StyleQuoteVariationID, StyleCostingID, StyleID, StyleCostingType, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingCustomField1, StyleCostingCustomField2, 
	--    StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, 
	--    StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, 
	--    StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, 
	--    StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, 
	--    StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, 
	--    StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, 
	--    StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, StyleQuoteID, StyleDevelopmentID, TradePartnerID, CUser, 
	--    CDate, MUser, MDate, StyleSeasonYearID)
	--SELECT     @StyleQuoteVariationID AS StyleQuoteVariationID, StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingCustomField1, StyleCostingCustomField2, 
	--    StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, 
	--    StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, 
	--    StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, 
	--    StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, 
	--    StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, 
	--    StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, 
	--    StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, @StyleQuoteID, @StyleDevelopmentID, @TradePartnerID, 
	--    @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @StyleSeasonYearID
	--FROM         dbo.pStyleCosting
	--WHERE	  StyleID = @StyleID AND StyleCostingID = @StyleCostingID
	
	--IF @TradePartnerClass = 1
	--	BEGIN
	--		UPDATE pStyleQuoteVariation SET
	--			StyleCostingCustomField9 = @TradePartnerCommission,
	--			StyleQuoteItemCustomField3 = 2,
	--			StyleQuoteItemCustomField4 = @TradePartnerCountry
	--			StyleQuoteItemCustomField5 = @TradePartnerCountry
	--		WHERE StyleID = @StyleID AND StyleCostingID = @StyleCostingID AND TradePartnerID=@TradePartnerID
	--	END
	--ELSE
	--	BEGIN
	--		UPDATE pStyleQuoteVariation SET
	--			StyleCostingCustomField9 = @TradePartnerCommission,
	--			StyleQuoteItemCustomField3 = 2,
	--			StyleQuoteItemCustomField4 = @TradePartnerCountry
	--			StyleQuoteItemCustomField5 = @TradePartnerState
	--		WHERE StyleID = @StyleID AND StyleCostingID = @StyleCostingID AND TradePartnerID=@TradePartnerID
	--	END

END

IF @OUTPUT = 1
	SELECT StyleQuoteVariationID  = @StyleQuoteVariationID

GO




IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03098'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03098', GetDate())

END
GO