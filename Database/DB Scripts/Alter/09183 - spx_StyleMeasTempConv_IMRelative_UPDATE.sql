IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasTempConv_IMRelative_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasTempConv_IMRelative_UPDATE]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[spx_StyleMeasTempConv_IMRelative_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
 @sTemplatecol int,
 @MaxPomRow NVARCHAR(2000)
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

select @sizecol=@sTemplatecol

select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.wsrowid, a.sizecol, a.amlmeasigcid, a.Incr from pamlmeasigc a,
		pamlmeaspom b where a.amlmeashdrid=b.amlmeashdrid and a.amlmeaspomid=b.amlmeaspomid and a.pom_row=b.pom_row and
		a.wsrowid=b.wsrowid and a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol='+ cast(@sizecol as nvarchar(5))  + ' 
		and a.pom_row In (' + cast(@MaxPomRow as nvarchar(4000)) + ') order by a.amlmeaspomid, a.pom_row, a.sizecol; '

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade = (#tempMeasData.Incr + pamlmeasigc.incr), pamlmeasigc.ConvGrade=((#tempMeasData.Incr + pamlmeasigc.incr)*2.54) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.pom_row In (' + cast(@MaxPomRow as nvarchar(4000)) + ')
		and pamlmeasigc.sizecol<>' + cast(@Sizecol as nvarchar(50)) + ' ; '
		              
		EXEC (@queryUpd)

		set @queryUpdSample = N'Update pamlmeasigc  set pamlmeasigc.Grade = #tempMeasData.Incr, pamlmeasigc.ConvGrade=(#tempMeasData.Incr *2.54) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND pamlmeasigc.amlmeasigcid=#tempMeasData.amlmeasigcid and pamlmeasigc.sizecol=#tempMeasData.sizecol and
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.pom_row In (' +  cast(@MaxPomRow as nvarchar(4000)) + ')
		and pamlmeasigc.sizecol=' + cast(@Sizecol as nvarchar(50))  + ' ; '

		EXEC (@queryUpdSample)
	end
else
	begin
		SET @query = N'select a.amlmeashdrid, a.amlmeaspomid, a.pom_row, a.wsrowid, a.sizecol, a.amlmeasigcid, a.Incr from pamlmeasigc a,
		pamlmeaspom b where a.amlmeashdrid=b.amlmeashdrid and a.amlmeaspomid=b.amlmeaspomid and a.pom_row=b.pom_row and
		a.wsrowid=b.wsrowid and a.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol=' + cast(@Sizecol as nvarchar(50))   + '
		and a.pom_row In (' + cast(@MaxPomRow as nvarchar(4000)) + ') order by a.amlmeaspomid, a.pom_row, a.sizecol; '

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pamlmeasigc  set pamlmeasigc.Grade = (#tempMeasData.Incr + pamlmeasigc.incr), pamlmeasigc.ConvGrade=((#tempMeasData.Incr + pamlmeasigc.incr)/(2.54)) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND 
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.pom_row In (' + cast(@MaxPomRow as nvarchar(4000)) + ')
		and pamlmeasigc.sizecol<>' + cast(@Sizecol as nvarchar(50)) + ' ; '
		              
		EXEC (@queryUpd)

		set @queryUpdSample = N'Update pamlmeasigc  set pamlmeasigc.Grade = #tempMeasData.Incr, pamlmeasigc.ConvGrade=(#tempMeasData.Incr /(2.54)) FROM  pamlmeasigc  INNER JOIN
		#tempMeasData ON pamlmeasigc.amlmeaspomid=#tempMeasData.amlmeaspomid AND pamlmeasigc.amlmeasigcid=#tempMeasData.amlmeasigcid and pamlmeasigc.sizecol=#tempMeasData.sizecol and
		pamlmeasigc.amlmeashdrid=#tempMeasData.amlmeashdrid and pamlmeasigc.pom_row=#tempMeasData.pom_row and pamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pamlmeasigc.amlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + '''
		and pamlmeasigc.pom_row In (' + cast(@MaxPomRow as nvarchar(4000)) + ')
		and pamlmeasigc.sizecol=' + cast(@Sizecol as nvarchar(50))  + ' ; '

		EXEC (@queryUpdSample)
	end


--select * from pamlmeasigc order by pom_row, sizecol



DROP TABLE #tempMeasData

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09183', GetDate())
GO


