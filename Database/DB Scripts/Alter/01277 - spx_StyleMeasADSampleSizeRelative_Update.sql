IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasADSampleSizeRelative_Update]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMeasADSampleSizeRelative_Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleMeasADSampleSizeRelative_Update]    Script Date: 03/15/2011 13:22:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_StyleMeasADSampleSizeRelative_Update]
(
	@AMLMeasHdrId nvarchar(50),
	@samplesizecol int,
	@MaxPOMRow int
)

AS

declare @sqlqry nvarchar(4000)

CREATE TABLE #tempSampleData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 amlmeasigcid uniqueidentifier,
 pom_row int,
 wsrowid int,
 sizecol int, 
 IncrDiff decimal(18,4)
 )

set @sqlqry = 'Insert into #tempSampleData
	SELECT Y.amlmeashdrid, Y.amlmeaspomid, Y.amlmeasigcid, Y.pom_row, Y.wsrowid, Y.sizecol, 
		Y.grade - COALESCE(X.Grade, 0) as IncrDiff
		FROM pamlmeasigc AS X, pamlmeasigc AS Y where 
		x.pom_row=y.pom_row and x.wsrowid=y.wsrowid
		and x.amlmeaspomid=y.amlmeaspomid and x.amlmeashdrid=y.amlmeashdrid
		and x.amlmeashdrid = ''' + @AMLMeasHdrId + ''' and x.sizecol = ''' + cast(@samplesizecol as nvarchar(20)) + ''' and Y.sizecol <> ''' + cast(@samplesizecol as nvarchar(20)) 
		+ ''' and Y.pom_row In (' + @MaxPOMRow + ') order by Y.pom_row, Y.sizecol desc '

Exec (@sqlqry)
--select * from #tempSampleData order by pom_row, sizecol

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
VALUES     ('DB_Version', '4.0.0000', '01277', GetDate())
GO