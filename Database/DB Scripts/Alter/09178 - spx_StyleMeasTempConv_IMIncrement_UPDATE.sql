IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasTempConv_IMIncrement_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasTempConv_IMIncrement_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[spx_StyleMeasTempConv_IMIncrement_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@sTemplatecol int,
@MaxPomRow NVARCHAR(2000)
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
Declare @Metric as nvarchar(2)
Declare @sizecol int

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

select @sizecol=@sTemplatecol

if @Metric='0' 
	begin

		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol <= b.sizecol and 
		b.sizecol<=' + cast(@sizecol as nvarchar(5))   + ' 
		and a.pom_row In (' + cast(@MaxPomRow as nvarchar(4000)) + ') and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		union
		select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol >= b.sizecol and 
		b.sizecol>='  + cast(@sizecol as nvarchar(5))  +   ' 
		and a.pom_row In (' + cast(@MaxPomRow as nvarchar(4000))  + ') and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData
		
		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade=#tempMeasData.Grade, pamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeasigcid = #tempMeasData.amlmeasigcid AND pamlmeasigc.amlmeaspomid = #tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid = #tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.sizecol=#tempMeasData.sizecol where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' 
		and pamlmeasigc.pom_row In (' + cast(@MaxPomRow as nvarchar(4000))  + ');'
		              
		EXEC (@queryUpd)

		

	--select * from pamlmeasigc order by pom_row, sizecol
	end
else
	begin

		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum((b.Incr/(2.54))) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol <= b.sizecol 
		and b.sizecol<=' + cast(@sizecol as nvarchar(5))   + ' 
		and a.pom_row In (' + cast(@MaxPomRow as nvarchar(4000))  + ') and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid, a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		union
		select a.amlmeashdrid,a.amlmeaspomid, a.pom_row, a.sizecol, a.amlmeasigcid, sum(b.Incr) as Grade, sum((b.Incr/(2.54))) as ConvGrade
		from pamlmeasigc a cross join pamlmeasigc b
		where a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol >= b.sizecol 
		and b.sizecol>=' + cast(@sizecol as nvarchar(5))   + ' 
		and a.pom_row In (' + cast(@MaxPomRow as nvarchar(4000))  + ') and a.amlmeaspomid=b.amlmeaspomid
		and a.pom_row=b.pom_row group by a.amlmeashdrid,a.amlmeaspomid, a.pom_row , a.sizecol, a.amlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade=#tempMeasData.Grade, pamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeasigcid = #tempMeasData.amlmeasigcid AND pamlmeasigc.amlmeaspomid = #tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid = #tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.sizecol=#tempMeasData.sizecol where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' 
		and pamlmeasigc.pom_row In (' + cast(@MaxPomRow as nvarchar(4000))  + ');'
		              
		EXEC (@queryUpd)
	end


DROP TABLE #tempMeasData

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09178', GetDate())
GO


