IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitmentItem_TotalValidation_Check]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitmentItem_TotalValidation_Check]
GO


CREATE PROCEDURE [dbo].[spx_CommitmentItem_TotalValidation_Check]
	@CommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleCostingTypeID INT = 0
	SELECT @StyleCostingTypeID = StyleCostingType FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @CommitmentItemID

	IF EXISTS (SELECT * FROM pSourcingCommitmentBOMDetails WHERE SourcingCommitmentItemID = @CommitmentItemID
				AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1)
		AND (@StyleCostingTypeID <> 9) -- Pre Pack costing type
	BEGIN
		DECLARE @TotalQuantity decimal(18,2)
		DECLARE @TotalBOMQuantity decimal(18,2)
		
		-- Wholesale Unit + Retail Unit + Ecom Unit
		SELECT @TotalQuantity = ISNULL(StyleQuoteItemCustomField2, '0') + ISNULL(StyleQuoteItemCustomField6, '0') + ISNULL(StyleQuoteItem_EcomUnits, '0') 
		FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @CommitmentItemID
		
		-- Total Units
		SELECT @TotalBOMQuantity = ISNULL(StyleQuoteItemCustomField16, '0')
		FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @CommitmentItemID
		
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
VALUES ('DB_Version', '0.5.0000', '08169', GetDate())
GO
