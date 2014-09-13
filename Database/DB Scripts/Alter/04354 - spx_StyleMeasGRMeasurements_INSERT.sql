IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasGRMeasurements_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasGRMeasurements_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleMeasGRMeasurements_INSERT]
(
	@POMTempId uniqueidentifier,
	@StyleID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleSet int,
	@ChangeTemp nvarchar(2),
	@AMLMeasHdrId uniqueidentifier,		
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
DECLARE @SizeRangeCode nvarchar(50)
DECLARE @sizeclassId nvarchar(50)
Declare @samplecol int
DECLARE @PomDesc nvarchar(200)
DECLARE @POMType nvarchar(100)
DECLARE @POMTempGroupID nvarchar(50)
DECLARE @sizeclass nvarchar(100)
Declare @Relative int
Declare @Negative int
Declare @Metric int 

set @RowCnt = 0
set @colCnt = 0
set @MaxSizeCnt=0
set @Maxcount=49
set @IncrCols = ''
set @samplecol=0

Select @SizerangeId = SizerangeId, @classrangeId = classrangeId, @sizeclassId = sizeclassId, 
@SizeRangeCode = SizeRange, @sizeclass = sizeclass,
@PomDesc=POMTypeDescription, @POMType=POMType, @POMTempGroupID=POMTempGroupID ,
@samplecol=convert(int,COALESCE(samplesize,'0')) from pGRMeasurementsPOMTemplate 
where POMTempID = @POMTempId

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
			 ,SizeRange nvarchar(50)			 			 
			 ,sizeid nvarchar(10)
			 ,sizename nvarchar(10)
			 ,sizeDesc nvarchar(200)				 
			 )		
			
SET @query = N'select SizeRangeId, SizeRange, sizeid, sizename
	from 
		(select CustomId as SizeRangeId, SizeRangeCode as SizeRange,  ' + @IncrCols + ' from pSizeRange
		 where CustomId = ''' + convert(nvarchar(50),@SizerangeId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
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
			 where CustomId = ''' + convert(nvarchar(50),@SizerangeId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRangeCode) + ''') p
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
		INSERT INTO pamlmeashdr(AMLMeasHdrId, WorkflowID, WorkflowItemID, StyleSet, Styleid, Companyid, CompanyName, IsRelative, IsNegative, IsMetric,
		SizeClassId, SizeClass, SizeRangeId, SizeRange, ProductTypeId, ProductType, MeasRowCnt, CUser, CDate, MUser, MDate)
		Select @AMLMeasHdrId, @WorkflowID, @WorkflowItemID, @StyleSet, @StyleID, @POMTempId, POMType, [Relative], Negative, Metric,
		SizeClassId, SizeClass, SizeRangeId, SizeRange, POMTempGroupID, POMTypeDescription, 0, @CUser, @CDate, @CUser, @CDate
		from pGRMeasurementsPOMTemplateGroup WITH (NOLOCK) where POMTempID=@POMTempID and classrangeId=@classrangeId
	end
else
	begin
		update pamlmeashdr set 	Companyid=@POMTempId, CompanyName=@POMType, IsRelative=@Relative, IsNegative=@Negative, IsMetric=@Metric,
		SizeClassId=@SizeClassId, SizeClass=@SizeClass, SizeRangeId=@SizeRangeId, SizeRange=@SizeRangeCode, ProductTypeId=@POMTempGroupID, ProductType=@POMDesc, 
		MeasRowCnt=0, CUser=@CUser, CDate=@CDate, MUser=@CUser, MDate=CDate
		where AMLMeasHdrId=@AMLMeasHdrId and WorkflowID=@WorkflowID and WorkflowItemID=@WorkflowItemID 
		and Styleid=@Styleid and StyleSet=@StyleSet
	end
	
IF @MaxSizeCnt  > 0 
	Begin
		Insert into pamlmeaslbl(AMLMeasHdrId, SizeRangeId, SizeRangeDetailId, sizecol, MeasLbl, MeasLblDesc, 
		Isvisible, Issample, MeasDesc, Cuser, CDate, MUser, MDate) 
		select @AMLMeasHdrId, SizeRangeId, NEWID(),sizeRowid, SizeName, sizeDesc, 1, 0, sizeid, @CUser, @CDate, @CUser, @CDate
		from #tempPOM
		
		-- where sizename is not null and sizename <> ''
		update pamlmeaslbl set IsSample=1 where AMLMeasHdrId=@AMLMeasHdrId and SizeCol=@samplecol and SizeRangeId=@SizeRangeId
		
	End
	
drop table #tempPOM

EXEC spx_StyleMeasGRMeasurementsPOM_Insert	
	@AMLMeasHdrId,
	@POMTempId,	
	@CUser,
	@CDate	
end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04354', GetDate())
GO
