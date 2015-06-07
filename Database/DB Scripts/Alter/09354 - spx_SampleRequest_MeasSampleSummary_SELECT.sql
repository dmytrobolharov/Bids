IF OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasSampleSummary_SELECT]') IS NOT NULL
	DROP PROCEDURE [dbo].[spx_SampleRequest_MeasSampleSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_MeasSampleSummary_SELECT](
	@SampleRequestHeaderId NVARCHAR(50)
)
AS 
DECLARE @cols NVARCHAR(2000)

DECLARE @vdrhdrcols NVARCHAR(2000)
DECLARE @revhdrcols NVARCHAR(2000)
DECLARE @samphdrcols NVARCHAR(2000)
DECLARE @evalhdrcols NVARCHAR(2000)
DECLARE @VdrOutTolCols NVARCHAR(2000)
DECLARE @SampOutTolCols NVARCHAR(2000)

select distinct SampleIndex into #TEMPpMSEvalsamplbl from  pMSEvalsamplbl where 
SampleRequestHeaderId = @SampleRequestHeaderId ORDER BY sampleIndex

SELECT  @cols =  COALESCE(@cols + ',[' +  cast(sampleIndex as nvarchar(5)) + ']',
                        '[' +  cast(sampleIndex as nvarchar(5)) + ']')
FROM    #TEMPpMSEvalsamplbl ORDER BY sampleIndex
Drop table #TEMPpMSEvalsamplbl


SELECT  @vdrhdrcols = COALESCE(@vdrhdrcols + ',pvt1.[' +  cast(sampleIndex as nvarchar(5)) + '] as VendorSample' + cast(sampleIndex as nvarchar(5)) ,
                         ' pvt1.[' +  cast(sampleIndex as nvarchar(5)) + '] as VendorSample' + cast(sampleIndex as nvarchar(5)))
FROM    pMSEvalsamplbl where SampleRequestHeaderId = @SampleRequestHeaderId
ORDER BY sampleIndex

SET @samphdrcols= REPLACE(Replace(@vdrhdrcols, 'Vendor' ,''),'pvt1','pvt2')
SET @evalhdrcols= REPLACE(REPLACE(@vdrhdrcols, 'Vendor' ,'Eval'),'pvt1','pvt3')
SET @revhdrcols= REPLACE(REPLACE(@vdrhdrcols, 'Vendor' ,'Rev'),'pvt1','pvt4')
SET @VdrOutTolCols = REPLACE(REPLACE(@vdrhdrcols, 'VendorSample' ,'VdrOutTol'),'pvt1','pvt5')
SET @SampOutTolCols = REPLACE(REPLACE(@vdrhdrcols, 'VendorSample' ,'SampOutTol'),'pvt1','pvt6')

--select @vdrhdrcols
--select @samphdrcols
--select @evalhdrcols
--select @revhdrcols
--select @VdrOutTolCols
--select @SampOutTolCols

DECLARE @query NVARCHAR(4000)

	begin
		SET @query = N'SELECT pvt1.SamplePomId, pvt1.pomrow, pvt1.sortid, pvt1.refcode, pvt1.pomdescription, pvt1.tolplus, pvt1.tolminus, ' +
		@vdrhdrcols + ' , '  + @samphdrcols + ' , ' +  @evalhdrcols + ' , ' +  @revhdrcols + ' , ' + @VdrOutTolCols + ' , ' +  @SampOutTolCols + ' 
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
		join
		(SELECT  t2.SamplePomId, t1.sampleIndex, t2.VdrOutTol			  			  
		FROM    pMSEvalsamplbl AS t1
				JOIN pMSEvalSampMeas AS t2 ON t1.sampleIndex = t2.sampleIndex 
				Join pMSEvalPom as t3 ON t2.SamplePomId=t3.SamplePomId and t2.pomrow=t3.pomrow where t2.SampleRequestHeaderId=''' + cast(@SampleRequestHeaderId as nvarchar(50)) + ''' 
				) t
		PIVOT
		(
		MAX([VdrOutTol])
		FOR sampleIndex IN
		( '+
		@cols +' )
		) AS pvt5
		on  pvt4.SamplePomId = pvt5.SamplePomId
		join
		(SELECT  t2.SamplePomId, t1.sampleIndex, t2.SampOutTol			  			  
		FROM    pMSEvalsamplbl AS t1
				JOIN pMSEvalSampMeas AS t2 ON t1.sampleIndex = t2.sampleIndex 
				Join pMSEvalPom as t3 ON t2.SamplePomId=t3.SamplePomId and t2.pomrow=t3.pomrow where t2.SampleRequestHeaderId=''' + cast(@SampleRequestHeaderId as nvarchar(50)) + ''' 
				) t
		PIVOT
		(
		MAX([SampOutTol])
		FOR sampleIndex IN
		( '+
		@cols +' )
		) AS pvt6
		on  pvt5.SamplePomId = pvt6.SamplePomId
		ORDER BY pvt1.sortid, pvt1.refcode, pvt1.pomdescription, pvt1.pomrow ;'
	end

--select @query as sqlquery

Execute(@query)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun = '09354'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '6.1.0000', '09354', GetDate())
END	
GO