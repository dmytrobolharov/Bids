IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestTrade_TACalendar_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestTrade_TACalendar_SEL]
GO


CREATE VIEW [dbo].[vwx_SampleRequestTrade_TACalendar_SEL]
AS
SELECT pSampleRequestBOMTrade.SampleRequestTradeID, pSampleRequestBOMTrade.StyleID, pSampleRequestBOMTrade.StyleSeasonYearID,
		pSampleRequestBOMTrade.EnableSampleRequestPages, 
		pTACalTemplate.TACalTemplateId as SampleTACalendarID,
		pTACalTemplate.TACalTemplateId, pTACalTemplate.TACalTemplateName, pTACalTemplate.TACalTemplateDescription
FROM pSampleRequestBOMTrade
	LEFT JOIN pTACalReference ON pSampleRequestBOMTrade.SampleRequestTradeID = pTACalReference.ReferenceId
	LEFT JOIN pTACalTemplate ON pTACalReference.TACalTemplateId = pTACalTemplate.TACalTemplateId
UNION
SELECT pSampleRequestTrade.SampleRequestTradeID, pSampleRequestTrade.StyleID, pSampleRequestTrade.StyleSeasonYearID,
		pSampleRequestTrade.EnableSampleRequestPages, 
		pTACalTemplate.TACalTemplateId as SampleTACalendarID,
		pTACalTemplate.TACalTemplateId, pTACalTemplate.TACalTemplateName, pTACalTemplate.TACalTemplateDescription
FROM pSampleRequestTrade
	LEFT JOIN pTACalReference ON pSampleRequestTrade.SampleRequestTradeID = pTACalReference.ReferenceId
	LEFT JOIN pTACalTemplate ON pTACalReference.TACalTemplateId = pTACalTemplate.TACalTemplateId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08522', GetDate())
GO
