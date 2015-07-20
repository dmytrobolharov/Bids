IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleQuoteItemLogic_UPDATE') 
	DROP PROCEDURE spx_StyleQuoteItemLogic_UPDATE
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemLogic_UPDATE]    Script Date: 06/20/2011 17:12:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
Comments:

#01 - Ryan Cabanas - July 31, 2009
	Burberry has changed the 'Landed Duty Price' calculation.

#02 - Ryan Cabanas - July 31, 2009
	Burberry has changed the 'Act Flow Through Margin' calculation.

#03 - Ryan Cabanas - July 31, 2009
	Burberry has changed the 'Retail Price GBP' calculation.

#04 - Ryan Cabanas - July 31, 2009
	Burberry has added a new 'Target Ex-Factory Local' calculation.

#05 - Ryan Cabanas - August 17, 2009
	Burberry wants to change the logic of where to pull Currency Type.
If the Agent is of Partner Type "Vendor", pull the Currency type from
'uTradePartner.CurrencyType'.  If the Agent is of Partner Type "Agent", pull the
Currency type from 'uTradePartnerVendor.CurrencyType'.

#06 - Ryan Cabanas - August 17, 2009
	Burberry wants to change the whole update logic of 'Currency', 'Agent Commission %',
'Freight Rate %', and 'Duty %'.

#07 - Ryan Cabanas - August 17, 2009
	Since Burberry changed a calculation, I need to check for another "divide by zero" case.

#08 - Ryan Cabanas - August 17, 2009
	Burberry wants to auto-populate the "Vendor Target Margin" field.  It's
'pStyleQuoteItem.StyleQuoteItemCustomField24'.

#09 - Ryan Cabanas - August 19, 2009
	Burberry has changed their mind about the 'UK Wholesale' field.  They now want this field,
which is 'pStyleQuoteItem.StyleQuoteItemCustomField26', to be pulled from the costing header
area and now longer updated here.  Commenting out the update here.

#10 - Ryan Cabanas - August 19, 2009
	Burberry also wants the 'UK Wholesale' field value to pull from the costing header area
when you click the "Save" button here at the quote page.  Need to make a variable to grab
the value and then update it to the quote area.

#11 - Ryan Cabanas - August 21, 2009
	Burberry has changed calculations again.  These changes actually occurred on, or prior,
to July 31, 2009 because the calculations that were in this procedure before July 31, 2009
no longer matched the calculations given to us in the Excel Spreadsheet on July 31, 2009.
	Need to make a variable for field "StyleQuoteItemCustomField26" for easier reading and
use.

#12 - Ryan Cabanas - August 21, 2009
	The calc for "Act Wholesale Margin" has changed.

#13 - Ryan Cabanas - August 21, 2009
	The variable used to hold the results for the "Act Wholesale Margin" was set to decimal(18, 3),
but should be decimal(18,4) because it's a percentage.  Needed to change this in the table field
settings too.

#14 - Clayton Parker - August 25, 2009
	Burberry would like the Wholesale Target Margin(pStyleQuoteItem.StyleQuoteItemCustomField25)
in the quote to pull from the style costings Wholesale Margin at the costing header
(pStyleCostingHeader.StyleCostingCustomField5).

#15 - Ryan Cabanas - September 1, 2009
	Need to fix a couple of 'divide by zero' errors.

#16 - Ryan Cabanas - September 3, 2009
	The 'Freight Rate %' and 'Duty%' need to pull from either 'uTradePartner' or 'uTradePartnerVendor',
based on if the Agent is of Partner Type "Agent", or "Vendor".  Same logic as Comment #05 above.
Added CASE to do this.

#17 - Ryan Cabanas - September 8, 2009
	Burberry wants the 'Target Ex-Factory Local' equation changed again.  The "IF" condition that was
added for this equation in Comment #15 is no longer needed, but the Comment #15 notation will be left
behind.  Commenting out the original equation/work that was there.

#18 - Ryan Cabanas - September 23, 2009
	Do 'divide by zero' error checking for all division calculations.

#19 - Ryan Cabanas - October 8, 2009
	For some reason, the '@TargetRetailFOB' variable was being used in the IF statement, but it's not
being used in the calculation, so I'm commenting out this variable because it shouldn't be included
in the IF.

#20 - Ryan Cabanas - October 8, 2009
	Burberry wants the 'Target Ex Factory Local' calculation changed.  Commented out the old
calculation.

#21 - Artemio Gomez - October 20, 2009
	Another divide by zero error that needed to be handled.

#22 - Ryan Cabanas - October 21, 2009
	Update procedure to pull costing values from the correct seasonal costing header record.
*/


Create PROCEDURE [dbo].[spx_StyleQuoteItemLogic_UPDATE]
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



--------------/**************/
--------------/*Testing.	*/
--------------/**************/
--------------DECLARE @StyleQuoteItemID uniqueidentifier
--------------DECLARE @StyleID uniqueidentifier
--------------DECLARE @LinePlanID uniqueidentifier
--------------DECLARE @LinePlanRangeID uniqueidentifier
--------------DECLARE @LinePlanAttributeItemID1 uniqueidentifier
--------------DECLARE @LinePlanAttributeItemID2 uniqueidentifier
--------------DECLARE @LinePlanAttributeItemID3 uniqueidentifier
--------------DECLARE @LinePlanAttributeItemID4 uniqueidentifier
--------------
--------------SET @StyleQuoteItemID = '66EFDC57-6D24-43E9-8B69-47F9094B31A3'
--------------SET @StyleID = '0C14ABB5-770B-41A7-BF76-D1539C375B38'
--------------SET @LinePlanID = 'CAF55604-5505-46F6-B499-91B6B7842212'
--------------SET @LinePlanRangeID = '523B3844-BECB-4B86-99B7-795A5451341F'
--------------SET @LinePlanAttributeItemID1 = '285A8A56-BE1C-4FE4-A38D-1C84547A1526'
--------------SET @LinePlanAttributeItemID2 = '5378A0FD-F52B-4489-BF13-DE39C290F583'
--------------SET @LinePlanAttributeItemID3 = 'F1F9C1AB-FF4D-4CE4-9707-836456D888F5'
--------------SET @LinePlanAttributeItemID4 = NULL



--------------DECLARE @StyleQuoteItemID uniqueidentifier
--------------SET @StyleQuoteItemID = '213f3bdd-ac6c-42f6-960c-67075a36d003'

