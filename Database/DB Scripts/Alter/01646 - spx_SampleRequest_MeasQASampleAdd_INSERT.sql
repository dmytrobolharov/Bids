
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasQASampleAdd_INSERT]    Script Date: 07/14/2011 12:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQASampleAdd_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQASampleAdd_INSERT]
GO

Create PROCEDURE [dbo].[spx_SampleRequest_MeasQASampleAdd_INSERT]
(
@SampleRequestHeaderId nvarchar(50),
@AMLMeasHdrId nvarchar(50),
@AmlMeasLblId nvarchar(50),
@SampleNo int,
@Submit int,        
@UserName nvarchar(50),
@UserDate datetime
)

AS 

SET NOCOUNT ON

declare @SampleLabelId nvarchar(50)
declare @EvalSize nvarchar(24)
declare @EvalSizeCol int
declare @Row_Count int
declare @submit_Count int
declare @oldsampleNo int
declare @NewsampleNo int
set @SampleLabelId = NEWID()

set @submit_Count=1

select @EvalSize=Measlbl, @EvalSizeCol=Sizecol from pAMLMeasLbl where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasLblId=@AmlMeasLblId

select @SampleLabelId = SampleLabelId, @oldsampleNo=sampleno from pQAsamplbl where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasLblId=@AmlMeasLblId
and SampleRequestHeaderId=@SampleRequestHeaderId and Sizecol=@EvalSizeCol

set @NewsampleNo=@oldsampleNo+@sampleNo	
set @Row_Count=@oldsampleNo	

update pQAsamplbl set SampleNo = @NewsampleNo, NextSampleNo=convert(int, @NewsampleNo)+1 where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasLblId=@AmlMeasLblId
and SampleRequestHeaderId=@SampleRequestHeaderId and SampleLabelId=@SampleLabelId

WHILE @Submit >= @submit_Count  
	begin
		WHILE @NewSampleNo > @Row_Count 
			begin					
				insert into pQAsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasLblid, AmlMeasIGCid, SampleLabelId, POMRow , SizeCol, Submit, sampleNo, MeasValue,  SampMeasValue , CUser, CDate)
				select  @SampleRequestHeaderId, @AMLMeasHdrId, AmlMeaspomid, @AmlMeasLblid, AmlMeasIGCid, @SampleLabelId, POM_Row, @EvalSizeCol, @submit_Count, @Row_Count+1, Grade, 0, @UserName, @UserDate from pAMLMeasIGC where  AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@EvalSizeCol
				set @Row_Count = @Row_Count + 1
			end
		set @submit_Count = @submit_Count + 1
  end

Update pQAsampMeas set samplepomid = p.samplepomid from pQAsampMeas i inner join pQApom p on 
i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.pomrow=p.pomrow and i.SampleRequestHeaderId=p.SampleRequestHeaderId										 
where i.amlmeashdrid=@AMLMeasHdrId and i.SampleRequestHeaderId=@SampleRequestHeaderId and i.samplepomid is null


SET NOCOUNT OFF
GO
			
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01646', GetDate())



