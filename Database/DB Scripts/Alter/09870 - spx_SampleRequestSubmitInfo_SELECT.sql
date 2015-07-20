IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSubmitInfo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSubmitInfo_SELECT]
(
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		srs.SampleRequestWorkflowID
		, srs.StyleID
		, srs.StyleSet
		, srs.SampleRequestTradeID
		, srs.Submit
		, sh.StyleNo
	FROM pSampleRequestSubmitBOM srs
		INNER JOIN pStyleHeader sh ON srs.StyleID = sh.StyleID
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09870', GetDate())
GO