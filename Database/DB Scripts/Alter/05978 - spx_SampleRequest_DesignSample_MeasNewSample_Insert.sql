/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasNewSample_Insert]    Script Date: 07/02/2013 15:46:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasNewSample_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasNewSample_Insert]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasNewSample_Insert]    Script Date: 07/02/2013 15:46:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasNewSample_Insert] (
	@SampleRequestSubmitId uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleWorkflowID nvarchar(5),
	@SampleRequestTradeID uniqueidentifier,
	@SampleRequestHeaderId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleColorID uniqueidentifier,
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
	
	 
	SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
	
	INSERT INTO pSampleRequestAMLMeasHdr(SampleRequestAMLMeasHdrId, SampleRequestTradeID, Submit, Workflowid, StyleId, CompanyId, PDMPageId, CompanyName, PDMCompanyId, IsRelative, 
                      IsNegative, IsMetric, SizeClass, SizeClassId, SizeClassCode, SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, 
                      BaseSizeGrdCol, SelectedRange, MeasRowCnt, HaveHistory, HistoryMsg, CUser, CDate, MUser, MDate, WorkFlowItemId, StyleSet)
                      select @NewSampleRequestAMLHdrID, SampleRequestTradeID, @NewSubmit, Workflowid, StyleId, CompanyId, PDMPageId, CompanyName, PDMCompanyId, IsRelative, 
                      IsNegative, IsMetric, SizeClass, SizeClassId, SizeClassCode, SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, 
                      BaseSizeGrdCol, SelectedRange, MeasRowCnt, HaveHistory, HistoryMsg, CUser, CDate, @CreatedBy, @CreatedDate, WorkFlowItemId, StyleSet
                      FROM pSampleRequestAMLMeasHdr WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID
                      
    INSERT INTO pSampleRequestAMLMeasIGC(SampleRequestAMLMeasIGCId, SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPOMId, PDMPageId, POM_Row, WSRowId, SizeCol, Grade, Incr, 
                      ConvGrade, CUser, CDate, MUser, MDate) SELECT (NEWID()), SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPOMId, PDMPageId, POM_Row, WSRowId, SizeCol, Grade, Incr, 
                      ConvGrade, CUser, CDate, @CreatedBy, @CreatedDate 
                      from pSampleRequestAMLMeasIGC WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID
                      
    INSERT INTO pSampleRequestAMLMeasLbl(SampleRequestAMLMeasLblId, SampleRequestAMLMeasHdrId, SizeRangeId, PDMPageId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, 
                      CUser, CDate, MUser, MDate, MeasLblDesc) SELECT (NEWID()), SampleRequestAMLMeasHdrId, SizeRangeId, PDMPageId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, 
                      CUser, CDate, @CreatedBy, @CreatedDate, MeasLblDesc 
                      FROM pSampleRequestAMLMeasLbl WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID
                      

    INSERT INTO pSampleRequestAMLMeasIGC(SampleRequestAMLMeasIGCId, SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPOMId, PDMPageId, POM_Row, WSRowId, SizeCol, Grade, Incr, 
                      ConvGrade, CUser, CDate, MUser, MDate) SELECT (NEWID()), @NewSampleRequestAMLHdrID, (SELECT TOP 1 c.SampleRequestAMLMeasPOMId from pSampleRequestAMLMeasPOM c inner join pSampleRequestAMLMeasPOM b on c.POMGuidId = b.POMGuidId AND c.SampleRequestAMLMeasHdrId = @NewsampleRequestAMLHdrID AND b.SampleRequestAMLMeasPOMId = a.SampleRequestAMLMeasPOMId), a.PDMPageId, a.POM_Row, a.WSRowId, a.SizeCol, a.Grade, a.Incr, 
                      a.ConvGrade, a.CUser, a.CDate, @CreatedBy, @CreatedDate 
                      from pSampleRequestAMLMeasIGC a WHERE SampleRequestAMLMeasHdrId = @sampleRequestAMLHdrID
	 
	INSERT INTO pSampleRequestSubmit
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, @NewSubmit, 0, StartDate, CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pSampleRequestSubmit WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit) 
    
        
    
	UPDATE pSampleRequestWorkflow
	SET Status = '0', Submit = @NewSubmit, DueDate = CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112),   MUser = @CreatedBy, MDate = @CreatedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05978', GetDate())
GO
