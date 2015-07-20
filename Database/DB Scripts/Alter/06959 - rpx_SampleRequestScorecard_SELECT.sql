IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestScorecard_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestScorecard_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestScorecard_SELECT]
	@AgentActive INT
	, @VendorActive INT
	, @FactoryActive INT
AS 
BEGIN
	SELECT
		sh.StyleCategory, sy.Season, sy.[Year]
		, tprl.AgentCode, tprl.AgentName
		, tprl.VendorCode, tprl.VendorName
		, tprl.FactoryCode, tprl.FactoryName
		, COUNT(DISTINCT srt.SampleRequestTradeID) AS SampleRequestCount
		, CAST(COUNT(CASE WHEN srs.DueDate > srs.RecDate THEN srs.SampleRequestSubmitID ELSE NULL END) AS DECIMAL) / CAST(COUNT(srs.SampleRequestSubmitID) AS DECIMAL) AS SubmitCountEarly
		, CAST(COUNT(CASE WHEN srs.DueDate = srs.RecDate THEN srs.SampleRequestSubmitID ELSE NULL END) AS DECIMAL) / CAST(COUNT(srs.SampleRequestSubmitID) AS DECIMAL) AS SubmitCountInTime
		, CAST(COUNT(CASE WHEN srs.DueDate < srs.RecDate THEN srs.SampleRequestSubmitID ELSE NULL END) AS DECIMAL) / CAST(COUNT(srs.SampleRequestSubmitID) AS DECIMAL) AS SubmitCountLate
		, CAST(COUNT(CASE WHEN srs.RecDate IS NULL THEN srs.SampleRequestSubmitID ELSE NULL END) AS DECIMAL) / CAST(COUNT(srs.SampleRequestSubmitID) AS DECIMAL) AS SubmitCountOther
	FROM pSampleRequestBOMTrade srt
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		INNER JOIN pSampleRequestSubmitBOM srs ON srt.SampleRequestTradeID = srs.SampleRequestTradeID
		LEFT JOIN pStyleHeader sh ON srt.StyleID = sh.StyleID
	WHERE
		(tprl.AgentActive = @AgentActive OR tprl.AgentActive IS NULL)
		AND (tprl.VendorActive = @VendorActive OR tprl.VendorActive IS NULL)
		AND (tprl.FactoryActive = @FactoryActive OR tprl.FactoryActive IS NULL)
	GROUP BY
		sh.StyleCategory, sy.Season, sy.[Year]
		, tprl.AgentCode, tprl.AgentName
		, tprl.VendorCode, tprl.VendorName
		, tprl.FactoryCode, tprl.FactoryName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06959', GetDate())
GO
