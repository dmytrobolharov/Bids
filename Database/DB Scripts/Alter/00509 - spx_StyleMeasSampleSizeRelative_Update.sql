set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasSampleSizeRelative_Update') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasSampleSizeRelative_Update
GO





create PROCEDURE [dbo].[spx_StyleMeasSampleSizeRelative_Update]
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
 wsrowid int,
 sizecol int, 
 IncrDiff decimal(18,4)
 )

--select @maxsizecol = max(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @minsizecol =min(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @samplesizecol = sizecol from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId and issample=-1

Insert into #tempSampleData
SELECT Y.amlmeashdrid, Y.amlmeaspomid, Y.amlmeasigcid, Y.pom_row, Y.wsrowid, Y.sizecol, 
		Y.grade - COALESCE(X.Grade, 0) as IncrDiff
		FROM pamlmeasigc AS X, pamlmeasigc AS Y where 
		x.pom_row=y.pom_row and x.wsrowid=y.wsrowid
		and x.amlmeaspomid=y.amlmeaspomid and x.amlmeashdrid=y.amlmeashdrid
		and x.amlmeashdrid =@AMLMeasHdrId and x.sizecol = @samplesizecol   and Y.sizecol <> @samplesizecol 
		order by Y.pom_row, Y.sizecol desc


--select * from #tempSampleData order by pom_row, sizecol
--Update pamlmeaslbl set issample=0 where issample=-1 and amlmeashdrid=@AMLMeasHdrId
--Update pamlmeaslbl set issample=-1 where sizecol= @samplesizecol and amlmeashdrid=@AMLMeasHdrId

Update pamlmeasigc  set pamlmeasigc.Incr=#tempSampleData.IncrDiff 
FROM  pamlmeasigc  INNER JOIN #tempSampleData ON pamlmeasigc.amlmeasigcid = #tempSampleData.amlmeasigcid AND 
pamlmeasigc.amlmeaspomid = #tempSampleData.amlmeaspomid AND 
pamlmeasigc.amlmeashdrid = #tempSampleData.amlmeashdrid and 
pamlmeasigc.wsrowid = #tempSampleData.wsrowid and 
pamlmeasigc.pom_row=#tempSampleData.pom_row and pamlmeasigc.sizecol=#tempSampleData.sizecol 
where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId

Update pamlmeasigc  set pamlmeasigc.Incr=pamlmeasigc.Grade 
FROM  pamlmeasigc  INNER JOIN pamlmeaspom ON  
pamlmeasigc.amlmeaspomid = pamlmeaspom.amlmeaspomid AND 
pamlmeasigc.amlmeashdrid = pamlmeaspom.amlmeashdrid and 
pamlmeasigc.wsrowid = pamlmeaspom.wsrowid and 
pamlmeasigc.pom_row=pamlmeaspom.pom_row  
where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId and  pamlmeasigc.sizecol=@samplesizecol


--select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId order by pom_row, sizecol
--select * from pamlmeaslbl where issample=-1 and amlmeashdrid=@AMLMeasHdrId order by sizecol
DROP TABLE #tempSampleData


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '509', GetDate())
GO



