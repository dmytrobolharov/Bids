IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPM_SampleRequest_ShareStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPM_SampleRequest_ShareStatus_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_NPM_SampleRequest_ShareStatus_UPDATE]
	@SampleRequestTradeID uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@IsADD bit,
	@MUser nvarchar(200),
	@MDate datetime
AS
BEGIN
IF @IsADD = 1
	BEGIN 
		IF (SELECT COUNT(*) FROM pSampleRequestShare WHERE SampleRequestTradeID = @SampleRequestTradeID AND TradePartnerId = @TradePartnerID) = 0
		INSERT INTO pSampleRequestShare(SampleRequestTradeID, TradePartnerId, MUser, MDate) VALUES(@SampleRequestTradeID, @TradePartnerID, @MUser, @MDate)
	END
ELSE
	BEGIN
		DELETE FROM pSampleRequestShare WHERE SampleRequestTradeID = @SampleRequestTradeID AND TradePartnerId = @TradePartnerID
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04878', GetDate())
GO
