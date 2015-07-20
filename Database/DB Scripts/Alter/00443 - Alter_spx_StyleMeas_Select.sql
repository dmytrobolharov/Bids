
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  PROCEDURE [dbo].[spx_StyleMeas_Select](
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
		SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, ' +
		@cols +'
		FROM
		(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode as refcode, t3.description as description, t3.tolplus, t3.tolminus
			  , t1.sizecol, t2.incr			  
		FROM    pamlmeaslbl AS t1
				JOIN pamlmeasigc AS t2 ON t1.sizecol = t2.sizecol 
				Join pamlmeaspom as t3 ON t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
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
	end

--select @WhereParam as WhereParam 
--select @query as sqlquery

Execute(@query)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '443', GetDate())
GO

