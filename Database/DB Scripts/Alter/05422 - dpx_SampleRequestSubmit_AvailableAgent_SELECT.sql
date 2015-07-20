IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SampleRequestSubmit_AvailableAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SampleRequestSubmit_AvailableAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestSubmit_AvailableAgent_SELECT]


AS



SELECT TradePartnerID, TradePartnerName, Country FROM uTradePartner 
WHERE TradePartnerID IN (
	SELECT TradePartnerID FROM pSampleRequestWorkflow
	UNION ALL
	SELECT TradePartnerID FROM pSampleRequestWorkflowBOM
)
ORDER BY TradePartnerName

--IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
--BEGIN 
--	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
--END
--
--CREATE TABLE #tempStyleSeasonYear(
--	StyleID uniqueidentifier,
--	SeasonYearID uniqueidentifier
--)
--
--INSERT INTO #tempStyleSeasonYear (StyleID, SeasonYearID)
--SELECT StyleID, SeasonYearID FROM pStyleSeasonYear 
--WHERE SeasonYearID = @SeasonYearID

--
--SELECT TradePartnerID, TradePartnerName, Country FROM uTradePartner WHERE TradePartnerID IN (SELECT TradePartnerID FROM pSampleRequestWorkflow 
--WHERE pSampleRequestWorkflow.StyleId IN (SELECT StyleID FROM #tempStyleSeasonYear))
--ORDER BY TradePartnerName


--DROP TABLE #tempStyleSeasonYear

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05422', GetDate())
GO
