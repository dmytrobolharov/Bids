set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasSampleSizeIncrement_Update') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasSampleSizeIncrement_Update
GO



create    PROCEDURE [dbo].[spx_StyleMeasSampleSizeIncrement_Update]
(
	@AMLMeasHdrId nvarchar(50),
	@samplesizecol int
)

AS

--DECLARE @maxsizecol int
--DECLARE @minsizecol int
--DECLARE @samplesizecol int

CREATE TABLE #tempSampleData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 amlmeasigcid uniqueidentifier,
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
SELECT Y.amlmeashdrid, Y.amlmeaspomid, Y.amlmeasigcid, Y.pom_row, Y.sizecol,
		Y.grade - COALESCE(X.Grade, 0) as IncrDiff
		FROM pamlmeasigc AS X
		left JOIN pamlmeasigc AS Y
		ON X.sizecol = Y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid and x.amlmeashdrid=y.amlmeashdrid
		and x.amlmeashdrid = @AMLMeasHdrId and x.sizecol <= @samplesizecol
		order by Y.pom_row, Y.sizecol

--refer only X size col - also if sample is 0 or min col only this query returns rows
--for sizecol is greater than sample  if sample is >= for example if sample is 2 then sizecols to look in x is 3,4 
Insert into #tempSampleData
SELECT X.amlmeashdrid, X.amlmeaspomid, X.amlmeasigcid, X.pom_row, X.sizecol,
		X.grade - COALESCE(Y.Grade, 0) as IncrDiff
		FROM pamlmeasigc AS X
		left JOIN pamlmeasigc AS Y
		ON X.sizecol = Y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid and x.amlmeashdrid=y.amlmeashdrid
		and x.amlmeashdrid = @AMLMeasHdrId and x.sizecol > @samplesizecol
		order by x.pom_row, x.sizecol
	
--sample column
Insert into #tempSampleData		
SELECT X.amlmeashdrid, X.amlmeaspomid, X.amlmeasigcid, X.pom_row, X.sizecol, grade as IncrDiff	
		from pamlmeasigc AS X		
		where x.amlmeashdrid = @AMLMeasHdrId and x.sizecol = @samplesizecol
		order by x.pom_row, x.sizecol					
end

--select * from #tempSampleData order by pom_row, sizecol
--Update pamlmeaslbl set issample=0 where issample=-1 and amlmeashdrid=@AMLMeasHdrId
--Update pamlmeaslbl set issample=-1 where sizecol= @samplesizecol and amlmeashdrid=@AMLMeasHdrId

Update pamlmeasigc  set pamlmeasigc.Incr=#tempSampleData.IncrDiff 
FROM  pamlmeasigc  INNER JOIN #tempSampleData ON pamlmeasigc.amlmeasigcid = #tempSampleData.amlmeasigcid AND 
pamlmeasigc.amlmeaspomid = #tempSampleData.amlmeaspomid AND 
pamlmeasigc.amlmeashdrid = #tempSampleData.amlmeashdrid and 
pamlmeasigc.pom_row=#tempSampleData.pom_row and pamlmeasigc.sizecol=#tempSampleData.sizecol 
where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId

--select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId order by pom_row, sizecol
--select * from pamlmeaslbl where issample=-1 and amlmeashdrid=@AMLMeasHdrId order by sizecol
DROP TABLE #tempSampleData


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '510', GetDate())
GO