------------/***********************************************
------------New statements added by Ryan Cabanas on 8/26/08.
------------************************************************/

------------/*****Update 'Auto Pull' values.*****/

------------/*Variables.*/
------------DECLARE @StyleSet int
------------DECLARE @StyleSourcingID uniqueidentifier
------------DECLARE @StyleColorID uniqueidentifier
------------DECLARE @StyleQuoteItemCustomField6 nvarchar(200)		--Currenty Type
------------DECLARE @StyleQuoteItemCustomField7_Rate decimal(18,3)	--Exhange Rate template (Value), not uniqieidentifier
------------DECLARE @StyleQuoteItemCustomField8	money				--Vendor Quote
------------DECLARE @StyleQuoteItemCustomField9 money				--Vendor Quote in GBP
------------DECLARE @StyleQuoteItemCustomField10 money				--BOM Rollup Price
------------DECLARE @StyleQuoteItemCustomField11 decimal(18,4)		--Agent Commission %
------------DECLARE @StyleQuoteItemCustomField12 decimal(18,4)		--Freight Rate %
------------DECLARE @StyleQuoteItemCustomField13 decimal(18,4)		--Duty %
--------------DECLARE @StyleQuoteItemCustomField14 decimal(18,4)		--Target FirstCost
------------DECLARE @StyleQuoteItemCustomField14 decimal(18,4)		--Average Target FOB GBP
------------DECLARE @StyleQuoteItemCustomField15 money				--Landed Duty Price
------------DECLARE @StyleQuoteItemCustomField16 decimal(18,4)		--Margin Markup
------------DECLARE @StyleQuoteItemCustomField17 money				--Retail Price GBP
------------DECLARE @StyleQuoteItemCustomField18 money				--Retail Price USD
------------DECLARE @StyleQuoteItemCustomField19 money				--Retail Price HKD
------------DECLARE @StyleQuoteItemCustomField20 money				--Retail Price EUR
------------DECLARE @StyleQuoteItemCustomField27 money				--Retail Price GBP USER
------------DECLARE @StyleQuoteItemCustomField28 money				--Retail Price USD USER
------------DECLARE @StyleQuoteItemCustomField29 money				--Retail Price HKD USER
------------DECLARE @StyleQuoteItemCustomField30 money				--Retail Price EUR USER
------------DECLARE @ExchangeRate_USD decimal(18,3)					--USD Exchange Rate
------------DECLARE @ExchangeRate_HKD decimal(18,3)					--HKD Exchange Rate
------------DECLARE @ExchangeRate_EUR decimal(18,3)					--EUR Exchange Rate

--------------DECLARE @StyleID UNIQUEIDENTIFIER
--------------DECLARE @LinePlanID UNIQUEIDENTIFIER
--------------DECLARE @LinePlanItemID UNIQUEIDENTIFIER
--------------DECLARE @StyleCategoryId UNIQUEIDENTIFIER

------------DECLARE @AverageTargetFOB DECIMAL(18,3)
------------DECLARE @InitialGrossMarginWHS DECIMAL(18,3)
------------DECLARE @TargetRetailFOB DECIMAL(18,3)
------------DECLARE @WhsPriceGBP DECIMAL(18,3)

--------------Comment #03, 04
------------DECLARE @StyleQuoteItemCustomField24 decimal(18,4)		--Vendor Margin		--Comment #03
------------DECLARE @StyleQuoteItemCustomField31 decimal(18,3)		--Target Ex Factory Local	--Comment #04


--------------Comment #05
------------DECLARE @TradePartnerID uniqueidentifier
------------DECLARE @TradePartnerVendorID uniqueidentifier
------------DECLARE @TradePartnerType int
------------DECLARE @CurrencyType nvarchar(5)

--------------Comment #10
------------DECLARE @StyleCostingCustomField6 decimal(18,3)	--Target Wholesale Price (pStyleCostingHeader.StyleCostingCustomField6)

--------------Comment #11
------------DECLARE @StyleQuoteItemCustomField26 decimal(18,3)	--UK Wholesale

--------------Comment #14
------------DECLARE @StyleCostingCustomField5 decimal (18,3) --Wholesale Margin

--------------Comment #22
------------DECLARE @StyleCostingID uniqueidentifier
------------DECLARE @StyleSeasonYearID uniqueidentifier



--------------Comment #05
------------BEGIN
------------	--Get the Agent and Vendor IDs.
------------	SELECT @TradePartnerID = TradePartnerID
------------		,@TradePartnerVendorID = TradePartnerVendorID
------------	FROM pStyleQuoteItem
------------	WHERE StyleQuoteItemID = @StyleQuoteItemID

------------	--Get 'Partner Type' for Agent.
------------	SELECT @TradePartnerType = TradePartnerType
------------	FROM uTradePartner
------------	WHERE TradePartnerID = @TradePartnerID

------------	IF(@TradePartnerType = 2)	--"Vendor" Partner Type
------------		BEGIN
------------			SELECT @CurrencyType = CurrencyType
------------			FROM uTradePartner
------------			WHERE TradePartnerID = @TradePartnerID
------------		END
------------	ELSE IF(@TradePartnerType = 1)	--"Agent" Partner Type
------------		BEGIN
------------			SELECT @CurrencyType = CurrencyType
------------			FROM uTradePartnerVendor
------------			WHERE TradePartnerVendorID = @TradePartnerVendorID
------------		END
------------END


--------------SELECT 
--------------	@StyleID = StyleID
--------------FROM pStyleQuoteItem 
--------------WHERE StyleQuoteItemID = @StyleQuoteItemID

--------------SELECT 
--------------	@LinePlanID = LinePlanID, 
--------------	@LinePlanItemID = LinePlanItemID , 
--------------	@StyleCategoryID = StyleCategory 
--------------FROM pStyleHeader 
--------------WHERE StyleID = @StyleID


------------SELECT @StyleID = StyleID
------------	,@StyleCostingID = StyleCostingID		--Comment #22
------------FROM pStyleQuoteItem
------------WHERE StyleQuoteItemID = @StyleQuoteItemID


--------------Comment #22
------------/*Get the '@StyleSeasonYearID' from 'pStyleCosting'.*/
------------SELECT @StyleSeasonYearID = StyleSeasonYearID
------------FROM pStyleCosting
------------WHERE StyleCostingID = @StyleCostingID


