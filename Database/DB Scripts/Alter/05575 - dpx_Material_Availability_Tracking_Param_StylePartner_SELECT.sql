IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Material_Availability_Tracking_Param_StylePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Material_Availability_Tracking_Param_StylePartner_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Material_Availability_Tracking_Param_StylePartner_SELECT]
	@SeasonYearID AS UNIQUEIDENTIFIER = NULL
	, @Style AS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @tmpStyle AS TABLE (StyleID UNIQUEIDENTIFIER)
	
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	INSERT INTO @tmpStyle SELECT CAST(value AS UNIQUEIDENTIFIER) FROM dbo.fnx_Split(@Style,',')
	
	SELECT '00000000-0000-0000-0000-000000000000' AS TradePartnerRelationshipLevelID, 'N/A' AS AgentName, 0 AS Sort UNION
	SELECT DISTINCT tprl.TradePartnerRelationshipLevelID
		, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 1000) AS AgentName
		, 1 AS Sort
	FROM pSampleRequestBOMTrade srt
		INNER JOIN @tmpStyle ts ON srt.StyleID = ts.StyleID
		INNER JOIN pStyleSeasonYear ssy ON srt.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	ORDER BY Sort, AgentName
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05575', GetDate())
GO
