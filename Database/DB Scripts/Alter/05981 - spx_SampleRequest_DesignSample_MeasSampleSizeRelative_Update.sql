/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeRelative_Update]    Script Date: 07/02/2013 15:47:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeRelative_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeRelative_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeRelative_Update]    Script Date: 07/02/2013 15:47:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






Create PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeRelative_Update]
(
	@SampleRequestAMLMeasHdrId nvarchar(50),
	@samplesizecol int
)

AS

--DECLARE @maxsizecol int
--DECLARE @minsizecol int
--DECLARE @samplesizecol int

CREATE TABLE #tempSampleData (
 SampleRequestamlmeashdrid uniqueidentifier,
 SampleRequestamlmeaspomid uniqueidentifier,
 SampleRequestamlmeasigcid uniqueidentifier,
 pom_row int,
 wsrowid int,
 sizecol int, 
 IncrDiff decimal(18,4)
 )

--select @maxsizecol = max(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @minsizecol =min(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @samplesizecol = sizecol from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId and issample=-1

Insert into #tempSampleData
SELECT Y.SampleRequestamlmeashdrid, Y.SampleRequestamlmeaspomid, Y.SampleRequestamlmeasigcid, Y.pom_row, Y.wsrowid, Y.sizecol, 
		Y.grade - COALESCE(X.Grade, 0) as IncrDiff
		FROM pSampleRequestamlmeasigc AS X, pSampleRequestamlmeasigc AS Y where 
		x.pom_row=y.pom_row and x.wsrowid=y.wsrowid
		and x.SampleRequestamlmeaspomid=y.SampleRequestamlmeaspomid and x.SampleRequestamlmeashdrid=y.SampleRequestamlmeashdrid
		and x.SampleRequestamlmeashdrid =@SampleRequestAMLMeasHdrId and x.sizecol = @samplesizecol   and Y.sizecol <> @samplesizecol 
		order by Y.pom_row, Y.sizecol desc


--select * from #tempSampleData order by pom_row, sizecol
--Update pamlmeaslbl set issample=0 where issample=-1 and amlmeashdrid=@AMLMeasHdrId
--Update pamlmeaslbl set issample=-1 where sizecol= @samplesizecol and amlmeashdrid=@AMLMeasHdrId

Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Incr=#tempSampleData.IncrDiff 
FROM  pSampleRequestamlmeasigc  INNER JOIN #tempSampleData ON pSampleRequestamlmeasigc.SampleRequestamlmeasigcid = #tempSampleData.SampleRequestamlmeasigcid AND 
pSampleRequestamlmeasigc.SampleRequestamlmeaspomid = #tempSampleData.SampleRequestamlmeaspomid AND 
pSampleRequestamlmeasigc.SampleRequestamlmeashdrid = #tempSampleData.SampleRequestamlmeashdrid and 
pSampleRequestamlmeasigc.wsrowid = #tempSampleData.wsrowid and 
pSampleRequestamlmeasigc.pom_row=#tempSampleData.pom_row and pSampleRequestamlmeasigc.sizecol=#tempSampleData.sizecol 
where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=@SampleRequestAMLMeasHdrId

Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Incr=pSampleRequestamlmeasigc.Grade 
FROM  pSampleRequestamlmeasigc  INNER JOIN pSampleRequestamlmeaspom ON  
pSampleRequestamlmeasigc.SampleRequestamlmeaspomid = pSampleRequestamlmeaspom.SampleRequestamlmeaspomid AND 
pSampleRequestamlmeasigc.SampleRequestamlmeashdrid = pSampleRequestamlmeaspom.SampleRequestamlmeashdrid and 
pSampleRequestamlmeasigc.wsrowid = pSampleRequestamlmeaspom.wsrowid and 
pSampleRequestamlmeasigc.pom_row=pSampleRequestamlmeaspom.pom_row  
where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=@SampleRequestAMLMeasHdrId and  pSampleRequestamlmeasigc.sizecol=@samplesizecol


--select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId order by pom_row, sizecol
--select * from pamlmeaslbl where issample=-1 and amlmeashdrid=@AMLMeasHdrId order by sizecol
DROP TABLE #tempSampleData



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05981', GetDate())
GO