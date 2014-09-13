
/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBySubmit_SELECT_API]    Script Date: 02/18/2014 16:09:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBySubmit_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBySubmit_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBySubmit_SELECT_API]    Script Date: 02/18/2014 16:09:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_SampleRequestBySubmit_SELECT_API](
	@SampleRequestSubmitID UNIQUEIDENTIFIER	
)
AS

SELECT * FROM (
SELECT srs.SampleRequestSubmitID, srs.SampleRequestTradeID, srs.StyleID, ssy.SeasonYearID
FROM pSampleRequestSubmit srs
INNER JOIN pSampleRequestTrade srt on srt.SampleRequestTradeID = srs.SampleRequestTradeID
INNER JOIN pStyleSeasonYear ssy on srt.StyleSeasonYearID = ssy.StyleSeasonYearID

UNION

SELECT srs.SampleRequestSubmitID, srs.SampleRequestTradeID, srs.StyleID, ssy.SeasonYearID
FROM pSampleRequestSubmitBOM srs
INNER JOIN pSampleRequestBOMTrade srt on srt.SampleRequestTradeID = srs.SampleRequestTradeID
INNER JOIN pStyleSeasonYear ssy on srt.StyleSeasonYearID = ssy.StyleSeasonYearID

) p 
WHERE SampleRequestSubmitID = @SampleRequestSubmitID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07176', GetDate())
GO