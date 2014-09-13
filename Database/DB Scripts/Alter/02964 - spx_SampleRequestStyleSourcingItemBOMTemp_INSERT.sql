IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestStyleSourcingItemBOMTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestStyleSourcingItemBOMTemp_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestStyleSourcingItemBOMTemp_INSERT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestStyleSourcingItemBOMTemp_INSERT] (
@SampleRequestGroupID UNIQUEIDENTIFIER , 
@StyleSourcingID UNIQUEIDENTIFIER , 
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@TradePartnerID UNIQUEIDENTIFIER , 
@TradePartnerVendorID UNIQUEIDENTIFIER  , 
@CDate DATETIME   , 
@CUser  NVARCHAR (200) 
) 
AS 


IF @TradePartnerID  IS NULL
BEGIN 
	SELECT @TradePartnerID  = TradepartnerID FROM  uTradePartnerVendor WITH (NOLOCK) WHERE TradePartnerVendorID  = @TradePartnerVendorID 
END 


CREATE TABLE  #tmpColorway (
REC_ID INT IDENTITY  (1,1 )  ,
ItemDim1Id uniqueidentifier,
ItemDim2Id uniqueidentifier,
ItemDim3Id uniqueidentifier,
StyleSourcingID  UNIQUEIDENTIFIER , 
TradePartnerID UNIQUEIDENTIFIER , 
TradePartnerVendorID UNIQUEIDENTIFIER, 
StyleSet int,
WorkFlowItemID uniqueidentifier,
StyleBOMDimensionID uniqueidentifier,
StyleBOMDimensionItemID uniqueidentifier
)

CREATE TABLE  #tmpColorwaySelected (
REC_ID INT IDENTITY  (1,1 )  ,
ItemDim1Id uniqueidentifier,
ItemDim2Id uniqueidentifier,
ItemDim3Id uniqueidentifier,
StyleSet int,
WorkFlowItemID uniqueidentifier,
StyleBOMDimensionID uniqueidentifier,
StyleBOMDimensionItemID uniqueidentifier
)



DECLARE @ROW INT 
DECLARE @TOTAL INT 
DECLARE @ItemDim1Idtemp uniqueidentifier
DECLARE @ItemDim2Idtemp uniqueidentifier
DECLARE @ItemDim3Idtemp uniqueidentifier
DECLARE @WorkFlowItemIDtemp uniqueidentifier
DECLARE @StyleBOMDimensionIDtemp uniqueidentifier
DECLARE @StyleBOMDimensionItemIDtemp uniqueidentifier
DECLARE @StyleSourcingIDTmp  UNIQUEIDENTIFIER
DECLARE @StyleSet int

IF @ItemDim1Id  =  '00000000-0000-0000-0000-000000000000'
BEGIN

	INSERT INTO #tmpColorwaySelected (  ItemDim1Id,ItemDim2Id,ItemDim3Id,StyleSet,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID  ) 
	SELECT DISTINCT ItemDim1Id,ItemDim2Id,ItemDim3Id,StyleSet,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID  from  pSampleRequestStyleBOMColorwayTemp WITH (NOLOCK)
	WHERE SampleRequestGroupID  = @SampleRequestGroupID 

	SELECT @TOTAL  = COUNT(*) FROM  #tmpColorwaySelected  
	SET @ROW =  1 

	WHILE  @ROW <= @TOTAL  
	BEGIN 
		SELECT @ItemDim1Idtemp   =  ItemDim1Id, @ItemDim2Idtemp   =  ItemDim2Id, @ItemDim3Idtemp   =  ItemDim3Id,@StyleSet = StyleSet,@WorkFlowItemIDtemp=WorkFlowItemID,@StyleBOMDimensionIDtemp=StyleBOMDimensionID,@StyleBOMDimensionItemIDtemp=StyleBOMDimensionItemID
		  FROM  #tmpColorwaySelected  WHERE REC_ID =  @ROW 
	

		INSERT INTO  #tmpColorway ( ItemDim1Id,ItemDim2Id,ItemDim3Id ,  StyleSourcingID,  TradePartnerID ,  TradePartnerVendorID,StyleSet,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID )	
		VALUES  ( @ItemDim1Idtemp,@ItemDim2Idtemp,@ItemDim3Idtemp ,  '00000000-0000-0000-0000-000000000000' , @TradePartnerID, @TradePartnerVendorID,@StyleSet,@WorkFlowItemIDtemp,@StyleBOMDimensionIDtemp,@StyleBOMDimensionItemIDtemp   )

		SET @ROW = @ROW + 1 

	END 


	IF @TOTAL  = 0 
		INSERT INTO  #tmpColorway ( ItemDim1Id,ItemDim2Id,ItemDim3Id , StyleSourcingID ,  TradePartnerID ,  TradePartnerVendorID,StyleSet,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID )	
		VALUES  ( '00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000' ,  '00000000-0000-0000-0000-000000000000' , @TradePartnerID, @TradePartnerVendorID,1,@WorkFlowItemIDtemp,@StyleBOMDimensionIDtemp,@StyleBOMDimensionItemIDtemp    )


