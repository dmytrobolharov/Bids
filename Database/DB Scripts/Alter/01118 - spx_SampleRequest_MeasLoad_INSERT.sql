
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasLoad_INSERT]    Script Date: 02/10/2011 10:50:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequest_MeasLoad_INSERT') 
DROP PROCEDURE spx_SampleRequest_MeasLoad_INSERT
GO

Create PROCEDURE [dbo].[spx_SampleRequest_MeasLoad_INSERT]
(
@SpecPageID nvarchar(50),
@EvalSizeID  nvarchar(50),
@SampleSizeID nvarchar(50),
@SampleSize nvarchar(24),
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

set @SampleRequestHeaderId = NEWID()
set @SampleLabelId = NEWID()

select @EvalSize=Measlbl, @EvalSizeCol=Sizecol from pAMLMeasLbl where AMLMeasHdrId=@SpecPageID and AMLMeasLblId=@EvalSizeID

insert into pMSEvalHeader (SampleRequestHeaderId, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID
,TradePartnerVendorID, WorkflowID, WorkFlowItemId, StyleId, StyleColorID, StyleSet, AMLMeasHdrId
,Submit, CompanyName, IsRelative, IsMetric, SizeClassId, SizeClass, SizeRangeId, SizeRange, ProductTypeId,
ProductType, SampleSizeId, SampleSize, EvalSizeId, EvalSize)      
select @SampleRequestHeaderId , @SampleRequestTradeID, @SampleRequestWorkflowID, @SampleWorkflowID, 
@TradePartnerVendorID, WorkflowID, WorkFlowItemId, @StyleID, @StyleColorID, @StyleSet, @SpecPageID, 
@Submit , CompanyName, IsRelative, IsMetric , SizeClassId, SizeClass, SizeRangeId, SizeRange, ProductTypeId, ProductType, @SampleSizeID, @Samplesize, @EvalSizeID, @EvalSize
from pAMLMeasHdr where AMLMeasHdrId = @SpecPageID 

insert into pmsevalsamplbl (SampleLabelId, SampleRequestHeaderId, AMLMeasHdrId, SampleIndex) values (@SampleLabelId, @SampleRequestHeaderId, @SpecPageID, @Submit)

insert into pmsevalpom (SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, POMRow , Refcode , POMDescription  ,TolPlus
      ,TolMinus , WSRowId  , HowToMeasurText ,ImageId , SortId)
select  @SampleRequestHeaderId, @SpecPageID, AmlMeaspomid,  POM_Row,  Refcode , Description  ,TolPlus
      ,TolMinus ,WSRowId  , How2MeasText ,ImageId , SortId from pAMLMeasPOM 
      where AMLMeasHdrId=@SpecPageID
      
insert into pmsevalsampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AmlMeasIGCid, SampleLabelId, POMRow , SampleIndex ,EvalMeasValue )
select  @SampleRequestHeaderId, @SpecPageID, AmlMeaspomid, AmlMeasIGCid, @SampleLabelId, POM_Row, @Submit , Grade from pAMLMeasIGC where  AMLMeasHdrId=@SpecPageID and SizeCol=@EvalSizeCol

Update pmsevalsampMeas set samplepomid = p.samplepomid from pmsevalsampMeas i inner join pmsevalpom p on 
		i.AMLMeasHdrId=p.AMLMeasHdrId and i.AmlMeaspomid=p.AmlMeaspomid and i.pomrow=p.pomrow and i.SampleRequestHeaderId=p.SampleRequestHeaderId										 
		where i.amlmeashdrid=@SpecPageID and i.SampleRequestHeaderId=@SampleRequestHeaderId and i.samplepomid is null


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01118', GetDate())
