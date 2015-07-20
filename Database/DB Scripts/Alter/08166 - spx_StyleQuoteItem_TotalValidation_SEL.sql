IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItem_TotalValidation_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItem_TotalValidation_SEL]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteItem_TotalValidation_SEL]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleCostingTypeID INT = 0
	SELECT @StyleCostingTypeID = StyleCostingType FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

	IF EXISTS (SELECT * FROM pSourcingQuotationBOMDetails WHERE StyleQuoteItemID = @StyleQuoteItemID
				AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1)
		AND (@StyleCostingTypeID <> 9 -- Pre Pack costing type
				OR NOT EXISTS (SELECT * FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID)) -- Quote doesn't exist yet (QuotationPalette page)
	BEGIN
		SELECT 'txtStyleQuoteItemCustomField2'
		UNION
		SELECT 'txtStyleQuoteItemCustomField6'
		UNION
		SELECT 'txtStyleQuoteItem_EcomUnits'
	END
	ELSE
		SELECT NULL
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08166', GetDate())
GO
