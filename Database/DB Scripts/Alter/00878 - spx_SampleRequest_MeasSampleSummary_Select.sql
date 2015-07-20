/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasSampleSummary_SELECT]    Script Date: 12/14/2010 12:45:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[spx_SampleRequest_MeasSampleSummary_SELECT](
@SampleRequestHeaderId nvarchar(50)
)
AS 
DECLARE @cols NVARCHAR(2000)

DECLARE @vdrhdrcols NVARCHAR(2000)
DECLARE @revhdrcols NVARCHAR(2000)
DECLARE @samphdrcols NVARCHAR(2000)
DECLARE @evalhdrcols NVARCHAR(2000)
--set @SampleRequestHeaderId='242AE7B7-3193-486B-BD2B-E10DB89D983E'

SELECT  @cols = COALESCE(@cols + ',[' +  cast(sampleIndex as nvarchar(5)) + ']',
                         '[' +  cast(sampleIndex as nvarchar(5)) + ']')
FROM    pMSEvalsamplbl where SampleRequestHeaderId = @SampleRequestHeaderId
ORDER BY sampleIndex

--select @cols as Sizecols

SELECT  @vdrhdrcols = COALESCE(@vdrhdrcols + ',pvt1.[' +  cast(sampleIndex as nvarchar(5)) + '] as VendorSample' + cast(sampleIndex as nvarchar(5)) ,
                         ' pvt1.[' +  cast(sampleIndex as nvarchar(5)) + '] as VendorSample' + cast(sampleIndex as nvarchar(5)))
FROM    pMSEvalsamplbl where SampleRequestHeaderId = @SampleRequestHeaderId
ORDER BY sampleIndex

set @samphdrcols= REPLACE(Replace(@vdrhdrcols, 'Vendor' ,''),'pvt1','pvt2')
set @evalhdrcols= REPLACE(REPLACE(@vdrhdrcols, 'Vendor' ,'Eval'),'pvt1','pvt3')
set @revhdrcols= REPLACE(REPLACE(@vdrhdrcols, 'Vendor' ,'Rev'),'pvt1','pvt4')

--select @evalhdrcols as evalhdrcols
--select @samphdrcols as samphdrcols
--select @hdrcols as hdrcols

DECLARE @query NVARCHAR(4000)

	begin
		SET @query = N'SELECT pvt1.SamplePomId, pvt1.pomrow, pvt1.sortid, pvt1.refcode, pvt1.pomdescription, pvt1.tolplus, pvt1.tolminus, ' +
		@vdrhdrcols + ' , '  + @samphdrcols + ' , ' +  @evalhdrcols + ' , ' +  @revhdrcols + '
		FROM
		(SELECT  t2.SamplePomId, t2.pomrow, t3.sortid, t3.refcode as refcode, t3.pomdescription , t3.tolplus, t3.tolminus
			  , t1.sampleIndex, t2.vdrMeasValue		  
		FROM    pMSEvalsamplbl AS t1
				JOIN pMSEvalSampMeas AS t2 ON t1.sampleIndex = t2.sampleIndex 
				Join pMSEvalPom as t3 ON t2.SamplePomId=t3.SamplePomId and t2.pomrow=t3.pomrow where t2.SampleRequestHeaderId=''' + cast(@SampleRequestHeaderId as nvarchar(50)) + ''' 
				) p
		PIVOT
		(
		MAX([vdrMeasValue])
		FOR sampleIndex IN
		( '+
		@cols +' )
		) AS pvt1
		join
		(SELECT  t2.SamplePomId, t1.sampleIndex, t2.SampMeasValue			  			  
		FROM    pMSEvalsamplbl AS t1
				JOIN pMSEvalSampMeas AS t2 ON t1.sampleIndex = t2.sampleIndex 
				Join pMSEvalPom as t3 ON t2.SamplePomId=t3.SamplePomId and t2.pomrow=t3.pomrow where t2.SampleRequestHeaderId=''' + cast(@SampleRequestHeaderId as nvarchar(50)) + ''' 
				) t
		PIVOT
		(
		MAX([SampMeasValue])
		FOR sampleIndex IN
		( '+
		@cols +' )
		) AS pvt2
		on  pvt1.SamplePomId = pvt2.SamplePomId
		join
		(SELECT  t2.SamplePomId, t1.sampleIndex, t2.EvalMeasValue			  			  
		FROM    pMSEvalsamplbl AS t1
				JOIN pMSEvalSampMeas AS t2 ON t1.sampleIndex = t2.sampleIndex 
				Join pMSEvalPom as t3 ON t2.SamplePomId=t3.SamplePomId and t2.pomrow=t3.pomrow where t2.SampleRequestHeaderId=''' + cast(@SampleRequestHeaderId as nvarchar(50)) + ''' 
				) t
		PIVOT
		(
		MAX([EvalMeasValue])
		FOR sampleIndex IN
		( '+
		@cols +' )
		) AS pvt3
		on  pvt2.SamplePomId = pvt3.SamplePomId		
		join
		(SELECT  t2.SamplePomId, t1.sampleIndex, t2.RevisedSpec			  			  
		FROM    pMSEvalsamplbl AS t1
				JOIN pMSEvalSampMeas AS t2 ON t1.sampleIndex = t2.sampleIndex 
				Join pMSEvalPom as t3 ON t2.SamplePomId=t3.SamplePomId and t2.pomrow=t3.pomrow where t2.SampleRequestHeaderId=''' + cast(@SampleRequestHeaderId as nvarchar(50)) + ''' 
				) t
		PIVOT
		(
		MAX([RevisedSpec])
		FOR sampleIndex IN
		( '+
		@cols +' )
		) AS pvt4
		on  pvt3.SamplePomId = pvt4.SamplePomId	
		ORDER BY pvt1.sortid, pvt1.refcode, pvt1.pomdescription, pvt1.pomrow ;'
	end

--select @query as sqlquery

Execute(@query)

Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '878', GetDate())
GO   