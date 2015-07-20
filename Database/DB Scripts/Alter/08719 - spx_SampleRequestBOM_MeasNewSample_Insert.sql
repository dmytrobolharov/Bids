IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOM_MeasNewSample_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOM_MeasNewSample_Insert]
GO


CREATE  PROCEDURE [dbo].[spx_SampleRequestBOM_MeasNewSample_Insert] (
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
	 
	SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
	
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
	
	Update pmsevalpom set Refcode = p.Refcode, POMDescription = p.Description, TolMinus = ISNULL(p.TolMinus, 0), TolPlus = ISNULL(p.TolPlus, 0), 
	POMRow = p.POM_Row, WSRowId = p.WSRowId, HowToMeasurText = p.How2MeasText, ImageId = p.ImageId, SortId = p.SortId
	from pmsevalpom i inner join pamlmeaspom p on 
	i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid 									 
	where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId 		
		
	insert into pmsevalpom (SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, POMRow , Refcode , POMDescription  ,TolPlus
     ,TolMinus , WSRowId  , HowToMeasurText ,ImageId , SortId)
	select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid,  POM_Row, Refcode, Description, ISNULL(TolPlus, 0)
    , ISNULL(TolMinus, 0) ,WSRowId  , How2MeasText ,ImageId , SortId from pAMLMeasPOM 
    where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId Not in ( select AmlMeaspomid from pmsevalpom where SampleRequestHeaderId=@SampleRequestHeaderId)
      
    Update pmsevalsampMeas set POMRow = p.POMRow 	from pmsevalsampMeas i inner join pmsevalpom p on 
	i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.samplepomid=p.samplepomid									 
	and i.SampleRequestHeaderId=p.SampleRequestHeaderId where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId 
	
	DECLARE @RevisedValue NUMERIC(18,4)
	
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
	
	UPDATE pmsevalsampMeas SET samplepomid = p.samplepomid 
	FROM pmsevalsampMeas i INNER JOIN pmsevalpom p ON 
	i.AMLMeasHdrId=p.AMLMeasHdrId AND i.AmlMeaspomid=p.AmlMeaspomid AND i.pomrow=p.pomrow 
	AND i.SampleRequestHeaderId=p.SampleRequestHeaderId										 
	WHERE i.amlmeashdrid=@AMLMeasHdrId AND i.SampleRequestHeaderId=@SampleRequestHeaderId 
	AND i.samplepomid is null
	
	/*** Copying old 'Revised' to new 'Eval size' ***/
	DECLARE @CurrentSamplePomID UNIQUEIDENTIFIER
	DECLARE @InsertedPoms CURSOR	
	DECLARE @CurrentRevisedSpec NUMERIC(18, 4)
	DECLARE @CurrentSampMeasValue NUMERIC(18, 4)
	SET @CurrentRevisedSpec = 0.00
	
	-- Setting cursor for all newly inserted items
	SET @InsertedPoms = CURSOR SCROLL
	FOR SELECT SamplepomId FROM pMSEvalSampMeas
		WHERE AMLMeasHdrId = @AMLMeasHdrId
		AND SampleRequestHeaderId=@SampleRequestHeaderId 
		AND SampleIndex = @NewSubmit
	OPEN @InsertedPoms
	FETCH NEXT FROM @InsertedPoms INTO @CurrentSamplePomID

	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- For each newly inserted item, selecting Revised Spec for previously inserted
		SELECT @CurrentRevisedSpec = RevisedSpec, @CurrentSampMeasValue = SampMeasValue
		FROM pMSEvalSampMeas
		WHERE SamplepomId = @CurrentSamplePomID
		AND SampleIndex = (@NewSubmit-1)
		AND AMLMeasHdrId=@AMLMeasHdrId
		AND SampleRequestHeaderId=@SampleRequestHeaderId
		
		-- Updating new Eval Size with old Revised Size	or old Sample value (if Revised is null)	
		UPDATE pmsevalsampMeas
		SET EvalMeasValue = CASE WHEN @CurrentRevisedSpec IS NULL OR @CurrentRevisedSpec = 0.00 THEN @CurrentSampMeasValue ELSE @CurrentRevisedSpec END
		WHERE AMLMeasHdrId = @AMLMeasHdrId
		AND SampleRequestHeaderId = @SampleRequestHeaderId
		AND SampleIndex = @NewSubmit
		AND SamplepomId = @CurrentSamplePomID
		
		FETCH NEXT FROM @InsertedPoms INTO @CurrentSamplePomID
	END
	
	CLOSE @InsertedPoms
	DEALLOCATE @InsertedPoms
	
	INSERT INTO pSampleRequestSubmitBOM
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID,ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID,ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, @NewSubmit, 0, StartDate, CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit) 
    
    update pMSEvalHeader set submit=@NewSubmit where SampleRequestHeaderId=@SampleRequestHeaderId
    
    
	UPDATE pSampleRequestWorkflowBOM
	SET Status = '0', Submit = @NewSubmit, DueDate = CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112),   MUser = @CreatedBy, MDate = @CreatedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08719', GetDate())
GO
