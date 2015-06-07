IF OBJECT_ID(N'[dbo].[spx_StyleMeasGRMeasurements_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMeasGRMeasurements_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeasGRMeasurements_INSERT]
(
	@POMTempId UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@WorkflowItemID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ChangeTemp NVARCHAR(2),
	@AMLMeasHdrId UNIQUEIDENTIFIER,		
	@CDate DATETIME,
	@CUser NVARCHAR(200),
	@OldAMLMeasHdrId UNIQUEIDENTIFIER = NULL
)
AS
  DECLARE @SizeClassId UNIQUEIDENTIFIER
  DECLARE @SizeRangeId UNIQUEIDENTIFIER
  DECLARE @PomDesc NVARCHAR(200)
  DECLARE @POMType NVARCHAR(100)
  DECLARE @POMTempGroupID UNIQUEIDENTIFIER
  DECLARE @Relative INT
  DECLARE @Negative INT
  DECLARE @Metric INT 
BEGIN

  SELECT @SizeClassId = t.SizeClassId, @SizeRangeId = t.SizeRangeId,  
         @PomDesc = t.POMTypeDescription, @POMType = t.POMType, @POMTempGroupID = t.POMTempGroupID,
         @Relative = tg.[Relative], @Negative = tg.Negative, @Metric = tg.Metric
  FROM pGRMeasurementsPOMTemplate t
  INNER JOIN pGRMeasurementsPOMTemplateGroup tg ON tg.POMTempID = t.POMTempID AND
												   tg.POMTempGroupID = t.POMTempGroupID
  WHERE t.POMTempID = @POMTempId

  IF @ChangeTemp <> '1'
    INSERT INTO pAMLMeasHdr(AMLMeasHdrId, WorkflowID, WorkflowItemID, StyleSet, StyleId, CompanyId, CompanyName, 
		                    IsRelative, IsNegative, IsMetric, SizeClassId, SizeRangeId, ProductTypeId, ProductType, 
							MeasRowCnt, CUser, CDate, MUser, MDate)
    VALUES(@AMLMeasHdrId, @WorkflowID, @WorkflowItemID, @StyleSet, @StyleID, @POMTempId, @POMType, 
	       @Relative, @Negative, @Metric, @SizeClassId, @SizeRangeId, @POMTempGroupID, @PomDesc, 
		   0, @CUser, @CDate, @CUser, @CDate)
  ELSE
    UPDATE pAMLMeasHdr 
	SET	CompanyId = @POMTempId, CompanyName = @POMType, IsRelative = @Relative, IsNegative = @Negative, IsMetric = @Metric,
	    SizeClassId = @SizeClassId, SizeRangeId = @SizeRangeId, ProductTypeId = @POMTempGroupID, ProductType = @POMDesc, 
	    MeasRowCnt = 0, CUser = @CUser, CDate = @CDate, MUser = @CUser, MDate = CDate
	WHERE AMLMeasHdrId = @AMLMeasHdrId AND WorkflowID = @WorkflowID AND WorkflowItemID = @WorkflowItemID AND 
	      Styleid = @Styleid AND StyleSet = @StyleSet

  INSERT INTO pAMLmeasLbl(AMLMeasHdrId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, MeasLblDesc, 
		                  IsVisible, IsSample, MeasDesc, Cuser, CDate, MUser, MDate) 
  SELECT @AMLMeasHdrId, @SizeRangeId, NEWID(), SizeRowId, SizeName, SizeDescription,
		 1, IsSampleSize, SizeId, @CUser, @CDate, @CUser, @CDate
  FROM fnx_GetSizeRangeInfo(@SizeRangeId)

  EXEC spx_StyleMeasGRMeasurementsPOM_Insert	
	@AMLMeasHdrId,
	@POMTempId,	
	@CUser,
	@CDate, 
	@OldAMLMeasHdrId

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09986', GetUTCDate())
GO
