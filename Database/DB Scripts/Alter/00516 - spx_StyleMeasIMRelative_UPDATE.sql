set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasIMRelative_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasIMRelative_UPDATE
GO

Create PROCEDURE [dbo].[spx_StyleMeasIMRelative_UPDATE]
(@AMLMeasHdrId uniqueidentifier
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
DECLARE @queryUpdSample NVARCHAR(4000)
Declare @sizecol int
Declare @Metric nvarchar(2)

CREATE TABLE #tempMeasData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 pom_row int,
 wsrowid int,
 sizecol int,
 amlmeasigcid uniqueidentifier,
 Incr decimal(18,4) 
)

select @sizecol=sizecol from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId and issample=1

select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.wsrowid, a.sizecol, a.amlmeasigcid, a.Incr from pamlmeasigc a,
		pamlmeaspom b where a.amlmeashdrid=b.amlmeashdrid and a.amlmeaspomid=b.amlmeaspomid and a.pom_row=b.pom_row and
		a.wsrowid=b.wsrowid and a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol=' + cast(@sizecol as nvarchar(5))  + ' order by a.amlmeaspomid, a.pom_row, a.sizecol; '

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade = (#tempMeasData.Incr + pamlmeasigc.incr), pamlmeasigc.ConvGrade=((#tempMeasData.Incr + pamlmeasigc.incr)*2.54) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.sizecol<>' + cast(@Sizecol as nvarchar(5)) + ' ; '
		              
		EXEC (@queryUpd)

		set @queryUpdSample = N'Update pamlmeasigc  set pamlmeasigc.Grade = #tempMeasData.Incr, pamlmeasigc.ConvGrade=(#tempMeasData.Incr *2.54) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND pamlmeasigc.amlmeasigcid=#tempMeasData.amlmeasigcid and pamlmeasigc.sizecol=#tempMeasData.sizecol and
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.sizecol=' + cast(@Sizecol as nvarchar(5)) + ' ; '

		EXEC (@queryUpdSample)
	end
else
	begin
		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.wsrowid, a.sizecol, a.amlmeasigcid, a.Incr from pamlmeasigc a,
		pamlmeaspom b where a.amlmeashdrid=b.amlmeashdrid and a.amlmeaspomid=b.amlmeaspomid and a.pom_row=b.pom_row and
		a.wsrowid=b.wsrowid and a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol=' + cast(@sizecol as nvarchar(5))  + ' order by a.amlmeaspomid, a.pom_row, a.sizecol; '

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade = (#tempMeasData.Incr + pamlmeasigc.incr), pamlmeasigc.ConvGrade=((#tempMeasData.Incr + pamlmeasigc.incr)/(2.54)) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.sizecol<>' + cast(@Sizecol as nvarchar(5)) + ' ; '
		              
		EXEC (@queryUpd)

		set @queryUpdSample = N'Update pamlmeasigc  set pamlmeasigc.Grade = #tempMeasData.Incr, pamlmeasigc.ConvGrade=(#tempMeasData.Incr /(2.54)) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND pamlmeasigc.amlmeasigcid=#tempMeasData.amlmeasigcid and pamlmeasigc.sizecol=#tempMeasData.sizecol and
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.sizecol=' + cast(@Sizecol as nvarchar(5)) + ' ; '

		EXEC (@queryUpdSample)
	end


--select * from pamlmeasigc order by pom_row, sizecol



DROP TABLE #tempMeasData



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '516', GetDate())
GO



