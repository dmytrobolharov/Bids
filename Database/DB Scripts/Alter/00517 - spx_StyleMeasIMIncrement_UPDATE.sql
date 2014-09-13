set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasIMIncrement_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasIMIncrement_UPDATE
GO


create PROCEDURE [dbo].[spx_StyleMeasIMIncrement_UPDATE]
(@AMLMeasHdrId uniqueidentifier
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
Declare @Metric as nvarchar(2)

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

select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if @Metric='0' 
	begin

		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol <= b.sizecol and b.sizecol<=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid) and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		union
		select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol >= b.sizecol and b.sizecol>=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid)  and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData
		
		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade=#tempMeasData.Grade, pamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeasigcid = #tempMeasData.amlmeasigcid AND pamlmeasigc.amlmeaspomid = #tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid = #tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.sizecol=#tempMeasData.sizecol where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' ;'
		              
		EXEC (@queryUpd)

		

	--select * from pamlmeasigc order by pom_row, sizecol
	end
else
	begin

		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum((b.Incr/(2.54))) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol <= b.sizecol and b.sizecol<=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid) and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		union
		select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum((b.Incr/(2.54))) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol >= b.sizecol and b.sizecol>=(select sizecol from pamlmeaslbl c where issample=1 and a.amlmeashdrid=c.amlmeashdrid)  and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade=#tempMeasData.Grade, pamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeasigcid = #tempMeasData.amlmeasigcid AND pamlmeasigc.amlmeaspomid = #tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid = #tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.sizecol=#tempMeasData.sizecol where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' ;'
		              
		EXEC (@queryUpd)
	end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#tempMeasData') AND type in (N'U'))
DROP TABLE #tempMeasData


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '517', GetDate())
GO



