/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Metric]    Script Date: 07/02/2013 15:44:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Metric]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Metric]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Metric]    Script Date: 07/02/2013 15:44:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Metric](
@AmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500)
)
AS 

DECLARE @cols NVARCHAR(2000)
SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pSampleRequestamlmeaslbl where SampleRequestamlmeashdrid = @AmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)
Declare @Metric nvarchar(2)

select @Metric=Ismetric from pSampleRequestamlmeashdr where SampleRequestamlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		if Len(@WhereParam) > 0	
			begin
				SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus*2.54) as decimal(18,4)) as tolplus , cast((t3.tolminus*2.54) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.ConvGrade
				FROM    pSampleRequestamlmeaslbl AS t1
						INNER JOIN pSampleRequestamlmeasigc AS t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pSampleRequestamlmeaspom as t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId and t2.SampleRequestamlmeaspomid=t3.SampleRequestamlmeaspomid and t2.pom_row=t3.pom_row where t2.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
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
				SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus*2.54) as decimal(18,4)) as tolplus , cast((t3.tolminus*2.54) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.ConvGrade
				FROM    pSampleRequestamlmeaslbl AS t1
						INNER JOIN pSampleRequestamlmeasigc AS t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pSampleRequestamlmeaspom as t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId and t2.SampleRequestamlmeaspomid=t3.SampleRequestamlmeaspomid and t2.pom_row=t3.pom_row where t2.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
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
				SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus) as decimal(18,4)) as tolplus , cast((t3.tolminus) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pSampleRequestamlmeaslbl AS t1
						INNER JOIN pSampleRequestamlmeasigc AS t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pSampleRequestamlmeaspom as t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId and t2.SampleRequestamlmeaspomid=t3.SampleRequestamlmeaspomid and t2.pom_row=t3.pom_row where t2.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
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
				SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, cast((t3.tolplus) as decimal(18,4)) as tolplus , cast((t3.tolminus) as decimal(18,4)) as tolminus
					  , t1.sizecol, cast((t3.BeforeTreat*2.54) as decimal(18,4)) as BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pSampleRequestamlmeaslbl AS t1
						INNER JOIN pSampleRequestamlmeasigc AS t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pSampleRequestamlmeaspom as t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId and t2.SampleRequestamlmeaspomid=t3.SampleRequestamlmeaspomid and t2.pom_row=t3.pom_row where t2.SampleRequestamlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
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

EXECute(@query)



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05969', GetDate())
GO