END
ELSE 
BEGIN

	INSERT INTO  #tmpColorway ( ItemDim1Id,ItemDim2Id,ItemDim3Id ,  StyleSourcingID , TradePartnerID ,  TradePartnerVendorID,StyleSet,WorkFlowItemID ,StyleBOMDimensionID,StyleBOMDimensionItemID)	
	VALUES  ( @ItemDim1Idtemp,@ItemDim2Idtemp,@ItemDim3Idtemp  ,  @StyleSourcingID,  @TradePartnerID, @TradePartnerVendorID,@StyleSet,@WorkFlowItemIDtemp,@StyleBOMDimensionIDtemp,@StyleBOMDimensionItemIDtemp    )


END 



	SELECT @TOTAL = COUNT (*) FROM  #tmpColorway 
	SET @ROW =  1 
	WHILE  @ROW <= @TOTAL  
	BEGIN 
		SELECT @ItemDim1Idtemp  =  ItemDim1Id,@ItemDim2Idtemp  =  ItemDim2Id,@ItemDim3Idtemp  =  ItemDim3Id  ,   @StyleSourcingIDTmp  = StyleSourcingID,@StyleSet=StyleSet,@WorkFlowItemIDtemp=WorkFlowItemID,@StyleBOMDimensionIDtemp=StyleBOMDimensionID,@StyleBOMDimensionItemIDtemp=StyleBOMDimensionItemID   FROM  #tmpColorway  WHERE REC_ID =  @ROW 


		IF ( SELECT COUNT(*) FROM  pSampleRequestStyleSourcingBOMTemp WITH (NOLOCK) WHERE  SampleRequestGroupID = @SampleRequestGroupID AND 
			StyleSourcingID = @StyleSourcingIDTmp  AND  ItemDim1Id   = @ItemDim1Idtemp AND  ItemDim2Id  =  @ItemDim2Idtemp AND  ItemDim3Id  =  @ItemDim3Idtemp AND  TradePartnerID = @TradePartnerID  
		AND TradePartnerVendorID  = @TradePartnerVendorID  And StyleSet = @StyleSet )  = 0 
			INSERT INTO pSampleRequestStyleSourcingBOMTemp   (  SampleRequestGroupID ,  StyleSourcingID , ItemDim1Id,ItemDim2Id,ItemDim3Id  ,  TradePartnerID ,  TradePartnerVendorID  , CDate , CUser,StyleSet,WorkFlowItemID ,StyleBOMDimensionID,StyleBOMDimensionItemID   )
			VALUES (  @SampleRequestGroupID ,  @StyleSourcingIDTmp , @ItemDim1Idtemp,@ItemDim2Idtemp,@ItemDim3Idtemp ,  @TradePartnerID ,  @TradePartnerVendorID ,  @CDate ,  @CUser,@StyleSet,@WorkFlowItemIDtemp,@StyleBOMDimensionIDtemp,@StyleBOMDimensionItemIDtemp  )
		
		ELSE 
			UPDATE  pSampleRequestStyleSourcingBOMTemp   SET CDate  = @CDate ,   CUser  = @CUser   
			WHERE SampleRequestGroupID = @SampleRequestGroupID AND StyleSourcingID = @StyleSourcingIDTmp  AND  ItemDim1Id   = @ItemDim1Idtemp AND  ItemDim2Id  =  @ItemDim2Idtemp AND  ItemDim3Id  =  @ItemDim3Idtemp  
			AND  TradePartnerID = @TradePartnerID   AND TradePartnerVendorID  = @TradePartnerVendorID And StyleSet = @StyleSet

		SET @ROW = @ROW + 1 
	
	END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02964'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02964', GetDate())
END
GO