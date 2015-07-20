IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitMaterial_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitMaterial_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleWorkflowSubmitMaterial_INSERT]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleSet int,
@CreatedDate nvarchar(50),
@CreatedBy nvarchar(50),
@Submit int,
@NewSubmit nvarchar(50),
@SampleRequestSubmitID uniqueidentifier = null,
@SampleRequestSubmitVendorID uniqueidentifier = null)
AS 

DECLARE @ResubmitDays int
SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID

DECLARE @SampleRequestSubmitNewId uniqueidentifier
set @SampleRequestSubmitNewId = NEWID()

IF (@SampleWorkflowID = '20A') --GCC
	BEGIN
	DECLARE @Row int
        DECLARE @Count int 
      
        DECLARE @SampleRequestSubmitVendorIDTemp  UNIQUEIDENTIFIER
        DECLARE @SampleRequestSubmitIDTemp UNIQUEIDENTIFIER
        DECLARE @SampleRequestSubmitVendorIDNew UNIQUEIDENTIFIER
                
        CREATE TABLE #SampleRequestSubmitVendorTemp  (
			RowID  int IDENTITY (1,1) ,
			SampleRequestSubmitVendorID uniqueidentifier,
			SampleRequestSubmitID  uniqueidentifier
        )
        INSERT INTO   #SampleRequestSubmitVendorTemp ( SampleRequestSubmitVendorID , SampleRequestSubmitID)
        SELECT SampleRequestSubmitVendorID , SampleRequestSubmitID  FROM  pSampleRequestSubmitVendor
        WITH (NOLOCK) WHERE SampleRequestSubmitID = @SampleRequestSubmitID	
	
	    SET @Row = 1
        SELECT @Count = COUNT(*) FROM #SampleRequestSubmitVendorTemp  
       
        IF @Count IS NULL  SET @Count = 0
	
        WHILE  @Row <=  @Count
			BEGIN
				SET @SampleRequestSubmitVendorIDTemp = NULL
				SET @SampleRequestSubmitIDTemp = NULL
				SET @SampleRequestSubmitVendorIDNew = NULL
				
				SET @SampleRequestSubmitVendorIDNew = NEWID()
				
				SELECT @SampleRequestSubmitVendorIDTemp = SampleRequestSubmitVendorID,
				@SampleRequestSubmitIDTemp = SampleRequestSubmitID
				FROM #SampleRequestSubmitVendorTemp  WHERE  RowID = @Row
	           
				INSERT INTO pSampleRequestSubmitVendor
				(SampleRequestSubmitVendorID, SampleRequestSubmitID, TradePartnerVendorID, VendorType, CUser, CDate)
				SELECT  @SampleRequestSubmitVendorIDNew, @SampleRequestSubmitNewId, TradePartnerVendorID, VendorType, @CreatedBy, @CreatedDate
				FROM pSampleRequestSubmitVendor WITH (NOLOCK)
				WHERE (SampleRequestSubmitVendorID = @SampleRequestSubmitVendorIDTemp) AND (SampleRequestSubmitID = @SampleRequestSubmitIDTemp)

				INSERT INTO pSampleRequestGCCWorkflow
				(SampleRequestSubmitID, Custom1, Custom2, Custom3, Custom4, Custom5, Sort, CUser, CDate, MUser, 
				 MDate,SampleRequestSubmitVendorID, Submit)
				SELECT  @SampleRequestSubmitNewId, Custom1, Custom2, Custom3, Custom4, Custom5, Sort, @CreatedBy, @CreatedDate, @CreatedBy, 
				 @CreatedDate, @SampleRequestSubmitVendorIDNew,@NewSubmit
				FROM pSampleRequestGCCWorkflow WITH (NOLOCK)
				WHERE (SampleRequestSubmitID = @SampleRequestSubmitIDTemp) AND (SampleRequestSubmitVendorID = @SampleRequestSubmitVendorIDTemp) AND (Submit = @Submit)
	   
				SET @Row   =  @Row  + 1
			END

        DROP TABLE #SampleRequestSubmitVendorTemp 	
        
	END
ELSE
	BEGIN
		INSERT INTO dbo.pSampleRequestMaterial
		(Submit, DueDate, Status, SampleRequestWorkflowID, SampleWorkflowID, StyleID, StyleColorID, StyleSet, SampleRequestTradeID, 
		WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, 
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, 
		VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, 
		MUser, MChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialComment)
		SELECT @NewSubmit, DueDate, 0, SampleRequestWorkflowID, SampleWorkflowID, StyleID, StyleColorID, StyleSet, SampleRequestTradeID, 
		WorkflowID, TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, 
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, 
		VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, @CreatedDate, @CreatedBy, @CreatedDate, 
		@CreatedBy, MChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialComment
		FROM dbo.pSampleRequestMaterial WITH (NOLOCK)
		WHERE ((SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
		(StyleID = @StyleID) AND (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (Submit = @Submit)) AND (Status = 1 OR Status = 0)
	END


BEGIN
	INSERT INTO dbo.pSampleRequestSubmit
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitNewId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, @NewSubmit, 0, StartDate, CONVERT(varchar(10), getdate() + ISNULL(@ResubmitDays,1) , 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM  dbo.pSampleRequestSubmit WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02982'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02982', GetDate())

END

GO