------------IF @LinePlanID IS NULL
------------BEGIN

------------	SELECT @LinePlanRangeID = LinePlanRangeID  FROM pLinePlanItem  WHERE StyleID = @StyleID 

------------	SELECT @LinePlanID = LinePlanID, 
------------	@LinePlanAttributeItemID1 = LinePlanAttributeItemID1, @LinePlanAttributeItemID2 = LinePlanAttributeItemID2,
------------	@LinePlanAttributeItemID3 = LinePlanAttributeItemID3, @LinePlanAttributeItemID4 = LinePlanAttributeItemID4
------------	from pLineplanrange 
------------	WHERE LinePlanRangeID = @LinePlanRangeID 
------------	AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'

------------END 


------------IF @LinePlanID IS NOT NULL 
------------BEGIN 

------------	-- Average Target FOB
------------	SELECT @AverageTargetFOB = LinePlanBusPnCh1 FROM pLinePlanBusiness 
------------	WHERE (LinePlanAttributeItemID1 = @LinePlanAttributeItemID1) 
------------		AND (LinePlanAttributeItemID2 = @LinePlanAttributeItemID2) 
------------		AND (LinePlanAttributeItemID3 = @LinePlanAttributeItemID3)
------------		AND (LinePlanID = @LinePlanID) 
------------		AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000006'
------------	ORDER BY LinePlanFinancialSort 

------------	-- Initial Gross Margin WHS %
------------	SELECT @InitialGrossMarginWHS = LinePlanBusPnCh1 FROM pLinePlanBusiness 
------------	WHERE (LinePlanAttributeItemID1 = @LinePlanAttributeItemID1) 
------------		AND (LinePlanAttributeItemID2 = @LinePlanAttributeItemID2) 
------------		AND (LinePlanAttributeItemID3 = @LinePlanAttributeItemID3)
------------		AND (LinePlanID = @LinePlanID) 
------------		AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000013'
------------	ORDER BY LinePlanFinancialSort 

------------END 



--------------SELECT @InitialGrossMarginWHS AS InitialGrossMarginWHS


--------------Retail Price GBP USER -- CDP 3/6/09
------------SELECT 
------------@StyleQuoteItemCustomField27 = StyleCostingCustomField1, --Retail Price GBP User
------------@StyleQuoteItemCustomField28 = StyleCostingCustomField7, --Retail Price USD User
------------@StyleQuoteItemCustomField29 = StyleCostingCustomField8, --Retail Price HKD User
------------@StyleQuoteItemCustomField30 = StyleCostingCustomField9, --Retail Price EUR User
------------@StyleCostingCustomField6 = StyleCostingCustomField6,		--Comment #10
------------@StyleCostingCustomField5 = StyleCostingCustomField5	 --Comment #14
------------FROM pStyleCostingHeader
------------WHERE StyleID = @StyleID
------------	AND StyleSeasonYearID = @StyleSeasonYearID			--Comment #22


--------------Target Retail FOB
------------SELECT 
------------	@TargetRetailFOB = StyleCostingCustomField1
------------	,@StyleQuoteItemCustomField14 = StyleCostingCustomField2
------------	,@StyleQuoteItemCustomField16 = StyleCostingCustomField3
------------FROM pStyleCostingHeader
------------WHERE StyleID = @StyleID
------------	AND StyleSeasonYearID = @StyleSeasonYearID			--Comment #22


--------------SELECT * FROM pStyleCostingHeader WHERE StyleID = @styleID
--------------SELECT @TargetRetailFOB, @StyleQuoteItemCustomField14, @StyleQuoteItemCustomField16

--------------SELECT * FROM pLinePlanBusiness 
--------------WHERE LinePlanID = @LinePlanID AND 
--------------LinePlanAttributeItemID3 = @StyleCategoryID 
--------------ORDER BY LinePlanFinancialSort 


--------------Comment #06 (This whole update has been changed by Comment #06.)
------------/*Set the 'Agent Commission %', 'Freight Rate %', 'Duty %', and 'Currency'  fields.*/
------------UPDATE pStyleQuoteItem
------------SET	pStyleQuoteItem.StyleQuoteItemCustomField11 = pTradePartnerVendorRateItem.Commission
------------	,pStyleQuoteItem.StyleQuoteItemCustomField12 =
------------		CASE	--Comment #16
------------			WHEN	@TradePartnerType = 2	THEN	uTradePartner.Freight		--"Vendor" Partner Type
------------			ELSE									uTradePartnerVendor.Freight	--"Agent" Partner Type
------------		END
------------	,pStyleQuoteItem.StyleQuoteItemCustomField13 =
------------		CASE	--Comment #16
------------			WHEN	@TradePartnerType = 2	THEN	uTradePartner.Duty			--"Vendor" Partner Type
------------			ELSE									uTradePartnerVendor.Duty	--"Agent" Partner Type
------------		END
------------	,pStyleQuoteItem.StyleQuoteItemCustomField6 = @CurrencyType		--Comment #05
------------	,pStyleQuoteItem.StyleQuoteItemCustomField24 = pTradePartnerVendorRateItem.Margin		--Comment #08
------------FROM pStyleQuoteItem
------------	LEFT OUTER JOIN pStyleHeader ON	pStyleQuoteItem.StyleID = pStyleHeader.StyleID
------------	LEFT OUTER JOIN pStyleSourcing ON	pStyleQuoteItem.StyleSourcingID = pStyleSourcing.StyleSourcingID
------------	LEFT OUTER JOIN pStyleSeasonYear ON	pStyleSourcing.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
------------	LEFT OUTER JOIN pTradePartnerVendorRate ON	pStyleSeasonYear.StyleSeason = pTradePartnerVendorRate.Season
------------												AND pStyleSeasonYear.StyleYear = pTradePartnerVendorRate.[Year]
------------												AND pStyleQuoteItem.TradePartnerVendorID = pTradePartnerVendorRate.TradePartnerVendorID
------------	LEFT OUTER JOIN pTradePartnerVendorRateItem ON	pTradePartnerVendorRate.TradePartnerVendorRateID = pTradePartnerVendorRateItem.TradePartnerVendorRateID
------------													AND pStyleHeader.StyleCategory = pTradePartnerVendorRateItem.StyleCategoryID
------------	LEFT OUTER JOIN uTradePartner ON	pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID
------------	LEFT OUTER JOIN uTradePartnerVendor	ON	pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID	--Comment #16
------------WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID


