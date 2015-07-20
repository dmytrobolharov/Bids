IF OBJECT_ID(N'[dbo].[rpx_Style_QuoteSearch_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Style_QuoteSearch_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_QuoteSearch_SELECT]
(
	@Season nvarchar(200)
	,@Year nvarchar(200)
)
AS


--Variables
DECLARE @Flag int
DECLARE @SQLStrBody nvarchar(Max)
DECLARE @SQLStrWhere nvarchar(4000)


--Put the string together for the body of the query.
SET @SQLStrBody = 
		'SELECT
			pStyleQuoteItem.StyleQuoteItemID AS StyleQuoteItemID
			,pStyleQuoteItem.StyleID AS StyleID
			,pStyleQuoteItem.StyleQuoteItemNo
			,pStyleQuoteItem.StyleQuoteItemStatusId
			,pStyleQuoteItemStatus.Custom AS StyleQuoteItemStatus
			,pStyleQuoteItem.StyleQuoteVariationId
			,pStyleQuoteItem.StyleQuoteID
			,pStyleQuoteItem.StyleQuotaDutyID
			,pStyleQuoteItem.StyleDevelopmentID
			,pStyleQuoteItem.StyleQuoteTradePartnerID
			,pStyleQuoteItem.StyleCostingID
			,pStyleQuoteItem.StyleCostingType
			,pStyleCostingType.StyleCostingType AS StyleCostingTypeName
			,pStyleQuoteItem.StyleCostingFreightTypeID
			,pStyleQuoteItem.TradePartnerID
			,pStyleQuoteItem.TradePartnerVendorID
			,uTradePartner.TradePartnerName
			,uTradePartnerVendor.VendorName
			,pStyleQuoteItem.StyleQuoteItemCustomField1
			,pStyleQuoteItem.StyleQuoteItemCustomField2
			,pStyleQuoteItem.StyleQuoteItemCustomField3
			,pStyleQuoteItem.StyleQuoteItemCustomField4
			,pStyleQuoteItem.StyleQuoteItemCustomField5
			,pStyleQuoteItem.StyleQuoteItemCustomField6
			,pStyleQuoteItem.StyleQuoteItemCustomField8
			,pStyleQuoteItem.StyleQuoteItemCustomField9
			,pStyleQuoteItem.StyleQuoteItemCustomField10
			,pStyleQuoteItem.StyleQuoteItemCustomField11
			,pStyleQuoteItem.StyleQuoteItemCustomField12
			,pStyleQuoteItem.StyleQuoteItemCustomField13
			,pStyleQuoteItem.StyleQuoteItemCustomField14
			,pStyleQuoteItem.StyleQuoteItemCustomField15
			,pStyleQuoteItem.StyleQuoteItemCustomField16
			,pStyleQuoteItem.StyleQuoteItemCustomField17
			,pStyleQuoteItem.StyleQuoteItemCustomField18
			,pStyleQuoteItem.StyleQuoteItemCustomField19
			,pStyleQuoteItem.StyleQuoteItemCustomField7
			,pStyleQuoteItem.StyleQuoteItemCustomField20
			,pStyleQuoteItem.StyleQuoteItemCustomField21
			,pStyleQuoteItem.StyleQuoteItemCustomField22
			,pStyleQuoteItem.StyleQuoteItemCustomField23
			,pStyleQuoteItem.StyleQuoteItemCustomField24
			,pStyleQuoteItem.StyleQuoteItemCustomField25
			,pStyleQuoteItem.StyleQuoteItemCustomField26
			,pStyleQuoteItem.StyleQuoteItemCustomField27
			,pStyleQuoteItem.StyleQuoteItemCustomField28
			,pStyleQuoteItem.StyleQuoteItemCustomField29
			,pStyleQuoteItem.StyleQuoteItemCustomField30
			,pStyleQuoteItem.StyleCostingCustomField1
			,pStyleQuoteItem.StyleCostingCustomField2
			,pStyleQuoteItem.StyleCostingCustomField3
			,pStyleQuoteItem.StyleCostingCustomField4
			,pStyleQuoteItem.StyleCostingCustomField5
			,pStyleQuoteItem.StyleCostingCustomField6
			,pStyleQuoteItem.StyleCostingCustomField7
			,pStyleQuoteItem.StyleCostingCustomField8
			,pStyleQuoteItem.StyleCostingCustomField9
			,pStyleQuoteItem.StyleCostingCustomField10
			,pStyleQuoteItem.StyleCostingCustomField11
			,pStyleQuoteItem.StyleCostingCustomField12
			,pStyleQuoteItem.StyleCostingCustomField13
			,pStyleQuoteItem.StyleCostingCustomField14
			,pStyleQuoteItem.StyleCostingCustomField15
			,pStyleQuoteItem.StyleCostingCustomField16
			,pStyleQuoteItem.StyleCostingCustomField17
			,pStyleQuoteItem.StyleCostingCustomField18
			,pStyleQuoteItem.StyleCostingCustomField19
			,pStyleQuoteItem.StyleCostingCustomField20
			,pStyleQuoteItem.StyleCostingCustomField21
			,pStyleQuoteItem.StyleCostingCustomField22
			,pStyleQuoteItem.StyleCostingCustomField23
			,pStyleQuoteItem.StyleCostingCustomField24
			,pStyleQuoteItem.StyleCostingCustomField25
			,pStyleQuoteItem.StyleCostingCustomField26
			,pStyleQuoteItem.StyleCostingCustomField27
			,pStyleQuoteItem.StyleCostingCustomField28
			,pStyleQuoteItem.StyleCostingCustomField29
			,pStyleQuoteItem.StyleCostingCustomField30
			,pStyleQuoteItem.StyleCostingCustomField31
			,pStyleQuoteItem.StyleCostingCustomField32
			,pStyleQuoteItem.StyleCostingCustomField33
			,pStyleQuoteItem.StyleCostingCustomField34
			,pStyleQuoteItem.StyleCostingCustomField35
			,pStyleHeader.StyleNo
			,COALESCE(sc.Custom, pStyleHeader.SizeClass) AS SizeClass
			,pStyleHeader.MaterialNo
			,pStyleQuoteItemFreightCost.Margin
			,pStyleQuoteItemFreightCost.TotalLandCost
			,pStyleHeader.Pc1
			,pStyleQuoteItem.StyleQuoteItemDueDate
			,uCountry.CountryName AS FOBCountry
			,uCountry_1.CountryName AS CountryOO
			,pStyleQuoteItemFreightCost.FreightCost
			,pStyleQuoteItem.StyleQuoteItemShare
			,''' + ISNULL(@Season, '') + ''' AS Season
			,''' + ISNULL(@Year, '') + ''' AS [Year]
		FROM uCountry uCountry_1
			RIGHT OUTER JOIN pStyleQuoteItem ON uCountry_1.CountryCode = pStyleQuoteItem.StyleQuoteItemCustomField5
			LEFT OUTER JOIN uCountry ON pStyleQuoteItem.StyleQuoteItemCustomField4 = uCountry.CountryCode
			INNER JOIN pStyleHeader ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID
			LEFT OUTER JOIN pStyleQuoteItemFreightCost ON pStyleQuoteItem.StyleQuoteItemID = pStyleQuoteItemFreightCost.StyleQuoteItemId
			LEFT OUTER JOIN pStyleQuoteItemStatus ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey
			LEFT OUTER JOIN uTradePartner ON pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID
			LEFT OUTER JOIN uTradePartnerVendor ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
			LEFT OUTER JOIN pStyleCostingType ON pStyleQuoteItem.StyleCostingType = pStyleCostingType.StyleCostingTypeID
			LEFT JOIN pSizeClass sc ON sc.CustomID = pStyleHeader.SizeClassId'


--Build the WHERE portion of the string for the query.
IF(@Season = '(any)' AND @Year = '(any)')
	BEGIN
		SET @SQLStrWhere = 
				' WHERE (pStyleQuoteItemFreightCost.FreightCostSelected = 1
				OR pStyleQuoteItemFreightCost.FreightCostSelected IS NULL)'
	END
