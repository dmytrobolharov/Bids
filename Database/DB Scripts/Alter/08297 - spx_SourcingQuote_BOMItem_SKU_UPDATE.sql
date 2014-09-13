IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_BOMItem_SKU_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_BOMItem_SKU_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SourcingQuote_BOMItem_SKU_UPDATE]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@StyleBOMDimensionId UNIQUEIDENTIFIER,
	@StyleSKUItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	;WITH dims AS (
		SELECT DISTINCT V.DimID, 1 AS Active FROM pStyleSKUItems ssi
		CROSS APPLY	(VALUES (ssi.ItemDim1ID), 
							(ssi.ItemDim2ID), 
							(ssi.ItemDim3ID))
						   V(DimID)
		WHERE V.DimID IS NOT NULL
			AND  ssi.StyleSKUItemID = @StyleSKUItemID)
	UPDATE sqsb SET 
		ItemDim1Active = ISNULL(d1.Active, 0),
		ItemDim2Active = ISNULL(d2.Active, 0),
		ItemDim3Active = ISNULL(d3.Active, 0)
	FROM pSourcingQuoteStyleBOM sqsb
	LEFT JOIN dims d1 ON sqsb.ItemDim1Id = d1.DimID
	LEFT JOIN dims d2 ON sqsb.ItemDim2Id = d2.DimID
	LEFT JOIN dims d3 ON sqsb.ItemDim3Id = d3.DimID	
	WHERE sqsb.StyleQuoteItemID = @StyleQuoteItemID
	
	UPDATE sqbd SET
		Quantity = skui.TotalUnits 
	FROM pSourcingQuotationBOMDetails sqbd
	INNER JOIN pStyleSKUItems skui ON skui.StyleSKUItemID = @StyleSKUItemID
		AND (skui.ItemDim1ID IN (sqbd.ItemDim1Id, sqbd.ItemDim2Id, sqbd.ItemDim3Id) OR skui.ItemDim1ID IS NULL)
		AND (skui.ItemDim2ID IN (sqbd.ItemDim1Id, sqbd.ItemDim2Id, sqbd.ItemDim3Id) OR skui.ItemDim2ID IS NULL)
		AND (skui.ItemDim3ID IN (sqbd.ItemDim1Id, sqbd.ItemDim2Id, sqbd.ItemDim3Id) OR skui.ItemDim3ID IS NULL)
	WHERE sqbd.StyleQuoteItemID = @StyleQuoteItemID           
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08297', GetDate())
GO
