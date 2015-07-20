IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItem_TotalValidation_Check]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItem_TotalValidation_Check]
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteItem_TotalValidation_Check]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleCostingTypeID INT = 0
	SELECT @StyleCostingTypeID = StyleCostingType FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

	IF EXISTS (SELECT * FROM pSourcingQuotationBOMDetails WHERE StyleQuoteItemID = @StyleQuoteItemID
				AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1)
		AND (@StyleCostingTypeID <> 9) -- Pre Pack costing type
	BEGIN
		DECLARE @TotalQuantity decimal(18,2)
		DECLARE @TotalBOMQuantity decimal(18,2)
		
		-- Wholesale Unit + Retail Unit + Ecom Unit
		SELECT @TotalQuantity = ISNULL(StyleQuoteItemCustomField2, '0') + ISNULL(StyleQuoteItemCustomField6, '0') + ISNULL(StyleQuoteItem_EcomUnits, '0') 
		FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID  
		
		-- Total Units
		SELECT @TotalBOMQuantity = ISNULL(StyleQuoteItemCustomField16, '0')
		FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID
		
		IF @TotalQuantity <> @TotalBOMQuantity
			SELECT 0
		ELSE
			SELECT 1
		
	END
	ELSE
		SELECT 1
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08167', GetDate())
GO
