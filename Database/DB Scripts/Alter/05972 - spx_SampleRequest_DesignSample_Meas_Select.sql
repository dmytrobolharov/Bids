/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Select]    Script Date: 07/02/2013 15:45:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Select]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Select]    Script Date: 07/02/2013 15:45:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Select](
@SampleRequestAmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500)
)
AS 

DECLARE @cols NVARCHAR(2000)

SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pSampleRequestamlmeaslbl where SampleRequestamlmeashdrid = @SampleRequestAmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)

if Len(@WhereParam) > 0	
	begin
		SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, IsLinked, Critical, Flag4QA, SampMeasValue, SampDelta, RevisedSpec, ' +
		@cols +'
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

--select @WhereParam as WhereParam 
--select @query as sqlquery

Execute(@query)




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05972', GetDate())
GO