------------/*Set the 'BOM Rollup Price'.*/
------------BEGIN
------------	/*Get the necessary IDs to call another procedure that calculates the BOM Rollup.*/
------------	SELECT TOP 1
------------		@StyleSet = pStyleSourcingItem.StyleSet
------------		,@StyleSourcingID = pStyleQuoteItem.StyleSourcingID
------------		,@StyleColorID = pStyleQuoteItem.StyleColorID
------------	FROM pStyleQuoteItem
------------		LEFT OUTER JOIN pStyleSourcingItem ON	pStyleQuoteItem.StyleSourcingID = pStyleSourcingItem.StyleSourcingID
------------	WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID

------------	/*Get the total of the materials and their quantity times price.*/
------------	--EXEC spx_StyleSourcingRollUp_SELECT @StyleSourcingID, @StyleColorID, @StyleSet, @StyleQuoteItemCustomField10 OUTPUT

------------	SELECT @StyleQuoteItemCustomField10 = SUM (Qty * MaterialPrice )
------------	FROM pStyleSourcingItem 
------------	where StyleSourcingId = @StyleSourcingID
------------	AND StylecolorID = @StylecolorID
------------	AND StyleSet = 1 
------------	AND BOM = 1

------------	IF @StyleQuoteItemCustomField10 IS NULL 
------------		SET @StyleQuoteItemCustomField10 = 0 

------------	/*Update the 'pStyleQuoteItem' table with the caculated BOM Rollup value.*/
------------	UPDATE pStyleQuoteItem
------------	SET StyleQuoteItemCustomField10 = @StyleQuoteItemCustomField10
------------	WHERE StyleQuoteItemID = @StyleQuoteItemID
------------END


------------/*Set the 'Target First Cost' and 'Margin Markup' from the Costing Header section.*/
-------------- pStyleQuoteItem.StyleQuoteItemCustomField14 = StyleQuoteItemCustomField14
------------UPDATE pStyleQuoteItem
------------SET pStyleQuoteItem.StyleQuoteItemCustomField14 =  @StyleQuoteItemCustomField14 --@AverageTargetFOB
------------	,pStyleQuoteItem.StyleQuoteItemCustomField16 = @StyleQuoteItemCustomField16 
------------	,pStyleQuoteItem.StyleQuoteItemCustomField27 = @StyleQuoteItemCustomField27 --CDP 3/6/09
------------	,pStyleQuoteItem.StyleQuoteItemCustomField28 = @StyleQuoteItemCustomField28 --CDP 3/6/09
------------	,pStyleQuoteItem.StyleQuoteItemCustomField29 = @StyleQuoteItemCustomField29 --CDP 3/6/09
------------	,pStyleQuoteItem.StyleQuoteItemCustomField30 = @StyleQuoteItemCustomField30 --CDP 3/6/09
------------FROM pStyleQuoteItem
------------WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID


------------/*****Begin formula calculations.*****/

------------/*Get some values for calculations.*/
------------SELECT
------------	@StyleQuoteItemCustomField10 = StyleQuoteItemCustomField10		--BOM Rollup Price
------------	,@StyleQuoteItemCustomField11 = StyleQuoteItemCustomField11		--Agent Commission %
------------	,@StyleQuoteItemCustomField12 = StyleQuoteItemCustomField12		--Freight Rate %
------------	,@StyleQuoteItemCustomField13 = StyleQuoteItemCustomField13		--Duty %
------------	,@StyleQuoteItemCustomField16 = StyleQuoteItemCustomField16		--Margin Markup
------------	,@StyleQuoteItemCustomField24 = StyleQuoteItemCustomField24		--Vendor Margin		--Comment #03
------------FROM pStyleQuoteItem
------------WHERE StyleQuoteItemID = @StyleQuoteItemID


------------/*Calculate the 'Vendor Quote in GBP' value.*/
------------BEGIN
------------	/*Get the 'Currency Type' and 'Vendor Quote' values.*/
------------	SELECT
------------		@StyleQuoteItemCustomField6 = StyleQuoteItemCustomField6	--Currenty Type
------------		,@StyleQuoteItemCustomField8 = StyleQuoteItemCustomField8	--Vendor Quote
------------	FROM pStyleQuoteItem
------------	WHERE StyleQuoteItemID = @StyleQuoteItemID

------------	/*Get the 'Exchange Rate' value.*/
------------	SELECT @StyleQuoteItemCustomField7_Rate = sExchangeRateItem.Rate
------------	FROM pStyleQuoteItem
------------		LEFT OUTER JOIN sExchangeRateItem ON	pStyleQuoteItem.StyleQuoteItemCustomField7 = sExchangeRateItem.ExchangeRateID
------------	WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID
------------		AND sExchangeRateItem.CurrencyType = @StyleQuoteItemCustomField6

------------	--Comment #18
------------	/*Calculate the 'Vendor Quote in GBP'.*/
------------	IF(@StyleQuoteItemCustomField7_Rate IS NOT NULL AND @StyleQuoteItemCustomField7_Rate > 0)
------------		BEGIN
------------			SET @StyleQuoteItemCustomField9 = @StyleQuoteItemCustomField8 / @StyleQuoteItemCustomField7_Rate
------------		END
------------	ELSE
------------		BEGIN
------------			SET @StyleQuoteItemCustomField9 = 0
------------		END
------------END


--------------Comment #01
------------/*Calculate the 'Landed Duty Price' field.*/
------------SET @StyleQuoteItemCustomField15 =
------------	@StyleQuoteItemCustomField9 +
------------	(@StyleQuoteItemCustomField9 * @StyleQuoteItemCustomField11) +
------------	(@StyleQuoteItemCustomField9 * @StyleQuoteItemCustomField12) +
------------	(@StyleQuoteItemCustomField9 * @StyleQuoteItemCustomField13)


--------------Comment #03, #18
------------/*Calculate the 'Retail Price GBP' field.*/
------------IF(@StyleQuoteItemCustomField16 IS NOT NULL AND @StyleQuoteItemCustomField16 < 1)
------------	BEGIN
------------		SET	@StyleQuoteItemCustomField17 = @StyleQuoteItemCustomField15	/ (1 - @StyleQuoteItemCustomField16)	--Comment #03
------------	END
------------ELSE
------------	BEGIN
------------		SET	@StyleQuoteItemCustomField17 = 0
------------	END


