IF OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_GRMeasurements_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_GRMeasurements_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_GRMeasurements_INSERT]
(
	@POMTempId uniqueidentifier,
	@StyleID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@StyleSet int,
	@ChangeTemp nvarchar(2),
	@SampleRequestAMLMeasHdrId uniqueidentifier,
	@SampleRequestTradeID uniqueidentifier,
	@Submit int,		
	@CDate datetime,
	@CUser  nvarchar(200) 
)
AS

begin

Declare @Maxcount int
Declare @RowCnt int
Declare @colCnt int
Declare @IncrCols nvarchar(2000)
Declare @MaxSizeCnt int
DECLARE @query NVARCHAR(max)
DECLARE @SizerangeId nvarchar(50)
DECLARE @classrangeId nvarchar(50)
DECLARE @SizeRangeCode nvarchar(200)
DECLARE @sizeclassId nvarchar(50)
Declare @samplecol int
DECLARE @PomDesc nvarchar(200)
DECLARE @POMType nvarchar(100)
DECLARE @POMTempGroupID nvarchar(50)
DECLARE @sizeclass nvarchar(400)
Declare @Relative int
Declare @Negative int
Declare @Metric int 

set @RowCnt = 0
set @colCnt = 0
set @MaxSizeCnt=0
set @Maxcount=49
set @IncrCols = ''
set @samplecol=0

Select @SizeRangeId = t.SizeRangeId, @ClassRangeId = t.ClassRangeId, 
       @SizeClassId = t.SizeClassId, 
	   @SizeRangeCode = COALESCE(sr.SizeRangeCode, t.SizeRange), 
	   @SizeClass = COALESCE(sc.Custom, t.SizeClass),
       @PomDesc = t.POMTypeDescription, @POMType = t.POMType, 
	   @POMTempGroupID = t.POMTempGroupID ,
       @samplecol = CONVERT(INT, COALESCE(t.SampleSize, '0')) 
from pGRMeasurementsPOMTemplate t
left join pSizeClass sc ON sc.CustomID = t.SizeClassId
left join pSizeRange sr ON sr.CustomId = t.SizeRangeId
where t.POMTempID = @POMTempId

Select @Relative=[Relative], @Negative=Negative, @Metric=Metric from pGRMeasurementsPOMTemplateGroup where POMTempID = @POMTempId

WHILE @RowCnt <= @Maxcount
	begin
		set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @RowCnt) + ','				
		set @RowCnt = @RowCnt + 1
	end	
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)			
	
CREATE TABLE #tempPOM (
			 sizeRowid int NOT NULL IDENTITY (0, 1)				 
			 ,SizeRangeId UNIQUEIDENTIFIER	
			 ,SizeRange nvarchar(200) collate database_default			 			 
			 ,sizeid nvarchar(10) collate database_default
			 ,sizename nvarchar(10) collate database_default
			 ,sizeDesc nvarchar(200) collate database_default
			 )		

