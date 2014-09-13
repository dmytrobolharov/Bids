
/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_Select]    Script Date: 09/20/2010 08:42:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_StyleMeas_Select](
@AmlMeasHdrID UNIQUEIDENTIFIER
)
AS 

DECLARE @cols NVARCHAR(2000)
SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pamlmeaslbl where amlmeashdrid = @AmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)

SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, ' +
@cols +'
FROM
(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
      , t1.sizecol
      , t2.incr
FROM    pamlmeaslbl AS t1
        JOIN pamlmeasigc AS t2 ON t1.sizecol = t2.sizecol 
		Join pamlmeaspom as t3 ON t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
		) p
PIVOT
(
MAX([incr])
FOR sizecol IN
( '+
@cols +' )
) AS pvt
ORDER BY sortid, refcode, description, pom_row ;'


Execute(@query)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '418', GetDate())
GO





