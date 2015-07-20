IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequest_MeasReviseSample_UPDATE')
   DROP PROCEDURE spx_SampleRequest_MeasReviseSample_UPDATE
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequest_MeasReviseSample_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@AMLMeasPOMId uniqueidentifier,
@POMRow int,
@EvalSizeCol int,
@EvalValue numeric(18,4)
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
Declare @Metric int
Declare @IsRelative int
Declare @samplevalue decimal(18,4)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#tempMeasData') AND type in (N'U'))
DROP TABLE #tempMeasData

CREATE TABLE #tempMeasData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 pom_row int,
 sizecol int,
 amlmeasigcid uniqueidentifier,
 Grade decimal(18,4),
 ConvGrade decimal(18,4)
)

select @Metric = Ismetric, @IsRelative = IsRelative from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId


Update pAMLMeasIGC set  Incr=@EvalValue WHERE	AMLMeasHdrId = @AMLMeasHdrId
and AMLMeasPOMId=@AMLMeasPOMId and pom_row=@POMRow and SizeCol=@EvalSizeCol


If @IsRelative=0
	begin	
		if @Metric=0
			begin
				SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
				from pamlmeasigc a cross join pamlmeasigc b
				where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.amlmeaspomid=''' + 
				cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row =''' + cast(@POMRow as nvarchar(5)) + '''
				and a.sizecol <= b.sizecol and b.sizecol<= ' + cast(@EvalSizeCol as nvarchar(2)) +
				' and a.amlmeaspomid=b.amlmeaspomid and a.pom_row=b.pom_row
				group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
				union
				select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
				from pamlmeasigc a cross join pamlmeasigc b
				where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.amlmeaspomid=''' + 
				cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row = ''' + cast(@POMRow as nvarchar(5)) + '''
				and a.sizecol >= b.sizecol and b.sizecol>= ' + cast(@EvalSizeCol as nvarchar(2)) + '  and a.amlmeaspomid=b.amlmeaspomid
				and a.pom_row=b.pom_row group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
				order by pom_row, sizecol ;'

				INSERT  #tempMeasData EXEC (@query)

				--select * from #tempMeasData

				set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade=#tempMeasData.Grade, pamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pamlmeasigc  INNER JOIN
				#tempMeasData ON pamlmeasigc.amlmeasigcid = #tempMeasData.amlmeasigcid AND pamlmeasigc.amlmeaspomid = #tempMeasData.amlmeaspomid AND 
				pamlmeasigc.amlmeashdrid = #tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.sizecol=#tempMeasData.sizecol 
				where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' and pamlmeasigc.amlmeaspomid=''' +
				cast(@AMLMeasPOMId as nvarchar(50)) + ''' and pamlmeasigc.pom_row = ''' + cast(@POMRow as nvarchar(5)) + ''';'
				              
				EXEC (@queryUpd)
			end
		else
			begin
				SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr/(2.54)) as ConvGrade
				from pamlmeasigc a cross join pamlmeasigc b
				where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.amlmeaspomid=''' + 
				cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row =''' + cast(@POMRow as nvarchar(5)) + '''
				and a.sizecol <= b.sizecol and b.sizecol<= ' + cast(@EvalSizeCol as nvarchar(2)) + ' and
				a.amlmeaspomid=b.amlmeaspomid and a.pom_row=b.pom_row
				group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
				union
				select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr/(2.54)) as ConvGrade
				from pamlmeasigc a cross join pamlmeasigc b
				where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.amlmeaspomid=''' + 
				cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row = ''' + cast(@POMRow as nvarchar(5)) + '''
				and a.sizecol >= b.sizecol and b.sizecol>= ' + cast(@EvalSizeCol as nvarchar(2)) + ' and a.amlmeaspomid=b.amlmeaspomid
				and a.pom_row=b.pom_row group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
				order by pom_row, sizecol ;'

				INSERT  #tempMeasData EXEC (@query)

				--select * from #tempMeasData

				set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade=#tempMeasData.Grade, pamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pamlmeasigc  INNER JOIN
				#tempMeasData ON pamlmeasigc.amlmeasigcid = #tempMeasData.amlmeasigcid AND pamlmeasigc.amlmeaspomid = #tempMeasData.amlmeaspomid AND 
				pamlmeasigc.amlmeashdrid = #tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.sizecol=#tempMeasData.sizecol 
				where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' and pamlmeasigc.amlmeaspomid=''' +
				cast(@AMLMeasPOMId as nvarchar(50)) + ''' and pamlmeasigc.pom_row = ''' + cast(@POMRow as nvarchar(5)) + ''';'
				              
				EXEC (@queryUpd)
			end
			--select * from pamlmeasigc order by pom_row, sizecol

		DROP TABLE #tempMeasData
	end
else
	begin
		if  @Metric = 0
			begin
				select @samplevalue = Incr from pamlmeasigc  where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
				amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and  sizecol = @EvalSizeCol 

				Update pamlmeasigc  set Grade = (@samplevalue + incr), ConvGrade=((@samplevalue + incr)*2.54) 
				where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
				amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol <> @EvalSizeCol

				Update pamlmeasigc  set Grade = @samplevalue, ConvGrade=(@samplevalue*2.54) 
				where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
				amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol = @EvalSizeCol
			end
		else
			begin
				select @samplevalue = Incr from pamlmeasigc  where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
				amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and  sizecol = @EvalSizeCol 

				Update pamlmeasigc  set Grade = (@samplevalue + incr), ConvGrade=((@samplevalue + incr)/(2.54)) 
				where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
				amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol <> @EvalSizeCol

				Update pamlmeasigc  set Grade = @samplevalue, ConvGrade=(@samplevalue/(2.54)) 
				where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
				amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol = @EvalSizeCol
			end
	end

Go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequest_MeasSample_UPDATE')
   DROP PROCEDURE spx_SampleRequest_MeasSample_UPDATE
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasSample_UPDATE]    Script Date: 12/14/2010 12:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[spx_SampleRequest_MeasSample_UPDATE] (
@SampleRequestHeaderId UNIQUEIDENTIFIER,
@SampleMeasId UNIQUEIDENTIFIER,
@Submit INT,
@PostRev int,
@CopySpec int,
@CopyRev int
)
AS 

declare @SamplePomId UNIQUEIDENTIFIER
declare @VdrMeasValue numeric(18,4)
declare @EvalMeasValue numeric(18,4)
declare @SampMeasValue numeric(18,4)
declare @VdrDelta numeric(18,4)
declare @SampDelta numeric(18,4)
declare @Tolplus numeric(18,4)
declare @TolMinus numeric(18,4)
declare @RevisedSpec numeric(18,4)
declare @VdrOutTol int
declare @SampOutTol int
declare @AMLMeasPOMId UNIQUEIDENTIFIER
declare @AMLMeasHdrId UNIQUEIDENTIFIER
declare @SampleSizeId UNIQUEIDENTIFIER
declare @EvalSizeId UNIQUEIDENTIFIER
declare @AMLMeasIGCId UNIQUEIDENTIFIER
declare @POMRow int
declare @IsNotEvalSameAsSampleSize int
declare @EvalSizecol int
declare @SampleSizecol int
declare @EvalGrade numeric(18,4)
declare @blnIssample int
declare @SampleGrade numeric(18,4)
declare @GradeDiff numeric(18,4)
declare @sampleRevisedValue numeric(18,4)

set @blnIssample=0
set @IsNotEvalSameAsSampleSize=0

select @SamplePomId = SamplePomId , @VdrMeasValue = VdrMeasValue, @EvalMeasValue = EvalMeasValue,
@SampMeasValue = SampMeasValue, @RevisedSpec=RevisedSpec, @AMLMeasPOMId=AMLMeasPOMId, @AMLMeasIGCId=AMLMeasIGCId, @POMRow=POMRow   from pMSEvalSampMeas 
where SampleRequestHeaderId=@SampleRequestHeaderId and sampleIndex=@Submit and SampleMeasId=@SampleMeasId

if @CopySpec=1   
	begin
		set @SampMeasValue=@VdrMeasValue
	end

if @CopyRev=1 
	begin
		set @RevisedSpec=@SampMeasValue
	end
	
if 	@CopySpec=1 or @CopyRev=1
	begin
		update pMSEvalSampMeas set SampMeasValue=@SampMeasValue, RevisedSpec=@RevisedSpec
		where SampleRequestHeaderId=@SampleRequestHeaderId and sampleIndex=@Submit and SampleMeasId=@SampleMeasId
		and SamplePomId=@SamplePomId and AMLMeasPOMId=@AMLMeasPOMId
	end

select @AMLMeasHdrId = AMLMeasHdrId, @EvalSizeId = EvalSizeId 
from pMSEvalHeader where SampleRequestHeaderId = @SampleRequestHeaderId

select @EvalSizecol = sizecol from pAMLMeasLbl where AMLMeasHdrId = @AMLMeasHdrId and AMLMeasLblId = @EvalSizeId
select @SampleSizecol = sizecol, @SampleSizeId = AMLMeasLblId from pAMLMeasLbl where AMLMeasHdrId = @AMLMeasHdrId and IsSample=1

select @EvalGrade=Grade from pAMLMeasIGC where AMLMeasHdrId = @AMLMeasHdrId and AMLMeasPOMId=@AMLMeasPOMId
and POM_Row=@POMRow and Sizecol = @Evalsizecol and AMLMeasIGCId=@AMLMeasIGCId

select @SampleGrade=Grade from pAMLMeasIGC where AMLMeasHdrId = @AMLMeasHdrId and AMLMeasPOMId=@AMLMeasPOMId
and POM_Row=@POMRow and Sizecol = @SampleSizecol

select @Tolplus = Tolplus, @TolMinus=TolMinus from pmsevalpom where SamplePomId = @SamplePomId
and AMLMeasPOMId=@AMLMeasPOMId  and SampleRequestHeaderId = @SampleRequestHeaderId

set @GradeDiff = @EvalGrade - @SampleGrade

set @sampleRevisedValue = @RevisedSpec - @GradeDiff

if @RevisedSpec<>0
	begin
		if @SampleSizeId=@EvalSizeId	
			begin
				set @blnIssample = 1
				if @EvalGrade=@RevisedSpec
					begin
						set @IsNotEvalSameAsSampleSize=0
					end
				else
					begin
						set @IsNotEvalSameAsSampleSize=1
					end
			end
		else
			begin
				set @blnIssample = 0
				if @EvalGrade=@RevisedSpec
					begin
						set @IsNotEvalSameAsSampleSize=0
					end
				else
					begin
						set @IsNotEvalSameAsSampleSize=1
					end
			end	
	end

if @EvalMeasValue <> 0
	begin
		if @VdrMeasValue = 0 
			begin
				set @VdrDelta = 0	
				set @VdrOutTol = 0
			end
		else
			begin
				set @VdrDelta = @EvalMeasValue - @VdrMeasValue	
				if @VdrDelta >= @TolMinus and @VdrDelta < @Tolplus
					begin
						set @VdrOutTol = 0
					end
				else
					begin
						set @VdrOutTol = 1
					end
			end
			
			if @sampMeasValue = 0 
				begin
					set @SampDelta = 0	
					set @SampOutTol = 0
				end
			else
				begin
					set @SampDelta = @EvalMeasValue - @sampMeasValue	
					if @SampDelta >= @TolMinus and @SampDelta < @Tolplus
						begin
							set @SampOutTol = 0
						end
					else
						begin
							set @SampOutTol = 1
						end
				end
				
				update pMSEvalSampMeas set VdrDelta=@VdrDelta, SampDelta=@SampDelta,
				VdrOutTol=@VdrOutTol, SampOutTol=@SampOutTol  
				where SampleRequestHeaderId=@SampleRequestHeaderId and sampleIndex=@Submit and SampleMeasId=@SampleMeasId
		end


if @RevisedSpec <> 0 and @PostRev = 1
	begin
		if @blnIssample = 1 
			begin
				if @IsNotEvalSameAsSampleSize=1
					begin
						EXEC spx_SampleRequest_MeasReviseSample_UPDATE
						@AMLMeasHdrId,
						@AMLMeasPomId, 
						@POMRow,						
						@SampleSizeCol,
						@RevisedSpec
					end
			end
		else
			begin
				if @IsNotEvalSameAsSampleSize=1
					begin
						EXEC spx_SampleRequest_MeasReviseSample_UPDATE
						@AMLMeasHdrId,
						@AMLMeasPomId, 
						@POMRow,						
						@SampleSizeCol,
						@sampleRevisedValue
					end
			end
	end
Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '876', GetDate())
GO   