------------/*Calculate the 'Retail Price' for the three other currency types: 'USD', 'HKD', and 'EUR'.*/
------------BEGIN
------------	/*Get the exchange rate for the 'USD'.*/
------------	SELECT @ExchangeRate_USD = sExchangeRateItem.Rate
------------	FROM pStyleQuoteItem
------------		LEFT OUTER JOIN sExchangeRateItem ON	pStyleQuoteItem.StyleQuoteItemCustomField7 = sExchangeRateItem.ExchangeRateID
------------	WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID
------------		AND sExchangeRateItem.CurrencyType = 'USD'

------------	/*Get the exchange rate for the 'HKD'.*/
------------	SELECT @ExchangeRate_HKD = sExchangeRateItem.Rate
------------	FROM pStyleQuoteItem
------------		LEFT OUTER JOIN sExchangeRateItem ON	pStyleQuoteItem.StyleQuoteItemCustomField7 = sExchangeRateItem.ExchangeRateID
------------	WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID
------------		AND sExchangeRateItem.CurrencyType = 'HKD'

------------	/*Get the exchange rate for the 'EUR'.*/
------------	SELECT @ExchangeRate_EUR = sExchangeRateItem.Rate
------------	FROM pStyleQuoteItem
------------		LEFT OUTER JOIN sExchangeRateItem ON	pStyleQuoteItem.StyleQuoteItemCustomField7 = sExchangeRateItem.ExchangeRateID
------------	WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID
------------		AND sExchangeRateItem.CurrencyType = 'EUR'

------------	--Comment #18
------------	/*Calculate 'Retail Prices'.*/
------------	IF(@StyleQuoteItemCustomField16 IS NOT NULL AND @StyleQuoteItemCustomField16 < 1)
------------		BEGIN
------------			SET @StyleQuoteItemCustomField18 = (@StyleQuoteItemCustomField15 * @ExchangeRate_USD) / (1 - @StyleQuoteItemCustomField16)	--USD
------------			SET @StyleQuoteItemCustomField19 = (@StyleQuoteItemCustomField15 * @ExchangeRate_HKD) / (1 - @StyleQuoteItemCustomField16)	--HKD
------------			SET @StyleQuoteItemCustomField20 = (@StyleQuoteItemCustomField15 * @ExchangeRate_EUR) / (1 - @StyleQuoteItemCustomField16)	--EUR
------------		END
------------	ELSE
------------		BEGIN
------------			SET @StyleQuoteItemCustomField18 = 0
------------			SET @StyleQuoteItemCustomField19 = 0
------------			SET @StyleQuoteItemCustomField20 = 0
------------		END
------------END


--------------Comment #18
------------/*Update the calculated values back to the 'pStyleQuoteItem' table.*/
------------IF(@InitialGrossMarginWHS IS NOT NULL AND @InitialGrossMarginWHS < 1)
------------	BEGIN
------------		SET @WhsPriceGBP = @StyleQuoteItemCustomField15/(1-@InitialGrossMarginWHS)
------------	END
------------ELSE
------------	BEGIN
------------		SET @WhsPriceGBP = 0
------------	END


------------DECLARE @VAL1 DECIMAL(18,3)
------------DECLARE @VAL2 DECIMAL(18,4)	--Comment #13


--------------Comment #11
------------SET @StyleQuoteItemCustomField26 = @StyleCostingCustomField6	--@StyleQuoteItemCustomField26 is "UK Wholesale".


--------------Comment #02, #18, #19, #21
------------IF (/*@TargetRetailFOB > 0  AND*/ @StyleQuoteItemCustomField27 IS NOT NULL 
------------		AND @StyleQuoteItemCustomField15 IS NOT NULL
------------		AND @StyleQuoteItemCustomField27 > 0)
------------	SET @VAL1 = ((@StyleQuoteItemCustomField27 / 1.175) - @StyleQuoteItemCustomField15) / (@StyleQuoteItemCustomField27 / 1.175)	--Comment #02
------------ELSE 
------------	SET @VAL1 = 0


--------------Comment #12, #18
------------IF (@StyleQuoteItemCustomField26 > 0  AND @StyleQuoteItemCustomField26 IS NOT NULL)
------------	SET  @VAL2 = (@StyleQuoteItemCustomField26-@StyleQuoteItemCustomField15)/@StyleQuoteItemCustomField26
------------ELSE 
------------	SET  @VAL2 = 0 


----------------Comment #04, #11, #17
--------------/*Calculate Target Ex-Factory Local*/
--------------IF((@StyleQuoteItemCustomField8 > 0) AND (@StyleQuoteItemCustomField11 > 0 OR @StyleQuoteItemCustomField12 > 0 OR @StyleQuoteItemCustomField13 > 0))	--Comment #15
--------------	BEGIN
--------------		SET @StyleQuoteItemCustomField31 =	((@StyleQuoteItemCustomField26 * (1 - @StyleQuoteItemCustomField24)) * @StyleQuoteItemCustomField7_Rate) /
--------------											((@StyleQuoteItemCustomField8 * @StyleQuoteItemCustomField11) +
--------------											(@StyleQuoteItemCustomField8 * @StyleQuoteItemCustomField12) +
--------------											(@StyleQuoteItemCustomField8 * @StyleQuoteItemCustomField13))
--------------	END
--------------ELSE
--------------	BEGIN
--------------		SET @StyleQuoteItemCustomField31 = 0
--------------	END


--------------Comment #17, #18
------------/*Calculate Target Ex-Factory Local*/
------------IF(@StyleQuoteItemCustomField11 IS NOT NULL 
------------	AND @StyleQuoteItemCustomField12 IS NOT NULL
------------	AND @StyleQuoteItemCustomField13 IS NOT NULL)
------------	BEGIN
------------		--Comment #20 (old calculation - new calculation is below)
------------		--SET @StyleQuoteItemCustomField31 =	((@StyleQuoteItemCustomField26 * (1 - @StyleQuoteItemCustomField24)) * @StyleQuoteItemCustomField7_Rate) / (1 + @StyleQuoteItemCustomField11 + @StyleQuoteItemCustomField12 + @StyleQuoteItemCustomField13)

