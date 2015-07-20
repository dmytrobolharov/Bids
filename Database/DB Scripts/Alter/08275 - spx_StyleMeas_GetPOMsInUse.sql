IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_GetPOMsInUse]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_GetPOMsInUse]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeas_GetPOMsInUse]
	@WorkFlowItemId uniqueidentifier,
	@AMLMeasHdrId uniqueidentifier
AS
BEGIN
	SELECT COUNT(DISTINCT pmsevalsampMeas.AMLMeasPomid) AS [Count]
	FROM pmsevalsampMeas
	JOIN pMSEvalHeader ON pmsevalsampMeas.SampleRequestHeaderId = pMSEvalHeader.SampleRequestHeaderId
	WHERE pMSEvalHeader.WorkFlowItemId = @WorkFlowItemId
		AND pMSEvalHeader.AMLMeasHdrId = @AMLMeasHdrId

	SELECT DISTINCT pmsevalsampMeas.AMLMeasPomid 
	FROM pmsevalsampMeas
	JOIN pMSEvalHeader ON pmsevalsampMeas.SampleRequestHeaderId = pMSEvalHeader.SampleRequestHeaderId
	WHERE pMSEvalHeader.WorkFlowItemId = @WorkFlowItemId
		AND pMSEvalHeader.AMLMeasHdrId = @AMLMeasHdrId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08275', GetDate())
GO