ELSE IF(@Season = '(any)' AND @Year <> '(any)')
	BEGIN
		SET @SQLStrWhere = 
				' WHERE (pStyleQuoteItemFreightCost.FreightCostSelected = 1
				OR pStyleQuoteItemFreightCost.FreightCostSelected IS NULL)
				AND (pStyleHeader.CustomField4 = ''' + @Year + ''')'
	END
ELSE IF(@Season <> '(any)' AND @Year = '(any)')
	BEGIN
		SET @SQLStrWhere = 
				' WHERE (pStyleQuoteItemFreightCost.FreightCostSelected = 1
				OR pStyleQuoteItemFreightCost.FreightCostSelected IS NULL)
				AND (pStyleHeader.CustomField2 = ''' + @Season + ''')'
	END
ELSE
	BEGIN
		SET @SQLStrWhere = 
				' WHERE (pStyleQuoteItemFreightCost.FreightCostSelected = 1
				OR pStyleQuoteItemFreightCost.FreightCostSelected IS NULL)
				AND (pStyleHeader.CustomField2 = ''' + @Season + '''
				AND pStyleHeader.CustomField4 = ''' + @Year + ''')'
	END


--Execute the string query.
EXEC(@SQLStrBody + @SQLStrWhere)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09621', GetDate())
GO
