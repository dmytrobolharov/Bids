IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_Select]
GO

CREATE  PROCEDURE [dbo].[spx_StyleMeas_Select](
@AmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500),
@IsSampleRequest int = 0,
@PageNo INT = NULL,
@PageSize INT = NULL,
@SortOrder NVARCHAR(MAX) = NULL
)
AS 

DECLARE @cols NVARCHAR(2000)
DECLARE @colsdecimal NVARCHAR(2000)	-- Comment #01
SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']' ,
                         '[' +  cast(sizecol as nvarchar(5)) + ']'),
						  @colsdecimal = COALESCE(@colsdecimal + ',CAST([' +  CAST(SizeCol AS NVARCHAR(5)) + '] AS DECIMAL (18,2)) AS ' + '[' + CAST(SizeCol AS NVARCHAR(5)) + ']',
                         'CAST([' +  CAST(SizeCol AS NVARCHAR(5)) + '] AS DECIMAL (18,2)) AS ' + '[' + CAST(SizeCol AS NVARCHAR(5)) + ']')	-- Comment #01
FROM    pamlmeaslbl where amlmeashdrid = @AmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(MAX)
if @IsSampleRequest = 0 
	begin
		if Len(@WhereParam) > 0	
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, CAST (tolplus AS DECIMAL (18,2)) AS tolplus, CAST (tolminus AS DECIMAL (18,2)) AS tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, GRPOMCompanyId, IsLinked, Critical, Flag4QA, ' +
				@colsdecimal +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode as refcode, t3.description as description, t3.tolplus, t3.tolminus
					  , t3.IsLinked, t3.Critical, t3.Flag4QA, t2.sizecol, t2.incr, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId, t3.GRPOMCompanyId
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
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description,CAST (tolplus AS DECIMAL (18,2)) AS tolplus, CAST (tolminus AS DECIMAL (18,2)) AS tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, GRPOMCompanyId, IsLinked, Critical, Flag4QA, ' +
				@colsdecimal +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
					  , t3.IsLinked, t3.Critical, t3.Flag4QA, t2.sizecol
					  , t2.incr, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId, t3.GRPOMCompanyId
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
	end
else
	begin
		if Len(@WhereParam) > 0	
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description,CAST (tolplus AS DECIMAL (18,2)) AS tolplus, CAST (tolminus AS DECIMAL (18,2)) AS tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, GRPOMCompanyId, IsLinked, Critical, Flag4QA, ' +
				@colsdecimal +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t4.sortid, t3.refcode as refcode, t3.description as description, t3.tolplus, t3.tolminus
					  , t3.IsLinked, t3.Critical, t3.Flag4QA, t2.sizecol, t2.incr, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId, t3.GRPOMCompanyId
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row 
						INNER JOIN pMSEvalPom t4 ON t4.AmlMeaspomid = t3.AMLMeasPOMId
						where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
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
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description,CAST (tolplus AS DECIMAL (18,2)) AS tolplus, CAST (tolminus AS DECIMAL (18,2)) AS tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, GRPOMCompanyId, IsLinked, Critical, Flag4QA, ' +
				@colsdecimal +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t4.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
					  , t3.IsLinked, t3.Critical, t3.Flag4QA, t2.sizecol
					  , t2.incr, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId, t3.GRPOMCompanyId
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row 
						INNER JOIN pMSEvalPom t4 ON t4.AmlMeaspomid = t3.AMLMeasPOMId
						where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 
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
	end
DECLARE @sqlString  NVARCHAR(MAX) = @query + dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, NULL)
exec sp_executesql @sqlString


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09881', GetDate())
GO