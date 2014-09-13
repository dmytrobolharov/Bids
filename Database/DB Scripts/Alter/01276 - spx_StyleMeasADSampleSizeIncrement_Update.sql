IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasADSampleSizeIncrement_Update]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMeasADSampleSizeIncrement_Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleMeasADSampleSizeIncrement_Update]    Script Date: 03/14/2011 14:48:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[spx_StyleMeasADSampleSizeIncrement_Update]
(
	@AMLMeasHdrId nvarchar(50),
	@samplesizecol int,
	@MaxPOMRow nvarchar(2000)
)

AS

--DECLARE @maxsizecol int
--DECLARE @minsizecol int
--DECLARE @samplesizecol int
Begin

CREATE TABLE #tempSampleData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 amlmeasigcid uniqueidentifier,
 pom_row int,
 sizecol int, 
 IncrDiff decimal(18,4)
 )


--refer only Y sizecol also if sample is max col only this query returns rows
---for sizecol is less than and equal to sample  - sample is <= for example if sample is 2 then sizecols to look in Y is 0,1
 
 --select MaxPOMRows=@MaxPOMRow
 --select samplesizecol=@samplesizecol
 
declare @sqlqry nvarchar(4000)
 
set @sqlqry= 'Insert into #tempSampleData
		SELECT Y.amlmeashdrid, Y.amlmeaspomid, Y.amlmeasigcid, Y.pom_row, Y.sizecol,
		Y.grade - COALESCE(X.Grade, 0) as IncrDiff
		FROM pamlmeasigc AS X
		left JOIN pamlmeasigc AS Y
		ON X.sizecol = Y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid and x.amlmeashdrid=y.amlmeashdrid
		and x.amlmeashdrid = ''' + @AMLMeasHdrId + ''' and x.sizecol <= ''' + (cast(@samplesizecol as nvarchar(20)))
		+ ''' and X.pom_row in (' + @MaxPOMRow + ') order by Y.pom_row, Y.sizecol ' 
		
--select inssqlqry=@sqlqry

Exec (@sqlqry)
	
--refer only X size col - also if sample is 0 or min col only this query returns rows
--for sizecol is greater than sample  if sample is >= for example if sample is 2 then sizecols to look in x is 3,4 
set @sqlqry= 'Insert into #tempSampleData
	SELECT X.amlmeashdrid, X.amlmeaspomid, X.amlmeasigcid, X.pom_row, X.sizecol,
		X.grade - COALESCE(Y.Grade, 0) as IncrDiff
		FROM pamlmeasigc AS X
		left JOIN pamlmeasigc AS Y
		ON X.sizecol = Y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid and x.amlmeashdrid=y.amlmeashdrid
		and x.amlmeashdrid = ''' + @AMLMeasHdrId + ''' and x.sizecol > ''' + (cast(@samplesizecol as nvarchar(20)))
		+ ''' and X.pom_row  in ( ' + @MaxPOMRow + ') order by x.pom_row, x.sizecol '

Exec (@sqlqry)	

--sample column
set @sqlqry= 'Insert into #tempSampleData		
	SELECT X.amlmeashdrid, X.amlmeaspomid, X.amlmeasigcid, X.pom_row, X.sizecol, grade as IncrDiff	
		from pamlmeasigc AS X		
		where x.amlmeashdrid = ''' + @AMLMeasHdrId + ''' and x.sizecol = ''' + (cast(@samplesizecol as nvarchar(20)))
		+ ''' and X.pom_row  in (' + @MaxPOMRow + ')	order by x.pom_row, x.sizecol '					

Exec (@sqlqry)	

Update pamlmeasigc  set pamlmeasigc.Incr=#tempSampleData.IncrDiff 
FROM  pamlmeasigc  INNER JOIN #tempSampleData ON pamlmeasigc.amlmeasigcid = #tempSampleData.amlmeasigcid AND 
pamlmeasigc.amlmeaspomid = #tempSampleData.amlmeaspomid AND 
pamlmeasigc.amlmeashdrid = #tempSampleData.amlmeashdrid and 
pamlmeasigc.pom_row=#tempSampleData.pom_row and pamlmeasigc.sizecol=#tempSampleData.sizecol 
where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId

--select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId order by pom_row, sizecol
--select * from pamlmeaslbl where issample=-1 and amlmeashdrid=@AMLMeasHdrId order by sizecol
DROP TABLE #tempSampleData

end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01276', GetDate())
GO