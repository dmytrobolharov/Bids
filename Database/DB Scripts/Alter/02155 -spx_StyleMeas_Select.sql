IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_Select]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[spx_StyleMeas_Select](
@AmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500)
)
AS 

DECLARE @cols NVARCHAR(2000)

SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pamlmeaslbl where amlmeashdrid = @AmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)

if Len(@WhereParam) > 0	
	begin
		SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, IsLinked, Critical, ' +
		@cols +'
		FROM
		(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode as refcode, t3.description as description, t3.tolplus, t3.tolminus
			  , t3.IsLinked, t3.Critical, t2.sizecol, t2.incr			  
		FROM    pamlmeaslbl AS t1
				INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
				INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
				and  ' + @WhereParam + ' ) p
		PIVOT
		(
		MAX([incr])
		FOR sizecol IN
		( '+
		@cols +' )
		) AS pvt
		ORDER BY sortid, refcode, description, pom_row ;'
	end
else
	begin
		SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, IsLinked, Critical, ' +
		@cols +'
		FROM
		(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
			  , t3.IsLinked, t3.Critical, t2.sizecol
			  , t2.incr
		FROM    pamlmeaslbl AS t1
				INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
				INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
				) p
		PIVOT
		(
		MAX([incr])
		FOR sizecol IN
		( '+
		@cols +' )
		) AS pvt
		ORDER BY sortid, refcode, description, pom_row ;'
	end

--select @WhereParam as WhereParam 
--select @query as sqlquery

Execute(@query)


Go
 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02155'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02155', GetDate())
END	
GO
