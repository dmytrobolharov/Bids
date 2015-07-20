IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_Metric]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_Metric]
GO

CREATE  PROCEDURE [dbo].[spx_StyleMeas_Metric](
@AmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500),
@PageNo INT = NULL,
@PageSize INT = NULL,
@SortOrder NVARCHAR(MAX) = NULL
)
AS 

DECLARE @cols NVARCHAR(2000)
SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pamlmeaslbl where amlmeashdrid = @AmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)
Declare @Metric nvarchar(2)

select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		if Len(@WhereParam) > 0	
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus*2.54) as decimal(18,4)) as tolplus , cast((t3.tolminus*2.54) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.ConvGrade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						and  ' + @WhereParam + ' ) p
				PIVOT
				(
				MAX([ConvGrade])
				FOR sizecol IN
				( '+
				@cols +' )
				) AS pvt
				ORDER BY sortid, refcode, description, pom_row ;'
			end
		else
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus*2.54) as decimal(18,4)) as tolplus , cast((t3.tolminus*2.54) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.ConvGrade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						) p
				PIVOT
				(
				MAX([ConvGrade])
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
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus) as decimal(18,4)) as tolplus , cast((t3.tolminus) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						and  ' + @WhereParam + ' ) p
				PIVOT
				(
				MAX([Grade])
				FOR sizecol IN
				( '+
				@cols +' )
				) AS pvt
				ORDER BY sortid, refcode, description, pom_row ;'
			end
		else
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				INTO #tmp0
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus) as decimal(18,4)) as tolplus , cast((t3.tolminus) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						) p
				PIVOT
				(
				MAX([Grade])
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
VALUES ('DB_Version', '6.1.0000', '09880', GetDate())
GO