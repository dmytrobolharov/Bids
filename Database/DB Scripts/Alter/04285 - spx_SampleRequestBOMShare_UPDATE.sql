IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMShare_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMShare_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMShare_UPDATE]  ( 
@SampleRequestShare  INT , 
@SampleRequestTradeID UNIQUEIDENTIFIER ,
@AgentView INT  =  NULL 
)
AS
DECLARE @TradePartnerID UNIQUEIDENTIFIER 
DECLARE @StyleID UNIQUEIDENTIFIER 
DECLARE @StyleDevelopmentId UNIQUEIDENTIFIER 



IF @AgentView IS NULL 
	UPDATE pSampleRequestBOMTrade SET SampleRequestShare = @SampleRequestShare 
	WHERE SampleRequestTradeID = @SampleRequestTradeID
ELSE 
	UPDATE pSampleRequestBOMTrade SET SampleRequestShare = @SampleRequestShare  , AgentView = @AgentView
	WHERE SampleRequestTradeID = @SampleRequestTradeID



IF  @SampleRequestShare   = 0 
BEGIN 
	
	SELECT  @TradePartnerID  =  TradePartnerID  FROM pSampleRequestBOMTrade WITH (NOLOCK) WHERE  SampleRequestTradeID = @SampleRequestTradeID 
	DELETE FROM hSampleHistory  WHERE TeamID = @TradePartnerID   AND  SampleRequestTradeID = @SampleRequestTradeID
	
END
ELSE
BEGIN 

	SELECT @StyleID = StyleID ,  @TradePartnerID  = TradePartnerID  FROM pSampleRequestBOMTrade WITH (NOLOCK) WHERE SampleRequestTradeID = @SampleRequestTradeID 
	IF  ( SELECT COUNT(*)   FROM  pStyleTeam WITH (NOLOCK) WHERE StyleID = @StyleID AND  TeamID = @TradePartnerID  )  =  0
	BEGIN 
		SELECT  @StyleDevelopmentId = DevelopmentId  FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID 
	
		INSERT INTO pStyleTeam  (  StyleTeamID , TeamID , StyleDevelopmentId,  StyleID ,  TradePartner  ) 
		VALUES (  NEWID() ,  @TradePartnerID ,   @StyleDevelopmentId ,  @StyleID ,  1 ) 
	
	END

END
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04285', GetDate())
GO
