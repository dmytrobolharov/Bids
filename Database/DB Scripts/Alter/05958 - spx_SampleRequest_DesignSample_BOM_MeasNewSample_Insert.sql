/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_BOM_MeasNewSample_Insert]    Script Date: 07/02/2013 15:40:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_BOM_MeasNewSample_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_BOM_MeasNewSample_Insert]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_BOM_MeasNewSample_Insert]    Script Date: 07/02/2013 15:40:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_BOM_MeasNewSample_Insert] (
	@SampleRequestSubmitId uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleWorkflowID nvarchar(5),
	@SampleRequestTradeID uniqueidentifier,
	@SampleRequestHeaderId uniqueidentifier,
	@StyleID uniqueidentifier,
	@ItemDim1Id UNIQUEIDENTIFIER = null,
	@ItemDim2Id UNIQUEIDENTIFIER = null,
	@ItemDim3Id UNIQUEIDENTIFIER = null,
	@StyleSet int,
	@CreatedDate nvarchar(50),
	@CreatedBy nvarchar(50),
	@Submit int,
	@NewSubmit nvarchar(50),
	@sampleRequestAMLHdrID uniqueidentifier
)
AS 

	DECLARE @NewSampleRequestAMLHdrID uniqueidentifier
	DECLARE @ResubmitDays int
	
	set @NewSampleRequestAMLHdrID = NEWID()
	
	 
	SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
	
	INSERT INTO pSampleRequestAMLMeasHdr(SampleRequestAMLMeasHdrId, SampleRequestTradeID, Submit, Workflowid, StyleId, CompanyId, PDMPageId, CompanyName, PDMCompanyId, IsRelative, 
                      IsNegative, IsMetric, SizeClass, SizeClassId, SizeClassCode, SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, 
                      BaseSizeGrdCol, SelectedRange, MeasRowCnt, HaveHistory, HistoryMsg, CUser, CDate, MUser, MDate, WorkFlowItemId, StyleSet)
                      select @NewSampleRequestAMLHdrID, SampleRequestTradeID, @NewSubmit, Workflowid, StyleId, CompanyId, PDMPageId, CompanyName, PDMCompanyId, IsRelative, 
                      IsNegative, IsMetric, SizeClass, SizeClassId, SizeClassCode, SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, 
                      BaseSizeGrdCol, SelectedRange, MeasRowCnt, HaveHistory, HistoryMsg, CUser, CDate, @CreatedBy, @CreatedDate, WorkFlowItemId, StyleSet
                      FROM pSampleRequestAMLMeasHdr WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID
                      
    INSERT INTO pSampleRequestAMLMeasLbl(SampleRequestAMLMeasLblId, SampleRequestAMLMeasHdrId, SizeRangeId, PDMPageId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, 
                      CUser, CDate, MUser, MDate, MeasLblDesc) SELECT (NEWID()), @NewSampleRequestAMLHdrID, SizeRangeId, PDMPageId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, 
                      CUser, CDate, @CreatedBy, @CreatedDate, MeasLblDesc 
                      FROM pSampleRequestAMLMeasLbl WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID
                      

    INSERT INTO pSampleRequestAMLMeasPOM(SampleRequestAMLMeasPOMId, SampleRequestAMLMeasHdrId, PDMPageId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, RefCode, Description, 
                      TolPlus, TolMinus, TolPlusConv, TolMinusConv, Flag4QA, WSRowId, SortId, VideoSerialnumber, ImageSerialnumber, ImageId, How2MeasText, CUser, CDate, MUser, 
                      MDate, IsLinked, Critical, How2MeasName, FabricType, IsLength, IsWidth, ShrinkX, ShrinkY, CADModelId, BeforeTreat) 
                      SELECT (NEWID()), @NewSampleRequestAMLHdrID, PDMPageId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, RefCode, Description, 
                      TolPlus, TolMinus, TolPlusConv, TolMinusConv, Flag4QA, WSRowId, SortId, VideoSerialnumber, ImageSerialnumber, ImageId, How2MeasText, CUser, CDate, MUser, 
                      MDate, IsLinked, Critical, How2MeasName, FabricType, IsLength, IsWidth, ShrinkX, ShrinkY, CADModelId, BeforeTreat
                      FROM pSampleRequestAMLMeasPOM WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID  
	 
	INSERT INTO pSampleRequestAMLMeasIGC(SampleRequestAMLMeasIGCId, SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPOMId, PDMPageId, POM_Row, WSRowId, SizeCol, Grade, Incr, 
                      ConvGrade, CUser, CDate, MUser, MDate) SELECT (NEWID()), @NewSampleRequestAMLHdrID, (SELECT TOP 1 c.SampleRequestAMLMeasPOMId from pSampleRequestAMLMeasPOM c inner join pSampleRequestAMLMeasPOM b on c.POMGuidId = b.POMGuidId AND c.SampleRequestAMLMeasHdrId = @NewsampleRequestAMLHdrID AND b.SampleRequestAMLMeasPOMId = a.SampleRequestAMLMeasPOMId), a.PDMPageId, a.POM_Row, a.WSRowId, a.SizeCol, a.Grade, a.Incr, 
                      a.ConvGrade, a.CUser, a.CDate, @CreatedBy, @CreatedDate 
                      from pSampleRequestAMLMeasIGC a WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID
                      
                      
     INSERT INTO pSampleRequestSubmitBOM
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID,ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID,ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, @NewSubmit, 0, StartDate, CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit) 
    
    UPDATE pSampleRequestWorkflowBOM
	SET Status = '0', Submit = @NewSubmit, DueDate = CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112),   MUser = @CreatedBy, MDate = @CreatedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) 


GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05958', GetDate())
GO