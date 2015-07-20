IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_BOMDetails_SKU_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_BOMDetails_SKU_CHECK]
GO

CREATE PROCEDURE [dbo].[spx_SourcingQuote_BOMDetails_SKU_CHECK]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	IF EXISTS(SELECT * FROM pSourcingQuotationBOMDetails sqbd
		INNER JOIN pStyleQuoteItem sqi ON sqbd.StyleQuoteItemID = sqi.StyleQuoteItemID
		LEFT JOIN pStyleSKUItems skui ON sqi.StyleSKUItemID = skui.StyleSKUItemID 
			AND (sqbd.ItemDim1Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR sqbd.ItemDim1Id IS NULL)
			AND (sqbd.ItemDim2Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR sqbd.ItemDim2Id IS NULL)
			AND (sqbd.ItemDim3Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR sqbd.ItemDim3Id IS NULL)
		WHERE sqbd.StyleQuoteItemID = @StyleQuoteItemID AND sqbd.Quantity <> skui.TotalUnits)
		SELECT 1
	ELSE SELECT 0
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08204', GetDate())
GO
