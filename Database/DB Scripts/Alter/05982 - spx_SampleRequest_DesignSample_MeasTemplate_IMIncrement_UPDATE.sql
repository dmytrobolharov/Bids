/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMIncrement_UPDATE]    Script Date: 07/02/2013 15:47:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMIncrement_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMIncrement_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMIncrement_UPDATE]    Script Date: 07/02/2013 15:47:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMIncrement_UPDATE]
(@SampleRequestAMLMeasHdrId uniqueidentifier,
@sTemplatecol int,
@MaxPomRow int
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
Declare @Metric as nvarchar(2)
Declare @sizecol int

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

select @Metric=Ismetric from pSampleRequestamlmeashdr where SampleRequestamlmeashdrid = @SampleRequestAMLMeasHdrId

select @sizecol=@sTemplatecol

if @Metric='0' 
	begin

		SET @query = N'select a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol <= b.sizecol and 
		b.sizecol<=' + cast(@sizecol as nvarchar(5))   + ' 
		and a.pom_row=' + cast(@MaxPomRow as nvarchar(50)) + ' and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid
		and a.pom_row=b.pom_row group by a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		union
		select a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum(b.Incr*2.54) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol >= b.sizecol and 
		b.sizecol>='  + cast(@sizecol as nvarchar(5))  +   ' 
		and a.pom_row=' + cast(@MaxPomRow as nvarchar(50))  + ' and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid
		and a.pom_row=b.pom_row group by a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData
		
		set @queryUpd = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade=#tempMeasData.Grade, pSampleRequestamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeasigcid = #tempMeasData.SampleRequestamlmeasigcid AND pSampleRequestamlmeasigc.SampleRequestamlmeaspomid = #tempMeasData.SampleRequestamlmeaspomid AND 
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid = #tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.sizecol=#tempMeasData.sizecol where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAMLMeasHdrId as nvarchar(50)) + ''' 
		and pSampleRequestamlmeasigc.pom_row=' + cast(@MaxPomRow as nvarchar(50))  + ';'
		              
		EXEC (@queryUpd)

		

	--select * from pamlmeasigc order by pom_row, sizecol
	end
else
	begin

		SET @query = N'select a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum((b.Incr/(2.54))) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol <= b.sizecol 
		and b.sizecol<=' + cast(@sizecol as nvarchar(5))   + ' 
		and a.pom_row=' + cast(@MaxPomRow as nvarchar(50))  + ' and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid
		and a.pom_row=b.pom_row group by a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		union
		select a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol, a.SampleRequestamlmeasigcid, sum(b.Incr) as Grade, sum((b.Incr/(2.54))) as ConvGrade
		from pSampleRequestamlmeasigc a cross join pSampleRequestamlmeasigc b
		where a.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAmlMeasHdrID as nvarchar(50)) + ''' and a.sizecol >= b.sizecol 
		and b.sizecol>=' + cast(@sizecol as nvarchar(5))   + ' 
		and a.pom_row=' + cast(@MaxPomRow as nvarchar(50))  + ' and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid
		and a.pom_row=b.pom_row group by a.SampleRequestamlmeashdrid,a.SampleRequestamlmeaspomid, a.pom_row , a.sizecol, a.SampleRequestamlmeasigcid
		order by pom_row, sizecol ;'

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade=#tempMeasData.Grade, pSampleRequestamlmeasigc.ConvGrade=#tempMeasData.ConvGrade FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeasigcid = #tempMeasData.SampleRequestamlmeasigcid AND pSampleRequestamlmeasigc.SampleRequestamlmeaspomid = #tempMeasData.SampleRequestamlmeaspomid AND 
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid = #tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.sizecol=#tempMeasData.sizecol where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAMLMeasHdrId as nvarchar(50)) + ''' 
		and pSampleRequestamlmeasigc.pom_row=' + cast(@MaxPomRow as nvarchar(50))  + ';'
		              
		EXEC (@queryUpd)
	end


DROP TABLE #tempMeasData

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05982', GetDate())
GO
