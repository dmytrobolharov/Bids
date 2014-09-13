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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMActivity_INSERT]    Script Date: 12/18/2011 18:32:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMActivity_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMActivity_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMActivity_INSERT]    Script Date: 12/18/2011 18:32:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMActivity_INSERT]
(@SampleRequestTradeId uniqueidentifier,
@SampleRequestSubmitId uniqueidentifier,
@teamId uniqueidentifier,
@tradePartner varchar(1),
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@SampleActivity nvarchar(2))
AS 

DECLARE
@TechPackId uniqueidentifier,
@StyleId uniqueidentifier,
@ItemDim1Id UNIQUEIDENTIFIER,
@ItemDim2Id UNIQUEIDENTIFIER,
@ItemDim3Id UNIQUEIDENTIFIER,
@TradePartnerId uniqueidentifier,
@TradepartnerVendorId uniqueidentifier

SELECT @TechPackId = TechPackId,
@StyleId = StyleId,
@ItemDim1Id = ItemDim1Id,
@ItemDim2Id = ItemDim2Id,
@ItemDim3Id = ItemDim3Id,
@TradePartnerId = TradePartnerId,
@TradepartnerVendorId = TradepartnerVendorId
FROM pSampleRequestBOMTrade WITH (NOLOCK) WHERE SampleRequestTradeID = @SampleRequestTradeId  

IF @tradePartner = 1 UPDATE pSampleRequestBOMTrade SET AgentView = 1 WHERE SampleRequestTradeID = @SampleRequestTradeId

DECLARE @SampleActivityDescription varchar(200)
BEGIN
	IF @SampleActivity = 'N'
		BEGIN
			SET @SampleActivityDescription = 'New Sample Request' 
		END
	ELSE IF	@SampleActivity = 'D'
		BEGIN
			SET @SampleActivityDescription = 'Tech Pack Downloaded'
		END
	ELSE IF	@SampleActivity = 'A'
		BEGIN
			SET @SampleActivityDescription = 'Sample Submit Approved'
		END	
	ELSE IF	@SampleActivity = 'R'
		BEGIN
			SET @SampleActivityDescription = 'Sample Resubmitted'
		END			
	ELSE IF	@SampleActivity = 'S'
		BEGIN
			SET @SampleActivityDescription = 'New Sample Submit'
		END	
	ELSE IF	@SampleActivity = 'V'
		BEGIN
			SET @SampleActivityDescription = 'Sample Submit Viewed'
		END				
	ELSE IF	@SampleActivity = 'U'
		BEGIN
			SET @SampleActivityDescription = 'Sample Submit Updated'
		END		
	ELSE IF	@SampleActivity = 'F'
		BEGIN
			SET @SampleActivityDescription = 'Sample Request Creation Failed'
		END	
	ELSE IF	@SampleActivity = 'SP'
		BEGIN
			SET @SampleActivityDescription = 'Sample Spec Created'
		END		
	ELSE IF @SampleActivity = 'SD'
		BEGIN
			SET @SampleActivityDescription = 'Sample Submit Droppped'
		END		
	ELSE
		BEGIN
			SET @SampleActivityDescription = ''
		END