------------		--Comment #20
------------		SET @StyleQuoteItemCustomField31 =	((((@StyleQuoteItemCustomField26 * (1 - @StyleQuoteItemCustomField24)) * @StyleQuoteItemCustomField7_Rate) / (1 + @StyleQuoteItemCustomField12)) / (1 + @StyleQuoteItemCustomField13)) / (1 + @StyleQuoteItemCustomField11)
------------	END
------------ELSE
------------	BEGIN
------------		SET @StyleQuoteItemCustomField31 = 0
------------	END


------------/*Update quote.*/
------------UPDATE pStyleQuoteItem
------------SET	StyleQuoteItemCustomField9 = @StyleQuoteItemCustomField9
------------	,StyleQuoteItemCustomField15 = @StyleQuoteItemCustomField15
------------	,StyleQuoteItemCustomField17 = @StyleQuoteItemCustomField17
------------	,StyleQuoteItemCustomField18 = @StyleQuoteItemCustomField18
------------	,StyleQuoteItemCustomField19 = @StyleQuoteItemCustomField19
------------	,StyleQuoteItemCustomField20 = @StyleQuoteItemCustomField20
------------	,StyleQuoteItemCustomField21 = @TargetRetailFOB
------------	,StyleQuoteItemCustomField22 = @VAL1
------------	,StyleQuoteItemCustomField25 = @StyleCostingCustomField5	--Comment #14
------------	,StyleQuoteItemCustomField26 = @StyleCostingCustomField6		--Comment #09, #10
------------	,StyleQuoteItemCustomField23 = @VAL2
------------	,StyleQuoteItemCustomField31 = @StyleQuoteItemCustomField31		--Target Ex-Factory Local	--Comment #04, #11
------------WHERE StyleQuoteItemID = @StyleQuoteItemID





















/************************************************************
Original statements commented out by Ryan Cabanas on 8/26/08.
*************************************************************/

--DECLARE @StyleId uniqueidentifier
DECLARE @StyleCostingId uniqueidentifier
DECLARE @StyleQuoteDutyId uniqueidentifier
DECLARE @TradePartnerID uniqueidentifier
DECLARE @TradePartnerVendorID uniqueidentifier

DECLARE @ComissionPerc decimal(19,3) --StyleCostingCustomField9
DECLARE @GarmentWgt decimal(19,3) --StyleCostingCustomField2
DECLARE @AvgFirstCost decimal(19,3) --StyleQuoteItemCustomField1
DECLARE @RetailCost decimal(19,3) --StyleQuoteItemCustomField1
DECLARE @MiscCost  decimal(19,3) --StyleCostingCustomField4  
DECLARE @RoyaltyPerc decimal(19,3) --StyleCostingCustomField8 
DECLARE @RoyaltyCode int
DECLARE @VariancePerc decimal(19,3) --StyleCostingCustomField10
DECLARE @DutyPerc decimal(19,3) --StyleCostingCustomField11
DECLARE @Surcharge decimal(19,3) --StyleCostingCustomField12
DECLARE @BrokerHarborFee decimal(19,3) --StyleCostingCustomField13
DECLARE @CountryCode varchar(50) --StyleQuoteItemCustomField4,
DECLARE @StateCode varchar(50) --StyleQuoteItemCustomField5,
DECLARE @StyleCostingType int
DECLARE @TradePartnerState varchar(2)
DECLARE @NumberOfUnit decimal(19,3)
DECLARE @FreightMethod decimal(19,3)

DECLARE @CartonHeight decimal(19,3) --StyleQuoteItemCustomField14
DECLARE @CartonLeght decimal(19,3) --StyleQuoteItemCustomField15 
DECLARE @CartonWidth decimal(19,3) --StyleQuoteItemCustomField16
DECLARE @UnitPerCarton decimal(19,3) --StyleQuoteItemCustomField17
DECLARE @VolCubicFeet decimal(19,3) --StyleQuoteItemCustomField18
DECLARE @ContainerSize varchar(10) --StyleQuoteItemCustomField12

DECLARE @HomeCost varchar(10)

--Preference Table
DECLARE @PrefImportVariance decimal(19,3)
DECLARE @PrefDomesticVariance decimal(19,3)
DECLARE @PrefIndirectVariance decimal(19,3)

SELECT @PrefImportVariance = ImportVariance, @PrefDomesticVariance = DomesticVariance, @PrefIndirectVariance = IndirectVariance FROM pStyleCostingPreference

DECLARE @StyleQuoteItemShare  INT 

--select @StyleQuoteItemShare as StyleQuoteItemShare

SELECT 
	@StyleId = ISNULL(StyleId,'{00000000-0000-0000-0000-000000000000}'), 
	@StyleQuoteDutyId = ISNULL(StyleQuotaDutyId,'{00000000-0000-0000-0000-000000000000}'),
	@TradePartnerID = ISNULL(TradePartnerID,'{00000000-0000-0000-0000-000000000000}'), 
	@TradePartnerVendorID = ISNULL(TradePartnerVendorID,'{00000000-0000-0000-0000-000000000000}'),  
	@StyleCostingType = ISNULL(StyleCostingType,0),		
	@AvgFirstCost = cast(COALESCE(StyleQuoteItemCustomField1,0) as decimal(19,3)),			
	@RetailCost = CAST(COALESCE(StyleCostingCustomField1,0) as decimal(19,3)),
	@RoyaltyCode = CAST(COALESCE(StyleQuoteItemCustomField3,0) as int),
	@CountryCode = ISNULL(StyleQuoteItemCustomField4,''),
	@StateCode = StyleQuoteItemCustomField5,
	@MiscCost = ISNULL(StyleCostingCustomField4,0),
	@RoyaltyPerc = ISNULL(StyleCostingCustomField8,0),
	@ComissionPerc = ISNULL(StyleCostingCustomField9,0),
	@VariancePerc = ISNULL(StyleCostingCustomField10,0),
	@DutyPerc = ISNULL(StyleCostingCustomField11,0),
	@Surcharge = ISNULL(StyleCostingCustomField12,0),
	@GarmentWgt = ISNULL(StyleCostingCustomField2,0),
	@BrokerHarborFee = ISNULL(StyleCostingCustomField13,0),
	@NumberOfUnit = ISNULL(StyleCostingCustomField18,0),
	@FreightMethod = StyleCostingCustomField16 ,
	@StyleQuoteItemShare	= StyleQuoteItemShare
