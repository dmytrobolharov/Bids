IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleToDo_Snapshot_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleToDo_Snapshot_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleToDo_Snapshot_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER
	, @DivisionID UNIQUEIDENTIFIER
	, @StyleTypeID INT = NULL
	, @StyleCategoryID UNIQUEIDENTIFIER = NULL
	, @StyleStatusID NVARCHAR(5) = NULL
)

AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	SELECT
		COUNT(DISTINCT sh.StyleID) AS StyleCount
		, COUNT(DISTINCT scsy.StyleColorwayID) AS ColorCount
		, COUNT(DISTINCT srt.SampleRequestTradeID) + COUNT(DISTINCT srbt.SampleRequestTradeID) AS SampleCount
		, COUNT(DISTINCT sb.StyleMaterialID) + COUNT(DISTINCT sm.StyleMaterialID) AS MaterialCount
		, COUNT(DISTINCT tp.TechPackID) AS TechPackCount
		, COUNT(DISTINCT sch.StyleCostingHeaderID) AS CostingCount
		, COUNT(DISTINCT sqi.StyleQuoteItemID) AS QuoteCount
	FROM pStyleHeader sh
		INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
		LEFT JOIN pStyleColorwaySeasonYear scsy ON ssy.StyleSeasonYearID = scsy.StyleSeasonYearID
		LEFT JOIN pSampleRequestTrade srt ON ssy.StyleSeasonYearID = srt.StyleSeasonYearID
		LEFT JOIN pSampleRequestBOMTrade srbt ON ssy.StyleSeasonYearID = srbt.StyleSeasonYearID
		LEFT JOIN pStyleBOM sb
			INNER JOIN pStyleBOMDimension sbd ON sb.StyleBOMDimensionId = sbd.StyleBOMDimensionID
			INNER JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID	
		ON sh.StyleID = sb.StyleID
			AND ssy.StyleSeasonYearID = wfi.StyleSeasonYearID
			AND sb.MainMaterial = 1
		LEFT JOIN pStyleMaterials sm ON sh.StyleID = sm.StyleID
			AND NOT EXISTS(SELECT * FROM pStyleBOM WHERE StyleID = sh.StyleID)
			AND sm.MainMaterial = 1
		LEFT JOIN pTechPack tp ON ssy.StyleSeasonYearID = tp.StyleSeasonYearID
		LEFT JOIN pStyleCostingHeader sch ON ssy.StyleSeasonYearID = sch.StyleSeasonYearID
		LEFT JOIN pStyleQuoteItem sqi ON ssy.StyleSeasonYearID = sqi.StyleSeasonYearID
		LEFT JOIN xCustom8 xc ON sh.CustomField3 = xc.Custom
	WHERE ssy.SeasonYearID = @SeasonYearID
		AND sh.DivisionID = @DivisionID
		AND (sh.StyleType = @StyleTypeID OR @StyleTypeID IS NULL)
		AND (sh.StyleCategory = @StyleCategoryID OR @StyleCategoryID IS NULL)
		AND (ISNULL(xc.CustomKey, '-1') = @StyleStatusID OR @StyleStatusID IS NULL)		

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08832', GetDate())
GO
