IF OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasChangeSample_Update]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_MeasChangeSample_Update]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_MeasChangeSample_Update] (
	@AMLMeasHdrId uniqueidentifier,	
	@EvalSizeID uniqueidentifier,	
	@SampleRequestHeaderId uniqueidentifier,	
	@Submit int
)
AS 

	DECLARE @SampleLabelId uniqueidentifier
	DECLARE @SampleLblId uniqueidentifier		
	DECLARE @SampleSizeId	uniqueidentifier
	DECLARE @EvalSizeCol int
	DECLARE @SampleCount int
	DECLARE @SizeColCnt int
	DECLARE @ResubmitDays int
	Declare @EvalSize nvarchar(200)
	Declare @SampleLbl nvarchar(200)
	
	
	SELECT @SampleCount = COUNT(SampleIndex) FROM  pmsevalsamplbl WITH (NOLOCK) where SampleRequestHeaderId = @SampleRequestHeaderId
	select @EvalSizeCol=Sizecol, @EvalSize=Measlbl from pAMLMeasLbl where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasLblId=@EvalSizeID
	select @SampleSizeId=AMLMeasLblId, @SampleLbl=Measlbl from pAMLMeasLbl where AMLMeasHdrId=@AMLMeasHdrId and IsSample=1
	
	update pMSEvalHeader set EvalSizeId=@EvalSizeId, EvalSize=@EvalSize, SampleSizeId=@SampleSizeId, SampleSize=@SampleLbl where AMLMeasHdrId=@AMLMeasHdrId and SampleRequestHeaderId=@SampleRequestHeaderId
	 
	delete from pmsevalpom where SampleRequestHeaderId=@SampleRequestHeaderId and amlmeashdrid=@amlmeashdrid and AmlMeaspomid not in (select AmlMeaspomid from pamlmeaspom where amlmeashdrid=@AMLMeasHdrId)	
	
	delete from pmsevalsampMeas where SampleRequestHeaderId=@SampleRequestHeaderId and amlmeashdrid=@amlmeashdrid and samplepomid not in (select samplepomid from pmsevalpom where amlmeashdrid=@AMLMeasHdrId
	and SampleRequestHeaderId=@SampleRequestHeaderId)
		
	Update pmsevalpom set Refcode = p.Refcode, POMDescription = p.Description, TolMinus = p.TolMinus, TolPlus = p.TolPlus, 
	POMRow = p.POM_Row, WSRowId = p.WSRowId, HowToMeasurText = p.How2MeasText, ImageId = p.ImageId, SortId = p.SortId
	from pmsevalpom i inner join pamlmeaspom p on 
	i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid 									 
	where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId 		
	
	Update pmsevalsampMeas set POMRow = p.POMRow 	from pmsevalsampMeas i inner join pmsevalpom p on 
	i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.samplepomid=p.samplepomid									 
	and i.SampleRequestHeaderId=p.SampleRequestHeaderId where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId 
	
       			
	Update pmsevalsampMeas set EvalMeasValue = p.Grade, AmlMeasIGCid = p.AmlMeasIGCid from pmsevalsampMeas i inner join pAMLMeasIGC p on
	i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid 
	and i.POMRow=p.POM_Row  where  p.Sizecol = @Evalsizecol and p.AMLMeasHdrId=@AMLMeasHdrId and
	i.SampleRequestHeaderId=@SampleRequestHeaderId	and i.SampleIndex = @Submit				
			
	insert into pmsevalpom (SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, POMRow , Refcode , POMDescription  ,TolPlus
     ,TolMinus , WSRowId  , HowToMeasurText ,ImageId , SortId)
	select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid,  POM_Row,  Refcode , Description  ,TolPlus
    ,TolMinus ,WSRowId  , How2MeasText ,ImageId , SortId from pAMLMeasPOM 
    where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId Not in ( select AmlMeaspomid from pmsevalpom where SampleRequestHeaderId=@SampleRequestHeaderId)
    
    	
	set @SizeColCnt  =1
    WHILE @SizeColCnt <= @SampleCount 
	begin
	
		SELECT @SampleLblId = SampleLabelId from pmsevalsamplbl where SampleRequestHeaderId = @SampleRequestHeaderId 
		and AMLMeasHdrId=@AMLMeasHdrId and SampleIndex=@SizeColCnt
		
		if @SizeColCnt<@Submit
			begin
				insert into pmsevalsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, SampleLabelId, POMRow , SampleIndex )
				select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, @SampleLblId, POM_Row, @SizeColCnt from pAMLMeasIGC where  AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@EvalSizeCol
				and AMLMeasPOMId Not in ( select AmlMeaspomid from pmsevalsampMeas where SampleRequestHeaderId=@SampleRequestHeaderId and SampleIndex=@SizeColCnt)
			end
		else
			begin
				insert into pmsevalsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, SampleLabelId, POMRow , SampleIndex ,EvalMeasValue )
				select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, @SampleLblId, POM_Row, @Submit , Grade from pAMLMeasIGC where  AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@EvalSizeCol
				and AMLMeasPOMId Not in ( select AmlMeaspomid from pmsevalsampMeas where SampleRequestHeaderId=@SampleRequestHeaderId and SampleIndex=@Submit)
			end
		
		SET @SizeColCnt = @SizeColCnt + 1
	end  
	    
		
	Update pmsevalsampMeas set samplepomid = p.samplepomid from pmsevalsampMeas i inner join pmsevalpom p on 
		i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.pomrow=p.pomrow and i.SampleRequestHeaderId=p.SampleRequestHeaderId										 
		where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId and i.samplepomid is null


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10022', GetUTCDate())
GO