END	
	
	IF @SampleActivity = 'V'
		BEGIN
			IF @tradePartner = 1 UPDATE pSampleRequestSubmitBOM SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		END 
	ELSE
	BEGIN

		DECLARE @bInsert INT 
		SET @bInsert  = 1 

		IF @SampleActivity = 'R'
			DELETE FROM pSampleRequestBOMActivity WHERE ActivityType IN ('A', 'SD') AND SampleRequestTradeId = @SampleRequestTradeId  AND SampleRequestSubmitID = @SampleRequestSubmitID

		IF @SampleActivity = 'A' OR @SampleActivity = 'SD'
		BEGIN

			IF @SampleActivity = 'A' 
				DELETE FROM pSampleRequestBOMActivity WHERE ActivityType = 'SD' AND SampleRequestTradeId = @SampleRequestTradeId  AND SampleRequestSubmitID = @SampleRequestSubmitID
			
			IF @SampleActivity = 'SD' 
				DELETE FROM pSampleRequestBOMActivity WHERE ActivityType = 'A' AND SampleRequestTradeId = @SampleRequestTradeId  AND SampleRequestSubmitID = @SampleRequestSubmitID


			IF ( SELECT COUNT(*) FROM pSampleRequestBOMActivity WITH (NOLOCK) 
			WHERE ActivityType = @SampleActivity 
			AND SampleRequestTradeId = @SampleRequestTradeId  
			AND SampleRequestSubmitID = @SampleRequestSubmitID ) > 0 
			BEGIN
				SET @SampleActivity = 'U'
				SET @SampleActivityDescription = 'Sample Submit Updated'
				--SET @bInsert = 0
			END 
				
		END

 		
		IF @bInsert  = 1 
		BEGIN

			DELETE FROM pSampleRequestBOMActivity 
			WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID
			AND ActivityType NOT IN ( 'A', 'SD' ) 


			INSERT INTO pSampleRequestBOMActivity
				(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPackId, CUser, CDate, SampleActivity, ActivityType, TeamId, TradePartner)
			VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @TechPackId, @CreatedBy, @CreatedDate, 
				@SampleActivityDescription, @SampleActivity, @TeamId, @TradePartner)

			IF @tradePartner = 1 UPDATE pSampleRequestSubmitBOM SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID			
		END
	END	 
		 
	 
	 
/*
IF @SampleActivityDescription <> ''

DECLARE @SubmitStatusId int
SELECT @SubmitStatusId = Status FROM pSampleRequestSubmit WITH (NOLOCK) WHERE SampleRequestSubmitID = @SampleRequestSubmitID
*/



/*
@SubmitStatusId
Open =				0
Resubmit =			1
Apv w/ Correction = 2
Approved =			3
Dropped =			4
*/


/*
IF @SubmitStatusId = 0
	BEGIN
		DELETE FROM  pSampleRequestActivity WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID
		INSERT INTO pSampleRequestActivity
			(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, StyleColorId, TechPackId, CUser, CDate, SampleActivity, ActivityType, TeamId, TradePartner)
		VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @StyleColorId, @TechPackId, @CreatedBy, @CreatedDate, 
			@SampleActivityDescription, @SampleActivity, @TeamId, @TradePartner)
		IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID			
	END
ELSE IF @SubmitStatusId = 1
	BEGIN
		DELETE FROM  pSampleRequestActivity WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID
		INSERT INTO pSampleRequestActivity
			(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, StyleColorId, TechPackId, CUser, CDate, SampleActivity, ActivityType, TeamId, TradePartner)
		VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @StyleColorId, @TechPackId, @CreatedBy, @CreatedDate, 
			@SampleActivityDescription, @SampleActivity, @TeamId, @TradePartner)
		IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID			
	END



	BEGIN
	IF (SELECT COUNT(*) FROM  pSampleRequestActivity WITH (NOLOCK) WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ActivityType = @SampleActivity AND SampleRequestSubmitID = @SampleRequestSubmitID) <> 0
		IF @SampleActivity = 'V'
			BEGIN
			IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID
			END 
		ELSE
			BEGIN
			IF (SELECT COUNT(*) FROM  pSampleRequestActivity WITH (NOLOCK) WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID AND (ActivityType = 'A')) = 0
				BEGIN
					IF	@SampleActivity = 'A' DELETE FROM  pSampleRequestActivity WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ActivityType = 'U' AND SampleRequestSubmitID = @SampleRequestSubmitID
					IF	@SampleActivity = 'R' DELETE FROM  pSampleRequestActivity WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ActivityType = 'U' AND SampleRequestSubmitID = @SampleRequestSubmitID
				END
			ELSE
				BEGIN	
					UPDATE pSampleRequestActivity SET CDATE = GETDATE() WHERE TeamId = @TeamId AND ActivityType = @SampleActivity AND SampleRequestSubmitID = @SampleRequestSubmitID		
				END
			END		
	ELSE
		INSERT INTO pSampleRequestActivity
			(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, StyleColorId, TechPackId, CUser, CDate, SampleActivity, ActivityType, TeamId, TradePartner)
		VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @StyleColorId, @TechPackId, @CreatedBy, @CreatedDate, 
			@SampleActivityDescription, @SampleActivity, @TeamId, @TradePartner)
		IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID	
	END		
*/







set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02402'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02402', GetDate())

END

GO
