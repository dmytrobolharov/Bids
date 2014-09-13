set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasChangeIGC_Insert') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasChangeIGC_Insert
GO

Create  PROCEDURE [dbo].[spx_StyleMeasChangeIGC_Insert]
(
	@AMLMeasHdrId nvarchar(50),
	@samplesizecol int,
	@prevsamplesizecol int,
	@IsNegative int,
	@MaxPOMRow int
)

AS

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#tempSampleIGCData') AND type in (N'U'))
DROP TABLE #tempSampleIGCData

CREATE TABLE #tempSampleIGCData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 amlmeasigcid uniqueidentifier,
 pom_row int,
 sizecol int, 
 Incr decimal(18,4)
 )

--select @maxsizecol = max(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @minsizecol =min(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @samplesizecol = sizecol from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId and issample=-1


Begin

if @samplesizecol < @prevsamplesizecol
	begin
        If @IsNegative=1
			begin
				Insert into #tempSampleIGCData
				SELECT x.amlmeashdrid, x.amlmeaspomid, x.amlmeasigcid, x.pom_row,  x.sizecol as sizecol,
				cast((case left(y.Incr,1) when '-' then substring(convert(nvarchar(20),y.incr), 2,(len(y.incr)-1))  else y.incr end) as decimal(18,4)) as Incr
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and x.amlmeashdrid =  @AMLMeasHdrId and x.pom_row > @MaxPOMRow
				and x.sizecol >= @samplesizecol and x.sizecol <= @prevsamplesizecol  order by x.pom_row, x.sizecol		
			end
		else
			begin
				Insert into #tempSampleIGCData
				SELECT x.amlmeashdrid, x.amlmeaspomid, x.amlmeasigcid, x.pom_row,  x.sizecol as sizecol, y.incr as Incr				
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and x.amlmeashdrid =  @AMLMeasHdrId and x.pom_row > @MaxPOMRow
				and x.sizecol >= @samplesizecol and x.sizecol <= @prevsamplesizecol order by x.pom_row, x.sizecol		
			end
	end
else
	begin
		If @IsNegative=1
			begin
				Insert into #tempSampleIGCData
				SELECT y.amlmeashdrid, y.amlmeaspomid, y.amlmeasigcid, y.pom_row, y.sizecol as Sizecol,
				cast((case left(x.Incr,1) when '-' then x.incr else '-' + convert(nvarchar(25),x.Incr) end) as decimal(18,4)) as Incr	
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and y.amlmeashdrid =  @AMLMeasHdrId and y.pom_row > @MaxPOMRow
				and x.sizecol > @prevsamplesizecol and x.sizecol <= @samplesizecol
				order by x.pom_row, x.sizecol
			end
		else
			begin
				Insert into #tempSampleIGCData
				SELECT y.amlmeashdrid, y.amlmeaspomid, y.amlmeasigcid, y.pom_row, y.sizecol as Sizecol,x.Incr as Incr					
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and y.amlmeashdrid =  @AMLMeasHdrId and y.pom_row > @MaxPOMRow
				and x.sizecol > @prevsamplesizecol and x.sizecol <= @samplesizecol
				order by x.pom_row, x.sizecol
			end
	end

--sample column
Insert into #tempSampleIGCData		
SELECT amlmeashdrid, amlmeaspomid, amlmeasigcid, pom_row, sizecol, convert(decimal(18,4),0) as Incr	
		from pamlmeasigc 		
		where amlmeashdrid = @AMLMeasHdrId and sizecol = @samplesizecol and pom_row > @MaxPOMRow
		order by pom_row, sizecol					


Update pamlmeasigc  set pamlmeasigc.Incr=#tempSampleIGCData.Incr
FROM  pamlmeasigc  INNER JOIN #tempSampleIGCData ON pamlmeasigc.amlmeasigcid = #tempSampleIGCData.amlmeasigcid AND 
pamlmeasigc.amlmeaspomid = #tempSampleIGCData.amlmeaspomid AND 
pamlmeasigc.amlmeashdrid = #tempSampleIGCData.amlmeashdrid and 
pamlmeasigc.pom_row=#tempSampleIGCData.pom_row and pamlmeasigc.sizecol=#tempSampleIGCData.sizecol 
where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId

--select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId order by pom_row, sizecol
--select * from pamlmeaslbl where issample=-1 and amlmeashdrid=@AMLMeasHdrId order by sizecol
DROP TABLE #tempSampleIGCData
end

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '523', GetDate())
GO
