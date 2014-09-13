/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasSample_SELECT]    Script Date: 12/14/2010 12:44:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_SampleRequest_MeasSample_SELECT]
(
@SampleRequestHeaderId nvarchar(50),
@Submit Int
)

AS 

SELECT pMSEvalSampMeas.SampleMeasId, pMSEvalPom.SamplePomId,  pMSEvalPom.SampleRequestHeaderId, pMSEvalPom.AMLMeasHdrId, 
                      pMSEvalPom.AmlMeaspomid, pMSEvalPom.POMRow, pMSEvalPom.Refcode, pMSEvalPom.POMDescription, pMSEvalPom.TolPlus, pMSEvalPom.TolMinus, 
                      pMSEvalPom.HowToMeasurText, pMSEvalPom.ImageId, pMSEvalPom.SortId, pMSEvalPom.WSRowId, pMSEvalSampMeas.SampleLabelId, 
                      pMSEvalSampMeas.SampleIndex, pMSEvalSampMeas.EvalMeasValue, pMSEvalSampMeas.VdrMeasValue, pMSEvalSampMeas.VdrDelta, 
                      pMSEvalSampMeas.VdrOutTol, pMSEvalSampMeas.SampMeasValue, pMSEvalSampMeas.SampDelta, pMSEvalSampMeas.SampOutTol, 
                      pMSEvalSampMeas.SampPOMComment, pMSEvalSampMeas.RevisedSpec, pMSEvalSampMeas.IsVisible, pMSEvalSampMeas.IsSample, 
                      pMSEvalSampMeas.IsVendor
FROM  pMSEvalPom INNER JOIN
                      pMSEvalSampMeas ON pMSEvalPom.SamplePomId = pMSEvalSampMeas.SamplepomId AND 
                      pMSEvalPom.SampleRequestHeaderId = pMSEvalSampMeas.SampleRequestHeaderId AND pMSEvalPom.POMRow = pMSEvalSampMeas.POMRow
where pMSEvalPom.SampleRequestHeaderId = @SampleRequestHeaderId and pMSEvalSampMeas.SampleIndex = @Submit order by pMSEvalPom.SortId,   pMSEvalPom.Refcode,  pMSEvalPom.POMDescription   
Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '875', GetDate())
GO   