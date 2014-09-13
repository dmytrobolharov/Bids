/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMRelative_UPDATE]    Script Date: 07/02/2013 15:47:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMRelative_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMRelative_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMRelative_UPDATE]    Script Date: 07/02/2013 15:47:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasTemplate_IMRelative_UPDATE]
(@SampleRequestAMLMeasHdrId uniqueidentifier,
 @sTemplatecol int,
 @MaxPomRow int
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
DECLARE @queryUpdSample NVARCHAR(4000)
Declare @sizecol int
Declare @Metric nvarchar(2)

CREATE TABLE #tempMeasData (
 SampleRequestamlmeashdrid uniqueidentifier,
 SampleRequestamlmeaspomid uniqueidentifier,
 pom_row int,
 wsrowid int,
 sizecol int,
 SampleRequestamlmeasigcid uniqueidentifier,
 Incr decimal(18,4) 
)

select @sizecol=@sTemplatecol

select @Metric=Ismetric from pSampleRequestamlmeashdr where SampleRequestamlmeashdrid = @SampleRequestAMLMeasHdrId

if @Metric='0'
	begin
		SET @query = N'select a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row, a.wsrowid, a.sizecol, a.SampleRequestamlmeasigcid, a.Incr from pSampleRequestamlmeasigc a,
		pSampleRequestamlmeaspom b where a.SampleRequestamlmeashdrid=b.SampleRequestamlmeashdrid and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid and a.pom_row=b.pom_row and
		a.wsrowid=b.wsrowid and a.SampleRequestamlmeashdrid=''' + cast(@SampleRequestamlmeasHdrID as nvarchar(50)) + ''' and a.sizecol='+ cast(@sizecol as nvarchar(5))  + ' 
		and a.pom_row=' + cast(@MaxPomRow as nvarchar(50)) + ' order by a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol; '

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade = (#tempMeasData.Incr + pSampleRequestamlmeasigc.incr), pSampleRequestamlmeasigc.ConvGrade=((#tempMeasData.Incr + pSampleRequestamlmeasigc.incr)*2.54) FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeaspomid=#tempMeasData.SampleRequestamlmeaspomid AND 
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=#tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@SampleRequestamlmeasHdrId as nvarchar(50)) + '''
		and pSampleRequestamlmeasigc.pom_row=' + cast(@MaxPomRow as nvarchar(50)) + '
		and pSampleRequestamlmeasigc.sizecol<>' + cast(@Sizecol as nvarchar(50)) + ' ; '
		              
		EXEC (@queryUpd)

		set @queryUpdSample = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade = #tempMeasData.Incr, pSampleRequestamlmeasigc.ConvGrade=(#tempMeasData.Incr *2.54) FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeaspomid=#tempMeasData.SampleRequestamlmeaspomid AND pSampleRequestamlmeasigc.SampleRequestamlmeasigcid=#tempMeasData.SampleRequestamlmeasigcid and pSampleRequestamlmeasigc.sizecol=#tempMeasData.sizecol and
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=#tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@SampleRequestamlmeasHdrId as nvarchar(50)) + '''
		and pSampleRequestamlmeasigc.pom_row=' +  cast(@MaxPomRow as nvarchar(50)) + '
		and pSampleRequestamlmeasigc.sizecol=' + cast(@Sizecol as nvarchar(50))  + ' ; '

		EXEC (@queryUpdSample)
	end
else
	begin
		SET @query = N'select a.SampleRequestamlmeashdrid, a.SampleRequestamlmeaspomid, a.pom_row, a.wsrowid, a.sizecol, a.SampleRequestamlmeasigcid, a.Incr from pSampleRequestamlmeasigc a,
		pSampleRequestamlmeaspom b where a.SampleRequestamlmeashdrid=b.SampleRequestamlmeashdrid and a.SampleRequestamlmeaspomid=b.SampleRequestamlmeaspomid and a.pom_row=b.pom_row and
		a.wsrowid=b.wsrowid and a.SampleRequestamlmeashdrid=''' + cast(@SampleRequestamlmeasHdrID as nvarchar(50)) + ''' and a.sizecol=' + cast(@Sizecol as nvarchar(50))   + '
		and a.pom_row=' + cast(@MaxPomRow as nvarchar(50)) + ' order by a.SampleRequestamlmeaspomid, a.pom_row, a.sizecol; '

		INSERT  #tempMeasData EXEC (@query)

		--select * from #tempMeasData

		set @queryUpd = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade = (#tempMeasData.Incr + pSampleRequestamlmeasigc.incr), pSampleRequestamlmeasigc.ConvGrade=((#tempMeasData.Incr + pSampleRequestamlmeasigc.incr)/(2.54)) FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeaspomid=#tempMeasData.SampleRequestamlmeaspomid AND 
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=#tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@SampleRequestamlmeasHdrId as nvarchar(50)) + '''
		and pSampleRequestamlmeasigc.pom_row=' + cast(@MaxPomRow as nvarchar(50)) + '
		and pSampleRequestamlmeasigc.sizecol<>' + cast(@Sizecol as nvarchar(50)) + ' ; '
		              
		EXEC (@queryUpd)

		set @queryUpdSample = N'Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Grade = #tempMeasData.Incr, pSampleRequestamlmeasigc.ConvGrade=(#tempMeasData.Incr /(2.54)) FROM  pSampleRequestamlmeasigc  INNER JOIN
		#tempMeasData ON pSampleRequestamlmeasigc.SampleRequestamlmeaspomid=#tempMeasData.SampleRequestamlmeaspomid AND pSampleRequestamlmeasigc.SampleRequestamlmeasigcid=#tempMeasData.SampleRequestamlmeasigcid and pSampleRequestamlmeasigc.sizecol=#tempMeasData.sizecol and
		pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=#tempMeasData.SampleRequestamlmeashdrid and pSampleRequestamlmeasigc.pom_row=#tempMeasData.pom_row and pSampleRequestamlmeasigc.wsrowid=#tempMeasData.wsrowid  where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=''' + cast(@SampleRequestamlmeasHdrId as nvarchar(50)) + '''
		and pSampleRequestamlmeasigc.pom_row=' + cast(@MaxPomRow as nvarchar(50)) + '
		and pSampleRequestamlmeasigc.sizecol=' + cast(@Sizecol as nvarchar(50))  + ' ; '

		EXEC (@queryUpdSample)
	end


--select * from pSampleRequestamlmeasigc order by pom_row, sizecol



DROP TABLE #tempMeasData

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05983', GetDate())
GO
