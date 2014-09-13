IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestTradePartners_REPLACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestTradePartners_REPLACE]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestTradePartners_REPLACE]
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@TradePartnerIDChain VARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL
        
    -- add partners relation to the database        
	exec spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, @TradePartnerRelationshipLevelID OUT		 
	            
	DECLARE @TradePartnerID UNIQUEIDENTIFIER = (SELECT TOP 1 value FROM dbo.fnx_Split(@TradePartnerIDChain, ',') ORDER BY position DESC)

    IF (SELECT COUNT(*) FROM pSampleRequestBOMTrade WHERE SampleRequestTradeID = @SampleRequestTradeID) > 0
    BEGIN
		UPDATE pSampleRequestBOMTrade 
		SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID, 
			TradePartnerID = @TradePartnerID
		WHERE SampleRequestTradeID = @SampleRequestTradeID
		
		UPDATE pSampleRequestWorkflowBOM
		SET TradePartnerID = @TradePartnerID
		WHERE SampleRequestTradeID = @SampleRequestTradeID
    END
    ELSE
    BEGIN
		UPDATE pSampleRequestTrade 
		SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID, 
			TradePartnerID = @TradePartnerID
		WHERE SampleRequestTradeID = @SampleRequestTradeID
		
		UPDATE pSampleRequestWorkflow
		SET TradePartnerID = @TradePartnerID
		WHERE SampleRequestTradeID = @SampleRequestTradeID
    END
    
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07591', GetDate())
GO
