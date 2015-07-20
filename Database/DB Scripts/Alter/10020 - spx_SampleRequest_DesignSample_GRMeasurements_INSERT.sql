IF OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_GRMeasurements_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_GRMeasurements_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_GRMeasurements_INSERT]
(
	@POMTempId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ChangeTemp NVARCHAR(2),
	@SampleRequestAMLMeasHdrId UNIQUEIDENTIFIER,
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@Submit INT,
	@CDate DATETIME,
	@CUser NVARCHAR(200) 
)
AS
  DECLARE @SizeClassId UNIQUEIDENTIFIER
  DECLARE @SizeRangeId UNIQUEIDENTIFIER
  DECLARE @POMTypeDesc NVARCHAR(200)
  DECLARE @POMType NVARCHAR(100)
  DECLARE @POMTempGroupID UNIQUEIDENTIFIER
  DECLARE @Relative INT
  DECLARE @Negative INT
  DECLARE @Metric INT 
BEGIN

  SELECT @SizeClassId = t.SizeClassId, @SizeRangeId = t.SizeRangeId,  
         @POMTypeDesc = t.POMTypeDescription, @POMType = t.POMType, @POMTempGroupID = t.POMTempGroupID,
         @Relative = tg.[Relative], @Negative = tg.Negative, @Metric = tg.Metric
  FROM pGRMeasurementsPOMTemplate t
  INNER JOIN pGRMeasurementsPOMTemplateGroup tg ON tg.POMTempID = t.POMTempID AND
												   tg.POMTempGroupID = t.POMTempGroupID
  WHERE t.POMTempID = @POMTempId

  IF @ChangeTemp <> '1'
    BEGIN 
      IF  EXISTS(SELECT * FROM pSampleRequestAMLMeasHdr 
	             WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId) 
	    DELETE FROM pSampleRequestAMLMeasHdr WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
	
      INSERT INTO pSampleRequestAMLMeasHdr(SampleRequestAMLMeasHdrId, WorkflowID, WorkflowItemID, StyleSet, Styleid, 
	                                       Companyid, CompanyName, IsRelative, IsNegative, IsMetric, SizeClassId, 
										   SizeRangeId, ProductTypeId, ProductType, MeasRowCnt, CUser, CDate, MUser, MDate, 
										   SampleRequestTradeID, Submit)
      VALUES (@SampleRequestAMLMeasHdrId, @WorkflowID, '00000000-0000-0000-0000-000000000000', @StyleSet, @StyleID, 
	          @POMTempId, @POMType, @Relative, @Negative, @Metric, @SizeClassId, @SizeRangeId, @POMTempGroupID, 
		  	  @POMTypeDesc, 0, @CUser, @CDate, @CUser, @CDate, @SampleRequestTradeID, @Submit)
    END
  ELSE
    BEGIN
      UPDATE pSampleRequestAMLMeasHdr 
      SET CompanyId = @POMTempId, CompanyName = @POMType, IsRelative = @Relative, IsNegative = @Negative, IsMetric = @Metric,
          SizeClassId = @SizeClassId, SizeRangeId = @SizeRangeId, ProductTypeId = @POMTempGroupID, ProductType = @POMTypeDesc, 
		  MeasRowCnt = 0, CUser = @CUser, CDate = @CDate, MUser = @CUser, MDate = CDate
      WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId AND WorkflowID = @WorkflowID AND 
	        Styleid = @Styleid AND StyleSet = @StyleSet
		
      DELETE FROM pSampleRequestAMLMeasPOM WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
      DELETE FROM pSampleRequestAMLMeasIGC WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
      DELETE FROM pSampleRequestAMLMeasLbl WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId

    END

  INSERT INTO pSampleRequestAMLMeasLbl(SampleRequestAMLMeasHdrId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, 
		                               MeasLblDesc, IsVisible, IsSample, MeasDesc, Cuser, CDate, MUser, MDate) 
  SELECT @SampleRequestAMLMeasHdrId, @SizeRangeId, NEWID(), SizeRowid, SizeName, 
         SizeDescription, 1, IsSampleSize, SizeId, @CUser, @CDate, @CUser, @CDate
  FROM fnx_GetSizeRangeInfo(@SizeRangeId)

  EXEC spx_SampleRequest_DesignSample_GRMeasurementsPOM_Insert	
	@SampleRequestAMLMeasHdrId,
	@POMTempId,	
	@CUser,
	@CDate	
		
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10020', GetUTCDate())
GO
