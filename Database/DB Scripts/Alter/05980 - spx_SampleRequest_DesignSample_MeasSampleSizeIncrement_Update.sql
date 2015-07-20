/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeIncrement_Update]    Script Date: 07/02/2013 15:47:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeIncrement_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeIncrement_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeIncrement_Update]    Script Date: 07/02/2013 15:47:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE    PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasSampleSizeIncrement_Update]
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
 sizecol int, 
 IncrDiff decimal(18,4)
 )

--select @maxsizecol = max(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @minsizecol =min(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @samplesizecol = sizecol from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId and issample=-1


Begin
--refer only Y sizecol also if sample is max col only this query returns rows
---for sizecol is less than and equal to sample  - sample is <= for example if sample is 2 then sizecols to look in Y is 0,1
 
Insert into #tempSampleData
SELECT Y.SampleRequestamlmeashdrid, Y.SampleRequestamlmeaspomid, Y.SampleRequestamlmeasigcid, Y.pom_row, Y.sizecol,
		Y.grade - COALESCE(X.Grade, 0) as IncrDiff
		FROM pSampleRequestamlmeasigc AS X
		left JOIN pSampleRequestamlmeasigc AS Y
		ON X.sizecol = Y.sizecol + 1 where x.pom_row=y.pom_row and x.SampleRequestamlmeaspomid=y.SampleRequestamlmeaspomid and x.SampleRequestamlmeashdrid=y.SampleRequestamlmeashdrid
		and x.SampleRequestamlmeashdrid = @SampleRequestAMLMeasHdrId and x.sizecol <= @samplesizecol
		order by Y.pom_row, Y.sizecol

--refer only X size col - also if sample is 0 or min col only this query returns rows
--for sizecol is greater than sample  if sample is >= for example if sample is 2 then sizecols to look in x is 3,4 
Insert into #tempSampleData
SELECT X.SampleRequestamlmeashdrid, X.SampleRequestamlmeaspomid, X.SampleRequestamlmeasigcid, X.pom_row, X.sizecol,
		X.grade - COALESCE(Y.Grade, 0) as IncrDiff
		FROM pSampleRequestamlmeasigc AS X
		left JOIN pSampleRequestamlmeasigc AS Y
		ON X.sizecol = Y.sizecol + 1 where x.pom_row=y.pom_row and x.SampleRequestamlmeaspomid=y.SampleRequestamlmeaspomid and x.SampleRequestamlmeashdrid=y.SampleRequestamlmeashdrid
		and x.SampleRequestamlmeashdrid = @SampleRequestAMLMeasHdrId and x.sizecol > @samplesizecol
		order by x.pom_row, x.sizecol
	
--sample column
Insert into #tempSampleData		
SELECT X.SampleRequestamlmeashdrid, X.SampleRequestamlmeaspomid, X.SampleRequestamlmeasigcid, X.pom_row, X.sizecol, grade as IncrDiff	
		from pSampleRequestamlmeasigc AS X		
		where x.SampleRequestamlmeashdrid = @SampleRequestAMLMeasHdrId and x.sizecol = @samplesizecol
		order by x.pom_row, x.sizecol					
end

--select * from #tempSampleData order by pom_row, sizecol
--Update pamlmeaslbl set issample=0 where issample=-1 and amlmeashdrid=@AMLMeasHdrId
--Update pamlmeaslbl set issample=-1 where sizecol= @samplesizecol and amlmeashdrid=@AMLMeasHdrId

Update pSampleRequestamlmeasigc  set pSampleRequestamlmeasigc.Incr=#tempSampleData.IncrDiff 
FROM  pSampleRequestamlmeasigc  INNER JOIN #tempSampleData ON pSampleRequestamlmeasigc.SampleRequestamlmeasigcid = #tempSampleData.SampleRequestamlmeasigcid AND 
pSampleRequestamlmeasigc.SampleRequestamlmeaspomid = #tempSampleData.SampleRequestamlmeaspomid AND 
pSampleRequestamlmeasigc.SampleRequestamlmeashdrid = #tempSampleData.SampleRequestamlmeashdrid and 
pSampleRequestamlmeasigc.pom_row=#tempSampleData.pom_row and pSampleRequestamlmeasigc.sizecol=#tempSampleData.sizecol 
where pSampleRequestamlmeasigc.SampleRequestamlmeashdrid=@SampleRequestAMLMeasHdrId

--select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId order by pom_row, sizecol
--select * from pamlmeaslbl where issample=-1 and amlmeashdrid=@AMLMeasHdrId order by sizecol
DROP TABLE #tempSampleData



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05980', GetDate())
GO