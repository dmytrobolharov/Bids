-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestShareBOM_UPDATE]    Script Date: 12/18/2011 18:09:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestShareBOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestShareBOM_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestShareBOM_UPDATE]    Script Date: 12/18/2011 18:09:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestShareBOM_UPDATE]  ( 
@SampleRequestShare  INT , 
@SampleRequestTradeID UNIQUEIDENTIFIER ,
@AgentView INT  =  NULL 
)
AS 

DECLARE  @TradePartnerID UNIQUEIDENTIFIER 
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

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02381'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02381', GetDate())

END

GO