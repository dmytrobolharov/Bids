IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_QuoteBOMDimensions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_QuoteBOMDimensions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Sourcing_QuoteBOMDimensions_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER = NULL,
	@StyleSKUItemID UNIQUEIDENTIFIER = NULL,
	@StyleQuoteItemID UNIQUEIDENTIFIER = NULL
AS
BEGIN

	IF @StyleQuoteItemID IS NOT NULL
		SELECT @StyleBOMDimensionID = StyleColorID,
			@StyleSKUItemID = StyleSKUItemID 
		FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID
	
	SELECT * FROM pStyleBOMDimension sbd 
	LEFT JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
	WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
	
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08301', GetDate())
GO
