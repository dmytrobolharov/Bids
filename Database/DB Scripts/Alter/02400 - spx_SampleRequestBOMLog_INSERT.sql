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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMLog_INSERT]    Script Date: 12/18/2011 18:31:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMLog_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMLog_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMLog_INSERT]    Script Date: 12/18/2011 18:31:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMLog_INSERT]
(@SampleRequestTradeId uniqueidentifier,
@SampleRequestSubmitId uniqueidentifier,
@teamId uniqueidentifier,
@tradePartner varchar(1),
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@SampleLogType nvarchar(2))
AS 

DECLARE
@TechPackId uniqueidentifier,
@StyleId uniqueidentifier,
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
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

DECLARE @SampleLogDescription varchar(200)
DECLARE @SampleSubmit int
DECLARE @StyleSet int
DECLARE @SubmitStatusId int

SELECT @SubmitStatusId = Status, @SampleSubmit = Submit, @StyleSet = StyleSet FROM pSampleRequestSubmitBOM WITH (NOLOCK) WHERE SampleRequestSubmitID = @SampleRequestSubmitID	
IF @tradePartner = 1 UPDATE pSampleRequestBOMTrade SET AgentView = 1 WHERE SampleRequestTradeID = @SampleRequestTradeId	
		
BEGIN
	IF @SampleLogType = 'N'
		BEGIN
			SET @SampleLogDescription = 'New Sample Request' 
		END
	ELSE IF	@SampleLogType = 'D'
		BEGIN
			SET @SampleLogDescription = 'Tech Pack Downloaded'
		END
	ELSE IF	@SampleLogType = 'A'
		BEGIN
			SET @SampleLogDescription = 'Sample Submit Approved'
		END	
	ELSE IF	@SampleLogType = 'C'
		BEGIN
			SET @SampleLogDescription = 'Fit Comments Updated'
		END			
	ELSE IF	@SampleLogType = 'R'
		BEGIN
			SET @SampleLogDescription = 'Sample Resubmitted'
		END			
	ELSE IF	@SampleLogType = 'S'
		BEGIN
			SET @SampleLogDescription = 'New Sample Submit'
		END	
	ELSE IF	@SampleLogType = 'V'
		BEGIN
			SET @SampleLogDescription = 'Sample Submit Viewed'
		END				
	ELSE IF	@SampleLogType = 'U'
		BEGIN
			SET @SampleLogDescription = 'Sample Submit Updated'
		END		
	ELSE IF	@SampleLogType = 'F'
		BEGIN
			SET @SampleLogDescription = 'Sample Request Creation Failed'
		END	
	ELSE IF	@SampleLogType = 'SP'
		BEGIN
			SET @SampleLogDescription = 'Sample Spec Created'
		END	
	ELSE IF	@SampleLogType = 'SR'
		BEGIN
			SET @SampleLogDescription = 'Sample Spec Removed'
		END	
	ELSE IF	@SampleLogType = 'SG'
		BEGIN
			SET @SampleLogDescription = 'Graded Rules Updated'
		END	
	ELSE IF	@SampleLogType = 'IN'
		BEGIN
			SET @SampleLogDescription = 'New Image'
		END		
	ELSE IF	@SampleLogType = 'ID'
		BEGIN
			SET @SampleLogDescription = 'Image Deleted'
		END				
	ELSE IF	@SampleLogType = 'SD'
		BEGIN
			SET @SampleLogDescription = 'Sample Dropped'
		END				
	ELSE
		BEGIN
			SET @SampleLogDescription = ''
		END
