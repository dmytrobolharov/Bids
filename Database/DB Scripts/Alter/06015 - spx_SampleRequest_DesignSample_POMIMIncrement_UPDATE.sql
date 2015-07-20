/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_POMIMIncrement_UPDATE]    Script Date: 07/10/2013 12:07:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_POMIMIncrement_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_POMIMIncrement_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_POMIMIncrement_UPDATE]    Script Date: 07/10/2013 12:07:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_POMIMIncrement_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@AMLMeasPOMId uniqueidentifier,
@POMRow int
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
Declare @Metric nvarchar(2)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#tempMeasData') AND type in (N'U'))
DROP TABLE #tempMeasData

CREATE TABLE #tempMeasData (
 SampleRequestamlmeashdrid uniqueidentifier,
 SampleRequestamlmeaspomid uniqueidentifier,
 pom_row int,
 sizecol int,
 SampleRequestamlmeasigcid uniqueidentifier,
 Grade decimal(18,4),
 ConvGrade decimal(18,4)
)

select @Metric=Ismetric from pSampleRequestamlmeashdr where SampleRequestamlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		SET @query = N'select a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.SampleRequestamlmeaspomid=''' + 
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row =''' + cast(@POMRow as nvarchar(5)) + '''
		and a.sizecol <= b.sizecol and b.sizecol<=(select sizecol from pSampleRequestamlmeaslbl c where issample=1 and a.SampleRequestamlmeashdrid=c.SampleRequestamlmeashdrid) 
		and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid and a.pom_row=b.pom_row
		group by a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		union
		select a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.SampleRequestamlmeaspomid=''' + 
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row = ''' + cast(@POMRow as nvarchar(5)) + '''
		and a.sizecol >= b.sizecol and b.sizecol>=(select sizecol from pSampleRequestamlmeaslbl c where issample=1 and a.SampleRequestamlmeashdrid=c.SampleRequestamlmeashdrid)  and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid
		and a.pom_row=b.pom_row group by a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade=#tempMeasData.Grade, pSampleRequestamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeasigcid = #tempMeasData.SampleRequestamlmeasigcid AND pSampleRequestamlmeasigc.SampleRequestamlmeaspomid = #tempMeasData.SampleRequestamlmeaspomid AND 
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid = #tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.sizecol=#tempMeasData.sizecol 
		where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' and pSampleRequestamlmeasigc.SampleRequestamlmeaspomid=''' +
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and pSampleRequestamlmeasigc.pom_row = ''' + cast(@POMRow as nvarchar(5)) + ''';'
		              
		EXEC (@queryUpd)
	end
else
	begin
		SET @query = N'select a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr/(2.54)) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.SampleRequestamlmeaspomid=''' + 
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row =''' + cast(@POMRow as nvarchar(5)) + '''
		and a.sizecol <= b.sizecol and b.sizecol<=(select sizecol from pSampleRequestamlmeaslbl c where issample=1 and a.SampleRequestamlmeashdrid=c.SampleRequestamlmeashdrid) 
		and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid and a.pom_row=b.pom_row
		group by a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		union
		select a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr/(2.54)) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' and a.SampleRequestamlmeaspomid=''' + 
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and a.pom_row = ''' + cast(@POMRow as nvarchar(5)) + '''
		and a.sizecol >= b.sizecol and b.sizecol>=(select sizecol from pSampleRequestamlmeaslbl c where issample=1 and a.SampleRequestamlmeashdrid=c.SampleRequestamlmeashdrid)  and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid
		and a.pom_row=b.pom_row group by a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade=#tempMeasData.Grade, pSampleRequestamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeasigcid = #tempMeasData.SampleRequestamlmeasigcid AND pSampleRequestamlmeasigc.SampleRequestamlmeaspomid = #tempMeasData.SampleRequestamlmeaspomid AND 
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid = #tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.sizecol=#tempMeasData.sizecol 
		where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''' and pSampleRequestamlmeasigc.SampleRequestamlmeaspomid=''' +
		cast(@AMLMeasPOMId as nvarchar(50)) + ''' and pSampleRequestamlmeasigc.pom_row = ''' + cast(@POMRow as nvarchar(5)) + ''';'
		              
		EXEC (@queryUpd)
	end
--select * from pamlmeasigc order by pom_row, sizecol

DROP TABLE #tempMeasData



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06015', GetDate())
GO
