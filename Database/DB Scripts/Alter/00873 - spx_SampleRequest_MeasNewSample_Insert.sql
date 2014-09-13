/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasNewSample_Insert]    Script Date: 12/14/2010 12:43:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[spx_SampleRequest_MeasNewSample_Insert] (
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
	@NewSubmit nvarchar(50)
)
AS 

	DECLARE @SampleLabelId uniqueidentifier
	DECLARE @SampleLblId uniqueidentifier	
	DECLARE @AMLMeasHdrId uniqueidentifier
	DECLARE @EvalSizeID uniqueidentifier
	DECLARE @EvalSizeCol int
	DECLARE @SampleCount int
	DECLARE @SizeColCnt int
	DECLARE @ResubmitDays int

	set @SampleLabelId = NEWID()
	set @SizeColCnt=1
	 
	SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
	
	SELECT @AMLMeasHdrId = AMLMeasHdrId, @EvalSizeID=EvalSizeID FROM  pMSEvalHeader WITH (NOLOCK) where SampleRequestHeaderId = @SampleRequestHeaderId
	select @EvalSizeCol=Sizecol from pAMLMeasLbl where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasLblId=@EvalSizeID

	Insert into pmsevalsamplbl (SampleLabelId, SampleRequestHeaderId, AMLMeasHdrId, SampleIndex) 
	values (@SampleLabelId, @SampleRequestHeaderId, @AMLMeasHdrId, @NewSubmit)	
	
	--insert into pmsevalsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, SamplepomId, SampleLabelId, POMRow , SampleIndex ,EvalMeasValue )
	--select  @SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, SamplepomId, @SampleLabelId, POMRow, @NewSubmit , 
	--(case RevisedSpec when 0 then EvalMeasValue else RevisedSpec end) as EvalMeasValue
	--from pmsevalsampMeas 
	--where  @SampleRequestHeaderId=@SampleRequestHeaderId and SampleIndex=@Submit
	
	delete from pmsevalpom where SampleRequestHeaderId=@SampleRequestHeaderId and amlmeashdrid=@amlmeashdrid and AmlMeaspomid not in (select AmlMeaspomid from pamlmeaspom where amlmeashdrid=@AMLMeasHdrId)	
	
	delete from pmsevalsampMeas where SampleRequestHeaderId=@SampleRequestHeaderId and amlmeashdrid=@amlmeashdrid and samplepomid not in (select samplepomid from pmsevalpom where amlmeashdrid=@AMLMeasHdrId
	and SampleRequestHeaderId=@SampleRequestHeaderId)	
	
	Update pmsevalpom set Refcode = p.Refcode, POMDescription = p.Description, TolMinus = p.TolMinus, TolPlus = p.TolPlus, 
	POMRow = p.POM_Row, WSRowId = p.WSRowId, HowToMeasurText = p.How2MeasText, ImageId = p.ImageId, SortId = p.SortId
	from pmsevalpom i inner join pamlmeaspom p on 
	i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid 									 
	where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId 		
		
	insert into pmsevalpom (SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, POMRow , Refcode , POMDescription  ,TolPlus
     ,TolMinus , WSRowId  , HowToMeasurText ,ImageId , SortId)
	select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid,  POM_Row,  Refcode , Description  ,TolPlus
    ,TolMinus ,WSRowId  , How2MeasText ,ImageId , SortId from pAMLMeasPOM 
    where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId Not in ( select AmlMeaspomid from pmsevalpom where SampleRequestHeaderId=@SampleRequestHeaderId)
      
    Update pmsevalsampMeas set POMRow = p.POMRow 	from pmsevalsampMeas i inner join pmsevalpom p on 
	i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.samplepomid=p.samplepomid									 
	and i.SampleRequestHeaderId=p.SampleRequestHeaderId where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId 
	    
    WHILE @SizeColCnt <= @NewSubmit 
	begin
	
		SELECT @SampleLblId = SampleLabelId from pmsevalsamplbl where SampleRequestHeaderId = @SampleRequestHeaderId 
		and AMLMeasHdrId=@AMLMeasHdrId and SampleIndex=@SizeColCnt
		
		if @SizeColCnt<@NewSubmit
			begin
				insert into pmsevalsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, SampleLabelId, POMRow , SampleIndex )
				select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, @SampleLblId, POM_Row, @SizeColCnt from pAMLMeasIGC where  AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@EvalSizeCol
				and AMLMeasPOMId Not in ( select AmlMeaspomid from pmsevalsampMeas where SampleRequestHeaderId=@SampleRequestHeaderId and SampleIndex=@SizeColCnt)
			end
		else
			begin
				insert into pmsevalsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, SampleLabelId, POMRow , SampleIndex ,EvalMeasValue )
				select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, @SampleLblId, POM_Row, @NewSubmit , Grade from pAMLMeasIGC where  AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@EvalSizeCol
				and AMLMeasPOMId Not in ( select AmlMeaspomid from pmsevalsampMeas where SampleRequestHeaderId=@SampleRequestHeaderId and SampleIndex=@NewSubmit)
			end
		
		SET @SizeColCnt = @SizeColCnt + 1
	end  
	    
		
	Update pmsevalsampMeas set samplepomid = p.samplepomid from pmsevalsampMeas i inner join pmsevalpom p on 
		i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.pomrow=p.pomrow and i.SampleRequestHeaderId=p.SampleRequestHeaderId										 
		where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId and i.samplepomid is null

	
	
	INSERT INTO pSampleRequestSubmit
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, @NewSubmit, 0, StartDate, CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pSampleRequestSubmit WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit) 
    
    update pMSEvalHeader set submit=@NewSubmit where SampleRequestHeaderId=@SampleRequestHeaderId
    
    
	UPDATE pSampleRequestWorkflow
	SET Status = '0', Submit = @NewSubmit, DueDate = CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112),   MUser = @CreatedBy, MDate = @CreatedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
	

                  
 Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '873', GetDate())
GO       



