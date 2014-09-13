set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasPOMIMIncrement_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasPOMIMIncrement_UPDATE
GO



create PROCEDURE [dbo].[spx_StyleMeasPOMIMIncrement_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@AMLMeasPOMId uniqueidentifier,
@POMRow int
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
Declare @Metric nvarchar(2)

CREATE TABLE #tempMeasData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 pom_row int,
 sizecol int,
 amlmeasigcid uniqueidentifier,
 Grade decimal(18,4),
 ConvGrade decimal(18,4)
)

select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.amlmeaspomid=''' + 
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row =''' + cast(@POMRow as nvarchar(5)) + '''
		and a.sizecol <= b.sizecol and b.sizecol<=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid) 
		and a.amlmeaspomid=b.amlmeaspomid
		group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		union
		select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.amlmeaspomid=''' + 
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row = ''' + cast(@POMRow as nvarchar(5)) + '''
		and a.sizecol >= b.sizecol and b.sizecol>=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid)  and a.amlmeaspomid=b.amlmeaspomid
		group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
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
		and a.sizecol <= b.sizecol and b.sizecol<=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid) 
		and a.amlmeaspomid=b.amlmeaspomid
		group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		union
		select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr/(2.54)) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.amlmeaspomid=''' + 
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row = ''' + cast(@POMRow as nvarchar(5)) + '''
		and a.sizecol >= b.sizecol and b.sizecol>=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid)  and a.amlmeaspomid=b.amlmeaspomid
		group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
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


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '512', GetDate())
GO


