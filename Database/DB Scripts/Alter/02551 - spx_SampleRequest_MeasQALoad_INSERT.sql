IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQALoad_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQALoad_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_MeasQALoad_INSERT]
(
@AMLMeasHdrId nvarchar(50),
@AmlMeasLblId nvarchar(50),
@SampleNo int,
@SizeCnt int,
@SampleRequestWorkflowID nvarchar(50),
@SampleRequestTradeID nvarchar(50),
@SampleWorkflowID nvarchar(50),
@TradePartnerVendorID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet Int,
@StyleColorID nvarchar(50),
@Submit int,        
@UserName nvarchar(50),
@UserDate datetime
)

AS 

declare @SampleRequestHeaderId nvarchar(50)
declare @SampleLabelId nvarchar(50)
declare @EvalSize nvarchar(24)
declare @EvalSizeCol int
declare @Row_Count int
declare @submit_Count int

set @SampleLabelId = NEWID()
set @Row_Count=1
set @submit_Count=1
select @EvalSize=Measlbl, @EvalSizeCol=Sizecol from pAMLMeasLbl where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasLblId=@AmlMeasLblId

if (@SizeCnt=0)	
	begin
		set @SampleRequestHeaderId = NEWID()
		insert into pQAHeader (SampleRequestHeaderId, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID
		,TradePartnerVendorID, WorkflowID, WorkFlowItemId, StyleId, StyleColorID, StyleSet, AMLMeasHdrId
		,Submit, CompanyName, IsRelative, IsMetric, SizeClassId, SizeClass, SizeRangeId, SizeRange, ProductTypeId,
		ProductType, CUser, Cdate)      
		select @SampleRequestHeaderId , @SampleRequestTradeID, @SampleRequestWorkflowID, @SampleWorkflowID, 
		@TradePartnerVendorID, WorkflowID, WorkFlowItemId, @StyleID, @StyleColorID, @StyleSet, @AMLMeasHdrId, 
		@Submit , CompanyName, IsRelative, IsMetric , SizeClassId, SizeClass, SizeRangeId, SizeRange, ProductTypeId, ProductType, 
		@UserName, @UserDate
		from pAMLMeasHdr where AMLMeasHdrId = @AMLMeasHdrId 
	
		insert into pQApom (SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, POMRow , Refcode , POMDescription  ,TolPlus
		,TolMinus , WSRowId  , HowToMeasurText ,ImageId , SortId)
		select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid,  POM_Row,  Refcode , Description  ,COALESCE(TolPlus,0)
		,COALESCE(TolMinus,0) ,WSRowId  , How2MeasText ,ImageId , SortId from pAMLMeasPOM 
		where AMLMeasHdrId=@AMLMeasHdrId
	
		insert into pQAsamplbl (SampleLabelId, SampleRequestHeaderId, AMLMeasHdrId, AMLMeasLblId,
		Submit, SizeCol, ColLabel, IsVisible, SampleNo, NextSampleNo, Cuser, Cdate) values 
		(@SampleLabelId, @SampleRequestHeaderId, @AMLMeasHdrId, @AMLMeasLblId, @Submit, @EvalSizeCol, @EvalSize,
		1,@SampleNo,convert(int, @SampleNo)+1, @UserName, @UserDate)

				
		 WHILE @SampleNo >= @Row_Count 
			begin
				
				insert into pQAsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasLblid, AmlMeasIGCid, SampleLabelId, POMRow , SizeCol, Submit, sampleNo, MeasValue, SampMeasValue,  CUser, CDate)
				select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid, @AmlMeasLblid, AmlMeasIGCid, @SampleLabelId, POM_Row, @EvalSizeCol, @Submit, @Row_Count, Grade, 0, @UserName, @UserDate from pAMLMeasIGC where  AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@EvalSizeCol

				set @Row_Count = @Row_Count + 1
			end
      

			Update pQAsampMeas set samplepomid = p.samplepomid from pQAsampMeas i inner join pQApom p on 
			i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.pomrow=p.pomrow and i.SampleRequestHeaderId=p.SampleRequestHeaderId										 
			where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId and i.samplepomid is null


	end
else
	begin
		select @SampleRequestHeaderId = SampleRequestHeaderId from pQAHeader where
		SampleRequestTradeID = @SampleRequestTradeID and SampleRequestWorkflowID=@SampleRequestWorkflowID and sampleWorkflowID=@SampleWorkflowID and
		TradePartnerVendorID=@TradePartnerVendorID and   StyleID = @StyleID and StyleColorID=@StyleColorID and  StyleSet= @StyleSet and AMLMeasHdrId=@AMLMeasHdrId
		and Submit=@Submit
		
		insert into pQAsamplbl (SampleLabelId, SampleRequestHeaderId, AMLMeasHdrId, AMLMeasLblId,
		Submit, SizeCol, ColLabel, IsVisible, SampleNo, NextSampleNo, Cuser, Cdate) values 
		(@SampleLabelId, @SampleRequestHeaderId, @AMLMeasHdrId, @AMLMeasLblId, @Submit, @EvalSizeCol, @EvalSize,
		1,@SampleNo,convert(int, @SampleNo)+1, @UserName, @UserDate)
		
		WHILE @Submit >= @submit_Count  
			begin
				WHILE @SampleNo >= @Row_Count 
					begin					
						insert into pQAsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasLblid, AmlMeasIGCid, SampleLabelId, POMRow , SizeCol, Submit, sampleNo, MeasValue,  SampMeasValue , CUser, CDate)
						select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid, @AmlMeasLblid, AmlMeasIGCid, @SampleLabelId, POM_Row, @EvalSizeCol, @submit_Count, @Row_Count, Grade, 0, @UserName, @UserDate from pAMLMeasIGC where  AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@EvalSizeCol
						set @Row_Count = @Row_Count + 1
					end
				set @submit_Count = @submit_Count + 1
	      end

		Update pQAsampMeas set samplepomid = p.samplepomid from pQAsampMeas i inner join pQApom p on 
		i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.pomrow=p.pomrow and i.SampleRequestHeaderId=p.SampleRequestHeaderId										 
		where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId and i.samplepomid is null

		
	end

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02551'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02551', GetDate())

END
GO