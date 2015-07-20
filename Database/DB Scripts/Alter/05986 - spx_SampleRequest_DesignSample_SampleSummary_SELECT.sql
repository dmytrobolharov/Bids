/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_SampleSummary_SELECT]    Script Date: 07/02/2013 15:48:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_SampleSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_SampleSummary_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_SampleSummary_SELECT]    Script Date: 07/02/2013 15:48:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_SampleSummary_SELECT](
@SampleRequestTradeId nvarchar(50)
)
AS 
DECLARE @cols NVARCHAR(2000)





select distinct Submit into #TEMPpMSEvalsamplbl from  pSampleRequestAMLMeasHdr where 
SampleRequestTradeID = @SampleRequestTradeId ORDER BY Submit

SELECT  @cols =  COALESCE(@cols + ',[' +  cast(submit as nvarchar(5)) + ']' ,
                        '[' +  cast(submit as nvarchar(5)) + ']')
FROM    #TEMPpMSEvalsamplbl ORDER BY submit
Drop table #TEMPpMSEvalsamplbl



DECLARE @cols2 NVARCHAR(2000)

SELECT  @cols2 = COALESCE(@cols2 + ',pvt.[' +  cast(sizecol as nvarchar(5)) + '] as Sample' + cast(sizecol as nvarchar(5)),
                         '[' +  cast(sizecol as nvarchar(5)) + '] as Sample' + cast(sizecol as nvarchar(5)))
FROM    pSampleRequestamlmeaslbl where SampleRequestamlmeashdrid = (SELECT TOP 1  SampleRequestAMLMeasHdrId from  pSampleRequestAMLMeasHdr where 
SampleRequestTradeID = @SampleRequestTradeId)
ORDER BY sizecol

select @cols2
select @cols
DECLARE @query NVARCHAR(4000)

	begin
		SET @query = N'SELECT SampleRequestamlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, IsLinked, Critical, Flag4QA, SampMeasValue, SampDelta, RevisedSpec, ' +
		@cols2 +'
		FROM
		(SELECT  t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
			  , t3.IsLinked, t3.Critical, t3.Flag4QA, t2.sizecol
			  , t2.incr, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId,  t3.SampMeasValue, t3.SampDelta, t3.RevisedSpec, t4.submit, t4.SampleRequestamlmeashdrid
		FROM    pSampleRequestamlmeaslbl AS t1
				INNER JOIN pSampleRequestamlmeasigc AS t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId and t1.sizecol = t2.sizecol 
				INNER JOIN pSampleRequestamlmeaspom as t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId and t2.SampleRequestamlmeaspomid=t3.SampleRequestamlmeaspomid and t2.pom_row=t3.pom_row  
				INNER JOIN pSampleRequestamlmeashdr as t4 ON t4.SampleRequestamlmeashdrid = t3.SampleRequestamlmeashdrid where SampleRequestTradeID = ''' + cast(@SampleRequestTradeId as nvarchar(40)) + ''' 
				) p
		PIVOT
		(
		MAX([incr])
		FOR submit IN
		( '+
		@cols +' )
		) AS pvt
		ORDER BY sortid, refcode, description, pom_row ;'
	end

select @query

Execute(@query)



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05986', GetDate())
GO
