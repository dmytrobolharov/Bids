IF OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Select]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Select]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Select](
@SampleRequestAmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500),
@PageNo INT = NULL,
@PageSize INT = NULL,
@SortOrder NVARCHAR(MAX) = NULL
)
AS 

DECLARE @cols NVARCHAR(2000)

SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pSampleRequestamlmeaslbl where SampleRequestamlmeashdrid = @SampleRequestAmlMeasHdrID
ORDER BY sizecol

DECLARE @query NVARCHAR(4000)

if Len(@WhereParam) > 0	
	begin
		SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, IsLinked, Critical, Flag4QA, SampMeasValue, SampDelta, RevisedSpec, ' +
		@cols +'
		INTO #tmp0
		FROM
		(SELECT  t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode as refcode, t3.description as description, t3.tolplus, t3.tolminus
			  , t3.IsLinked, t3.Critical, t3.Flag4QA, t2.sizecol, t2.incr, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId, t3.SampMeasValue, t3.SampDelta, t3.RevisedSpec			  
		FROM    pSampleRequestamlmeaslbl AS t1
				INNER JOIN pSampleRequestamlmeasigc AS t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId and t1.sizecol = t2.sizecol 
				INNER JOIN pSampleRequestamlmeaspom as t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId and t2.SampleRequestamlmeaspomid=t3.SampleRequestamlmeaspomid and t2.pom_row=t3.pom_row where t2.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAmlMeasHdrID as nvarchar(50)) + ''' 
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
		SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, IsLinked, Critical, Flag4QA, SampMeasValue, SampDelta, RevisedSpec, ' +
		@cols +'
		INTO #tmp0
		FROM
		(SELECT  t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
			  , t3.IsLinked, t3.Critical, t3.Flag4QA, t2.sizecol
			  , t2.incr, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId,  t3.SampMeasValue, t3.SampDelta, t3.RevisedSpec
		FROM    pSampleRequestamlmeaslbl AS t1
				INNER JOIN pSampleRequestamlmeasigc AS t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId and t1.sizecol = t2.sizecol 
				INNER JOIN pSampleRequestamlmeaspom as t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId and t2.SampleRequestamlmeaspomid=t3.SampleRequestamlmeaspomid and t2.pom_row=t3.pom_row where t2.SampleRequestamlmeashdrid=''' + cast(@SampleRequestAmlMeasHdrID as nvarchar(50)) + ''' 
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

DECLARE @sqlString  NVARCHAR(MAX) = @query + dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, NULL)
exec sp_executesql @sqlString
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09960', GetUTCDate())
GO