END	
	
	IF @SampleLogType = 'V'
		BEGIN
			IF (SELECT COUNT(*) FROM  pSampleRequestLog WITH (NOLOCK) WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID AND (LogType = 'V')) = 0
				BEGIN
					INSERT INTO pSampleRequestLog
						(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, TechPackId, CUser, CDate, LogDescription, LogType, TeamId, TradePartner, StyleSet, Submit)
					VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @TechPackId, @CreatedBy, @CreatedDate, 
						@SampleLogDescription, @SampleLogType, @TeamId, @TradePartner, @StyleSet, @SampleSubmit)
				END
				IF @tradePartner = 1 UPDATE pSampleRequestSubmitBOM SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID	
		END 
	ELSE IF @SampleLogType = 'U'
		BEGIN
			--DELETE FROM pSampleRequestLog WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID AND LogType = 'U' 
			INSERT INTO pSampleRequestLog
				(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, TechPackId, CUser, CDate, LogDescription, LogType, TeamId, TradePartner, StyleSet, Submit)
			VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @TechPackId, @CreatedBy, @CreatedDate, 
				@SampleLogDescription, @SampleLogType, @TeamId, @TradePartner, @StyleSet, @SampleSubmit)
			IF @tradePartner = 1 UPDATE pSampleRequestSubmitBOM SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID			
		END
	ELSE
		BEGIN

			IF  @SampleLogType  = 'SD'
			BEGIN
				IF ( SELECT COUNT(*) FROM pSampleRequestLog WITH (NOLOCK) WHERE LogType = @SampleLogType 
				AND SampleRequestTradeId = @SampleRequestTradeId  AND SampleRequestSubmitID = @SampleRequestSubmitID ) > 0 
				BEGIN
					SET @SampleLogType  = 'U'
					SET @SampleLogDescription = 'Sample Submit Updated'
				END 
			END


			INSERT INTO pSampleRequestLog
				(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, TechPackId, CUser, CDate, LogDescription, LogType, TeamId, TradePartner, StyleSet, Submit)
			VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @TechPackId, @CreatedBy, @CreatedDate, 
				@SampleLogDescription, @SampleLogType, @TeamId, @TradePartner, @StyleSet, @SampleSubmit)
			IF @tradePartner = 1 UPDATE pSampleRequestSubmitBOM SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID			
		END	 
		 

	 
/*
IF @SampleLogDescription <> ''

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
			@SampleLogDescription, @SampleLogType, @TeamId, @TradePartner)
		IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID			
	END
ELSE IF @SubmitStatusId = 1
	BEGIN
		DELETE FROM  pSampleRequestActivity WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID
		INSERT INTO pSampleRequestActivity
			(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, StyleColorId, TechPackId, CUser, CDate, SampleActivity, ActivityType, TeamId, TradePartner)
		VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @StyleColorId, @TechPackId, @CreatedBy, @CreatedDate, 
			@SampleLogDescription, @SampleLogType, @TeamId, @TradePartner)
		IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID			
	END



	BEGIN
	IF (SELECT COUNT(*) FROM  pSampleRequestActivity WITH (NOLOCK) WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ActivityType = @SampleLogType AND SampleRequestSubmitID = @SampleRequestSubmitID) <> 0
		IF @SampleLogType = 'V'
			BEGIN
			IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID
			END 
		ELSE
			BEGIN
			IF (SELECT COUNT(*) FROM  pSampleRequestActivity WITH (NOLOCK) WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND SampleRequestSubmitID = @SampleRequestSubmitID AND (ActivityType = 'A')) = 0
				BEGIN
					IF	@SampleLogType = 'A' DELETE FROM  pSampleRequestActivity WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ActivityType = 'U' AND SampleRequestSubmitID = @SampleRequestSubmitID
					IF	@SampleLogType = 'R' DELETE FROM  pSampleRequestActivity WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ActivityType = 'U' AND SampleRequestSubmitID = @SampleRequestSubmitID
				END
			ELSE
				BEGIN	
					UPDATE pSampleRequestActivity SET CDATE = GETDATE() WHERE TeamId = @TeamId AND ActivityType = @SampleLogType AND SampleRequestSubmitID = @SampleRequestSubmitID		
				END
			END		
	ELSE
		INSERT INTO pSampleRequestActivity
			(SampleRequestTradeId, SampleRequestSubmitID, TradePartnerId, TradePartnerVendorId, StyleId, StyleColorId, TechPackId, CUser, CDate, SampleActivity, ActivityType, TeamId, TradePartner)
		VALUES  (@SampleRequestTradeId, @SampleRequestSubmitID, @TradePartnerId, @TradepartnerVendorId, @StyleId, @StyleColorId, @TechPackId, @CreatedBy, @CreatedDate, 
			@SampleLogDescription, @SampleLogType, @TeamId, @TradePartner)
		IF @tradePartner = 1 UPDATE pSampleRequestSubmit SET AgentView = 1 WHERE SampleRequestSubmitID = @SampleRequestSubmitID	
	END		
*/



set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02400'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02400', GetDate())

END

GO

