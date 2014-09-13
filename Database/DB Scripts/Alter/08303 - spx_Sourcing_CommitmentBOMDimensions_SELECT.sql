IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_CommitmentBOMDimensions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDimensions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDimensions_SELECT]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER,
			@StyleSKUItemID UNIQUEIDENTIFIER

	SELECT @StyleBOMDimensionID = StyleColorID,
		@StyleSKUItemID = StyleSKUItemID 
	FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID

	SELECT * FROM pStyleBOMDimension sbd 
	LEFT JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
	WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
	
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08303', GetDate())
GO