FROM  pStyleQuoteItem
WHERE  (StyleQuoteItemID = @StyleQuoteItemID)


/*********************************************************************************************************************************************************************************
IF StyleQuoteItemShare = 1  check if the style is shared with the TradePartner 
*/ 
select @StyleQuoteItemShare as StyleQuoteItemShare1




IF @StyleQuoteItemShare = 1  AND @TradePartnerID  IS NOT NULL
BEGIN 
	DECLARE  @StyleDevelopmentID  UNIQUEIDENTIFIER
 	SELECT  @StyleDevelopmentID   = DevelopmentID   FROM pStyleHeader WHERE StyleID = @StyleId

	IF ( SELECT COUNT(*)  FROM pStyleTeam WHERE StyleID = @StyleId AND TeamID = @TradePartnerID  )  =  0
	BEGIN 
		INSERT INTO pStyleTeam ( StyleTeamID ,  TeamID , StyleDevelopmentId, StyleID ,  TradePartner  ) 
		VALUES ( NEWID(),   @TradePartnerID ,  @StyleDevelopmentID ,   @StyleId , 1 ) 
	END 

END 


/********************************************************************************************************************************************************************************/



SELECT * FROM  pStyleQuoteItem WHERE (StyleQuoteItemID = @StyleQuoteItemID)

DECLARE @TradePartnerClass varchar(50)
DECLARE @TradePartnerCommission decimal(19,3) --StyleCostingCustomField9
DECLARE @TradePartnerVendorCountry varchar(50)

SELECT @TradePartnerClass = TradePartnerClass, @TradePartnerCommission = TradePartnerCommision, @TradePartnerState = State FROM uTradePartner WHERE TradePartnerID = @TradePartnerID

SELECT @TradePartnerVendorCountry = Country 
FROM uTradePartnerVendor WHERE TradePartnerVendorID = @TradePartnerVendorID

DECLARE @RoyaltyCost int
DECLARE @Commision decimal(19,3)
DECLARE @Variance decimal(19,3)
DECLARE @Duty decimal(19,3) 
DECLARE @DutySurcharge decimal(19,3)
DECLARE @BrokerHarbor decimal(19,3)
DECLARE @ImportCost decimal(19,3)
DECLARE @DomesticCost decimal(19,3)
DECLARE @IndirectCost decimal(19,3)

--IF @RoyaltyCode = 1 SET @RoyaltyCost = @AvgFirstCost * @RoyaltyPerc
--IF @RoyaltyCode = 2 SET @RoyaltyCost = @RetailCost * @RoyaltyPerc

SET @Commision = @AvgFirstCost *  @ComissionPerc --@TradePartnerCommission
SET @Variance = @AvgFirstCost * @VariancePerc
SET @Duty = @AvgFirstCost * @DutyPerc --NOT apllicable for DOMEST AND INDIRECT
SET @DutySurcharge = @Surcharge * @GarmentWgt --NOT apllicable for DOMEST AND INDIRECT
SET @BrokerHarbor = @AvgFirstCost * @BrokerHarborFee --NOT apllicable for DOMEST AND INDIRECT
SET @ImportCost = @AvgFirstCost + @RoyaltyCost + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor 

IF @RoyaltyCode = 1
	BEGIN
	SET @ImportCost = ((@AvgFirstCost * @RoyaltyPerc)+ @AvgFirstCost) + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor 
	END
ELSE IF @RoyaltyCode = 2
	BEGIN
	SET @ImportCost = ((@RetailCost * @RoyaltyPerc) + @AvgFirstCost) + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor 
	END
ELSE
	BEGIN
	SET @ImportCost = 0
	END


SELECT (@AvgFirstCost + (@RetailCost * @RoyaltyPerc)) AS R
SELECT @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor AS F
SELECT ((@RetailCost * @RoyaltyPerc) + @AvgFirstCost) + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor  AS Royal
--Transportation Cost
DECLARE @AirRate decimal(19,3)
DECLARE @BoatRate decimal(19,3)
DECLARE @AirCostperUnit decimal(19,3)
DECLARE @BoatCostperUnit decimal(19,3)
DECLARE @Container40 decimal(19,3)
DECLARE @Container20 decimal(19,3)
DECLARE @ContainerLCL decimal(19,3)
DECLARE @ContainerVolumeAir decimal(19,3) 

DECLARE @CostCode varchar(2)
DECLARE @DomesticRate decimal(19,6)
DECLARE @DomesticCostperUnit decimal(19,3)
DECLARE @DomesticTLC decimal(19,3)
DECLARE @DomesticMargin decimal(19,3)


SELECT @AirRate = AirRate, @BoatRate = SeaRate, @Container40 = Container40, @Container20 = Container20, @ContainerLCL = @ContainerLCL, @ContainerVolumeAir = @ContainerVolumeAir   
FROM uCountry WHERE CountryCode = @CountryCode

--IF @FreightMethod IS NULL OR  @FreightMethod = 0
BEGIN
	DECLARE @StyleCategoryId uniqueidentifier
	SELECT @StyleCategoryId = StyleCategory FROM pStyleHeader WHERE StyleID = @StyleID
	SELECT @FreightMethod = StyleCategoryFreightType FROM pStyleCategory WHERE StyleCategoryId = @StyleCategoryId
END

DECLARE @StyleFreightAirID uniqueidentifier
DECLARE @StyleFreightBoatID uniqueidentifier
DECLARE @StyleFreightDomesticID uniqueidentifier
DECLARE @StyleFreightIndirectID uniqueidentifier

SELECT @StyleFreightAirID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Air'
SELECT @StyleFreightBoatID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Boat'
SELECT @StyleFreightDomesticID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Domestic'
SELECT @StyleFreightIndirectID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Indirect'

IF(@StyleFreightAirID IS NULL)
	BEGIN
		SET @StyleFreightAirID = NEWID()
	END

IF(@StyleFreightBoatID IS NULL)
	BEGIN
		SET @StyleFreightBoatID = NEWID()
	END

IF(@StyleFreightDomesticID IS NULL)
	BEGIN
		SET @StyleFreightDomesticID = NEWID()
	END

IF(@StyleFreightIndirectID IS NULL)
	BEGIN
		SET @StyleFreightIndirectID = NEWID()
	END


DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID


IF @StyleCostingType = '1' OR @StyleCostingType = '2'
BEGIN

--DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID

	--AIR
	SET @AirCostperUnit = @GarmentWgt * @AirRate

	DECLARE @AirTLC decimal(19,3)
	SET @AirTLC = @ImportCost + @AirCostperUnit

	SELECT @AirRate AS AirRate, @AirCostperUnit AS AirCost, @AirTLC AS AirTLC, @FreightMethod AS FM

	DECLARE @AirMargin decimal(19,3)
	IF @RetailCost = 0
		BEGIN
		SET @AirMargin = 0
		END
	ELSE
		BEGIN
		SET @AirMargin = (@RetailCost - @AirTLC) / @RetailCost
		END

	--Update Air Freight Cost	
	IF @FreightMethod = 1
		BEGIN

			BEGIN 
				INSERT INTO pStyleQuoteItemFreightCost
					(StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)
				VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @AirCostperUnit , @AirRate, 1, 1)
			END

			UPDATE pStyleQuoteItem SET 
				StyleQuoteItemCustomField6 = 1,
				--StyleQuoteItemCustomField7 = @AirMargin,	
				StyleQuoteItemCustomField8 = @AirTLC,		
				StyleQuoteItemCustomField9 = @AirCostperUnit,		
				StyleQuoteItemCustomField10 = @AirRate,
				StyleCostingCustomField16 = @FreightMethod					
			WHERE StyleQuoteItemID = @StyleQuoteItemID
		END
	ELSE
		BEGIN
			INSERT INTO pStyleQuoteItemFreightCost
				(StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)
			VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @AirCostperUnit , @AirRate, 2, 0)
		END



	--BOAT 
	SET @BoatCostperUnit = (@GarmentWgt/16) * @BoatRate

	DECLARE @BoatTLC decimal(19,3)
	SET @BoatTLC = @ImportCost + @BoatCostperUnit

	DECLARE @BoatMargin decimal(19,3)
	IF @RetailCost = 0
		BEGIN
		SET @BoatMargin = 0
		END
	ELSE
		BEGIN
		SET @BoatMargin = (@RetailCost - @BoatTLC) / @RetailCost
		END

	SELECT @BoatRate AS BoatRate, @BoatCostperUnit AS BoatCost, @BoatTLC AS BoatTLC, @FreightMethod	AS FM

	
			
	--Update Sea Freight Cost	
	IF @FreightMethod = 2
		BEGIN
			INSERT INTO pStyleQuoteItemFreightCost
				(StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)
			VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @BoatCostperUnit , @BoatRate, 1, 1)
		
			UPDATE pStyleQuoteItem SET 
				StyleQuoteItemCustomField6 = 2,
				--StyleQuoteItemCustomField7 = @BoatMargin,	
				StyleQuoteItemCustomField8 = @BoatTLC,		
				StyleQuoteItemCustomField9 = @BoatCostperUnit,		
				StyleQuoteItemCustomField10 = @BoatRate,
				StyleCostingCustomField16 = @FreightMethod						
			WHERE StyleQuoteItemID = @StyleQuoteItemID
		END
	ELSE
		BEGIN
		
			INSERT INTO pStyleQuoteItemFreightCost
				(StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)
			VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @BoatCostperUnit , @BoatRate, 2, 0)
		
		END

END

--DOMESTIC 
ELSE IF @StyleCostingType = '3'  --OR @TradePartnerClass = '3'
BEGIN

--DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID

	IF @StateCode = '' SET @StateCode = @TradePartnerState

	SELECT @CostCode = CostCode FROM uState WHERE StateCode = @StateCode	
	SELECT @DomesticRate = CostRate FROM pStyleCostingDomesticRate WHERE CostCode = @CostCode

	SET @DomesticCost = @AvgFirstCost + @MiscCost + @Variance 
	SET @DomesticCostperUnit = @GarmentWgt * @DomesticRate 

	
	SET @DomesticTLC = @DomesticCost + @DomesticCostperUnit
	
	
	IF @RetailCost = 0
		BEGIN
		SET @DomesticMargin = 0
		END
	ELSE
		BEGIN
		SET @DomesticMargin = (@RetailCost - @DomesticTLC) / @RetailCost
		END	

	INSERT INTO pStyleQuoteItemFreightCost
		(StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)
	VALUES (@StyleFreightDomesticID, @StyleQuoteItemId, 'Domestic', @DomesticMargin, @DomesticTLC, @DomesticCostperUnit , @DomesticRate, 1, 1)

	--Update Domestic Freight Cost	
	IF @FreightMethod = 3
	BEGIN
		UPDATE pStyleQuoteItem SET 
			StyleQuoteItemCustomField6 = 3,
			--StyleQuoteItemCustomField7 = @DomesticMargin,	
			StyleQuoteItemCustomField8 = @DomesticTLC,		
			StyleQuoteItemCustomField9 = @DomesticCostperUnit,		
			StyleQuoteItemCustomField10 = @DomesticRate					
		WHERE StyleQuoteItemID = @StyleQuoteItemID
	END


END


--Indirect
ELSE IF @StyleCostingType = '4'
BEGIN

--DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID

	SET @DomesticCost = @AvgFirstCost + @MiscCost + @Variance 

	SET @DomesticCostperUnit = @GarmentWgt 

	SET @DomesticTLC = @DomesticCost 
	
	IF @RetailCost = 0
		BEGIN
		SET @DomesticMargin = 0
		END
	ELSE
		BEGIN
		SET @DomesticMargin = (@RetailCost - @DomesticTLC) / @RetailCost
		END	

	INSERT INTO pStyleQuoteItemFreightCost
		(StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)
	VALUES (@StyleFreightIndirectID, @StyleQuoteItemId, 'Indirect', @DomesticMargin, @DomesticTLC, @DomesticCostperUnit , @DomesticRate, 2, 1)

			
	--Update Indirect Freight Cost	
	IF @FreightMethod = 4
	BEGIN
		UPDATE pStyleQuoteItem SET 
			StyleQuoteItemCustomField6 = 4,
			--StyleQuoteItemCustomField7 = @DomesticMargin,	
			StyleQuoteItemCustomField8 = @DomesticTLC,		
			StyleQuoteItemCustomField9 = @DomesticCostperUnit,		
			StyleQuoteItemCustomField10 = @DomesticRate					
		WHERE StyleQuoteItemID = @StyleQuoteItemID
	END

END


Go
  
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01537', GetDate())
GO







