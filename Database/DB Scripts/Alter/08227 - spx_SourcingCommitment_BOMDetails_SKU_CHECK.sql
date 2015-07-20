IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_BOMDetails_SKU_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_BOMDetails_SKU_CHECK]
GO

CREATE PROCEDURE [dbo].[spx_SourcingCommitment_BOMDetails_SKU_CHECK]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	IF EXISTS(SELECT * FROM pSourcingCommitmentBOMDetails scbd
		INNER JOIN pSourcingCommitmentItem sci ON scbd.SourcingCommitmentItemID = sci.SourcingCommitmentItemID
		LEFT JOIN pStyleSKUItems skui ON sci.StyleSKUItemID = skui.StyleSKUItemID 
			AND (scbd.ItemDim1Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR scbd.ItemDim1Id IS NULL)
			AND (scbd.ItemDim2Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR scbd.ItemDim2Id IS NULL)
			AND (scbd.ItemDim3Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR scbd.ItemDim3Id IS NULL)
		WHERE scbd.SourcingCommitmentItemID = @SourcingCommitmentItemID AND scbd.Quantity <> skui.TotalUnits)
		SELECT 1
	ELSE SELECT 0
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08227', GetDate())
GO
