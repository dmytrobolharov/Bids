/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestStyleSourcingItemTemp_INSERT]    Script Date: 01/09/2013 16:41:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestStyleSourcingItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestStyleSourcingItemTemp_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestStyleSourcingItemTemp_INSERT]    Script Date: 01/09/2013 16:41:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestStyleSourcingItemTemp_INSERT] (
	@SampleRequestGroupID UNIQUEIDENTIFIER, 
	@StyleSourcingID UNIQUEIDENTIFIER, 
	@StyleColorID UNIQUEIDENTIFIER, 
	@TradePartnerID UNIQUEIDENTIFIER, 
	@CDate DATETIME, 
	@CUser  NVARCHAR (200) 
) 
AS 


CREATE TABLE  #tmpColorway (
	REC_ID INT IDENTITY  (1,1 ),
	StyleColorID UNIQUEIDENTIFIER, 
	StyleSourcingID  UNIQUEIDENTIFIER, 
	TradePartnerID UNIQUEIDENTIFIER
)

CREATE TABLE  #tmpColorwaySelected (
	REC_ID INT IDENTITY  (1,1 ),
	StyleColorID  UNIQUEIDENTIFIER, 
)



DECLARE @ROW INT 
DECLARE @TOTAL INT 
DECLARE @StyleColorIDTmp  UNIQUEIDENTIFIER 
DECLARE @StyleSourcingIDTmp  UNIQUEIDENTIFIER 

IF @StyleColorID  =  '00000000-0000-0000-0000-000000000000'
BEGIN

	INSERT INTO #tmpColorwaySelected (StyleColorID) 
	SELECT DISTINCT StyleColorID FROM pSampleRequestStyleColorwayTemp WITH (NOLOCK)
	WHERE SampleRequestGroupID = @SampleRequestGroupID

	SELECT @TOTAL  = COUNT(*) FROM  #tmpColorwaySelected  
	SET @ROW = 1

	WHILE  @ROW <= @TOTAL  
	BEGIN 
		SELECT @StyleColorIDTmp = StyleColorID FROM #tmpColorwaySelected WHERE REC_ID = @ROW	

		INSERT INTO #tmpColorway (StyleColorID, StyleSourcingID, TradePartnerID)
		VALUES (@StyleColorIDTmp, '00000000-0000-0000-0000-000000000000', @TradePartnerID)

		SET @ROW = @ROW + 1 
	END

	IF @TOTAL  = 0 
		INSERT INTO  #tmpColorway (StyleColorID, StyleSourcingID, TradePartnerID)
		VALUES ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', @TradePartnerID)

END
ELSE 
BEGIN

	INSERT INTO  #tmpColorway (StyleColorID, StyleSourcingID, TradePartnerID)	
	VALUES (@StyleColorID, @StyleSourcingID, @TradePartnerID)

END 

	SELECT @TOTAL = COUNT (*) FROM  #tmpColorway 
	SET @ROW =  1 
	WHILE  @ROW <= @TOTAL  
	BEGIN 
		SELECT @StyleColorIDTmp = StyleColorID, @StyleSourcingIDTmp = StyleSourcingID FROM #tmpColorway WHERE REC_ID = @ROW 

		IF (SELECT COUNT(*) FROM  pSampleRequestStyleSourcingTemp WITH (NOLOCK) 
			WHERE  SampleRequestGroupID = @SampleRequestGroupID AND StyleSourcingID = @StyleSourcingIDTmp  
				AND StyleColorID  =  @StyleColorIDTmp  AND  TradePartnerID = @TradePartnerID) = 0
				
			INSERT INTO pSampleRequestStyleSourcingTemp (SampleRequestGroupID, StyleSourcingID, StyleColorID, TradePartnerID, CDate, CUser)
			VALUES (@SampleRequestGroupID, @StyleSourcingIDTmp, @StyleColorIDTmp, @TradePartnerID, @CDate, @CUser)
		
		ELSE 
			UPDATE  pSampleRequestStyleSourcingTemp SET CDate = @CDate, CUser  = @CUser
			WHERE SampleRequestGroupID = @SampleRequestGroupID AND StyleSourcingID = @StyleSourcingIDTmp 
				AND StyleColorID = @StyleColorIDTmp  AND  TradePartnerID = @TradePartnerID

		SET @ROW = @ROW + 1
	
	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04768', GetDate())
GO