SET @query = N'select SizeRangeId, SizeRange, sizeid, sizename
	from 
		(select CustomId as SizeRangeId, SizeRangeCode as SizeRange,  ' + @IncrCols + ' from pSizeRange
		 where CustomId = ''' + convert(nvarchar(50),@SizerangeId) + ''' and SizeRangeCode = N''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
	unpivot
	(sizename For sizeid in (' + @IncrCols + ')) as unpvt where sizename is not null and sizename <> '''';'		

INSERT #tempPOM (SizeRangeId, SizeRange, sizeid, sizename) EXEC (@query) 

SET @query = 
N'UPDATE #tempPOM
SET sizeDesc = pSizeRangeDesc.sizename
	FROM 
	(
		select SizeRangeId, SizeRange, REPLACE(sizeid,''Desc'','''') as sizeid, sizename
		from
		(select CustomId as SizeRangeId, SizeRangeCode as SizeRange, ' + REPLACE(@IncrCols,'Size','SizeDesc') + ' from pSizeRange
			 where CustomId = ''' + convert(nvarchar(50),@SizerangeId) + ''' and SizeRangeCode = N''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
		unpivot
		(sizename For sizeid in (' + REPLACE(@IncrCols,'Size','SizeDesc') + ')) as unpvt where sizename is not null and sizename <> ''''
	) as pSizeRangeDesc
WHERE #tempPOM.sizeid = pSizeRangeDesc.sizeid'

EXEC(@query)


select @MaxSizeCnt= count(sizeRowid) from #tempPOM 

/* Get sample size from psizerange
CREATE TABLE #tempSampleSize (
			 sizeRowid int NOT NULL IDENTITY (0, 1)				 
			 ,SizeRangeId UNIQUEIDENTIFIER	
			 ,SizeRange nvarchar(50)			 
			 ,Sampleid nvarchar(10)
			 ,SampleSel int	
			 )
			 
set @IncrCols = REPLACE(@IncrCols, 'Size', 'Sel')	
			 
SET @query = N'select SizeRangeId, SizeRange ,Sampleid, SampleSel
from 
	(select CustomId as SizeRangeId, SizeRangeCode as SizeRange ,  ' + @IncrCols + ' from pSizeRange
	 where CustomId = ''' + convert(nvarchar(50),@SizeRangeId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p 
	 unpivot
    (SampleSel For Sampleid in (' + @IncrCols + ')) as unpvt where SampleSel=1 ;'

--select @query as igcqry

INSERT #tempSampleSize EXEC (@query) 
--select * from #tempSampleSize

select @samplecol = convert(int,substring(Sampleid,4,LEN(Sampleid))) from #tempSampleSize 
drop table #tempSampleSize 
*/
if @ChangeTemp<>'1'
	begin 
	IF  EXISTS(SELECT * FROM pSampleRequestamlmeashdr WHERE SampleRequestAMLMeasHdrId=@SampleRequestAMLMeasHdrId) begin
	DELETE FROM pSampleRequestamlmeashdr WHERE SampleRequestAMLMeasHdrId=@SampleRequestAMLMeasHdrId
	end
	
		INSERT INTO pSampleRequestamlmeashdr(SampleRequestAMLMeasHdrId, WorkflowID, WorkflowItemID, StyleSet, Styleid, Companyid, CompanyName, IsRelative, IsNegative, IsMetric,
		SizeClassId, SizeClass, SizeRangeId, SizeRange, ProductTypeId, ProductType, MeasRowCnt, CUser, CDate, MUser, MDate, SampleRequestTradeID, Submit)
		Select @SampleRequestAMLMeasHdrId, @WorkflowID, '00000000-0000-0000-0000-000000000000', @StyleSet, @StyleID, @POMTempId, POMType, [Relative], Negative, Metric,
		SizeClassId, SizeClass, SizeRangeId, SizeRange, POMTempGroupID, POMTypeDescription, 0, @CUser, @CDate, @CUser, @CDate, @SampleRequestTradeID, @Submit
		from pGRMeasurementsPOMTemplateGroup WITH (NOLOCK) where POMTempID=@POMTempID and classrangeId=@classrangeId
	end
else
	begin
		update pSampleRequestamlmeashdr set 	Companyid=@POMTempId, CompanyName=@POMType, IsRelative=@Relative, IsNegative=@Negative, IsMetric=@Metric,
		SizeClassId=@SizeClassId, SizeClass=@SizeClass, SizeRangeId=@SizeRangeId, SizeRange=@SizeRangeCode, ProductTypeId=@POMTempGroupID, ProductType=@POMDesc, 
		MeasRowCnt=0, CUser=@CUser, CDate=@CDate, MUser=@CUser, MDate=CDate
		where SampleRequestAMLMeasHdrId=@SampleRequestAMLMeasHdrId and WorkflowID=@WorkflowID  
		and Styleid=@Styleid and StyleSet=@StyleSet
		
		
		delete from pSampleRequestAMLMeasPOM where SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
		delete from pSampleRequestAMLMeasIGC where SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
		delete from pSampleRequestAMLMeasLbl where SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
	end
	
IF @MaxSizeCnt  > 0 
	Begin
		Insert into pSampleRequestamlmeaslbl(SampleRequestAMLMeasHdrId, SizeRangeId, SizeRangeDetailId, sizecol, MeasLbl, MeasLblDesc, 
		Isvisible, Issample, MeasDesc, Cuser, CDate, MUser, MDate) 
		select @SampleRequestAMLMeasHdrId, SizeRangeId, NEWID(),sizeRowid, SizeName, sizeDesc, 1, 0, sizeid, @CUser, @CDate, @CUser, @CDate
		from #tempPOM
		
		-- where sizename is not null and sizename <> ''
		update pSampleRequestamlmeaslbl set IsSample=1 where SampleRequestAMLMeasHdrId=@SampleRequestAMLMeasHdrId and SizeCol=@samplecol and SizeRangeId=@SizeRangeId
		
	End
	
drop table #tempPOM

EXEC spx_SampleRequest_DesignSample_GRMeasurementsPOM_Insert	
	@SampleRequestAMLMeasHdrId,
	@POMTempId,	
	@CUser,
	@CDate	
end


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09537', GetDate())
GO
