IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitmentItem_TotalValidation_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitmentItem_TotalValidation_SEL]
GO


CREATE PROCEDURE [dbo].[spx_CommitmentItem_TotalValidation_SEL]
	@CommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleCostingTypeID INT
	SELECT @StyleCostingTypeID = StyleCostingType FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @CommitmentItemID

	IF EXISTS (SELECT * FROM pSourcingCommitmentBOMDetails WHERE SourcingCommitmentItemID = @CommitmentItemID
				AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1)
		AND (@StyleCostingTypeID <> 9) -- Pre Pack costing type
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
VALUES ('DB_Version', '0.5.0000', '08168', GetDate())
GO
