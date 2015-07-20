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

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '882', GetDate())
GO