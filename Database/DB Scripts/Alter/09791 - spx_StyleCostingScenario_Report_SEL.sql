IF OBJECT_ID(N'[dbo].[spx_StyleCostingScenario_Report_SEL]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleCostingScenario_Report_SEL]
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingScenario_Report_SEL]
	@Metric nvarchar(max)
	, @Criteria nvarchar(max)
	, @Parameter nvarchar(max)
AS
BEGIN

IF @Metric IS NOT NULL AND @Criteria IS NOT NULL AND @Parameter IS NOT NULL AND ISNUMERIC(@Parameter)=1
BEGIN
	DECLARE @strSQL nvarchar(max)
	SET @strSQL='
	SELECT
		sc.StyleCostingID
		, sc.StyleCostingTypeID
		, sc.StyleID
		, sc.StyleCostingCustomField3
		, sc.StyleCostingCustomField4
		, sc.StyleCostingCustomField6
		, sc.StyleCostingCustomField8
		, sc.StyleCostingCustomField10
		, sc.StyleCostingCustomField11
		, sc.StyleCostingCustomField12
		, sc.StyleCostingCustomField13
		, sc.StyleCostingCustomField14
		, sc.StyleCostingCustomField15
		, sc.StyleCostingCustomField16
		, sc.StyleCostingCustomField17
		, sc.StyleCostingCustomField18
		, sc.StyleCostingCustomField19
		, sc.StyleCostingCustomField20
		, sc.StyleCostingName
		, eri.CurrencyType
		, sc.StyleCostingConvertedCurr
		, sc.StyleCostingComments
		, sc.StyleCostingCustomField36
		, sc.StyleCostingCustomField37
		, sc.StyleCostingCustomField42
		, sc.StyleCostingCustomField43
		, sc.StyleCostingCustomField44
		, sct.StyleCostingType
		, (SELECT ISNULL(SUM(MaterialCost), 0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = sc.StyleCostingScenarioItemsId) AS BOMTotal
		, (SELECT ISNULL(SUM(OperationCost), 0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = sc.StyleCostingScenarioItemsId) AS BOLTotal
		, (SELECT ISNULL(SUM(AdditionalItemCost), 0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = sc.StyleCostingScenarioItemsId) AS AdditionalTotal
		, (CASE sc.StyleCostingTypeID 
			WHEN 4 THEN 1
			WHEN 3 THEN 3
			WHEN 1 THEN 2
		END) AS Sort
		, sh.StyleNo
		, NULL AS StyleCostingScenarioNo
		,(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N''200'')) AS FilePath
		, sh.Description
		, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
		, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
		, ISNULL(sdi.StyleDevelopmentName, ''Variation '' + CAST(sdi.Variation AS NVARCHAR(5))) as Variation
		, sh.StyleType
		, sh.StyleCategory
		, ISNULL(NULLIF(LTRIM(RTRIM(sh.CustomField1)), ''''),''!'') as StyleDivision
		, ssy.StyleSeason
		, ssy.StyleYear
		, ssy.StyleSeasonYearID
		, sch.StyleCostingCustomField10	as TotalStyleCostingCustomField10
		, sch.StyleCostingCustomField6	as TotalStyleCostingCustomField6
		, sch.StyleCostingCustomField7	as TotalStyleCostingCustomField7
		, sch.StyleCostingCustomField8	as TotalStyleCostingCustomField8
		, sch.StyleCostingCustomField9	as TotalStyleCostingCustomField9
		, sch.StyleCostingCustomField12	as TotalStyleCostingCustomField12
		, sch.StyleCostingCustomField11	as TotalStyleCostingCustomField11
		, sch.StyleCostingCustomField13	as TotalStyleCostingCustomField13
		, sch.StyleCostingCustomField1	as TotalStyleCostingCustomField1
		, sch.StyleCostingCustomField2	as TotalStyleCostingCustomField2		
	FROM
		pStyleCosting sc
		INNER JOIN pStyleHeader sh ON sc.StyleID = sh.StyleID
		LEFT JOIN pStyleCostingType sct ON sc.StyleCostingTypeID = sct.StyleCostingTypeID
		LEFT JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		LEFT JOIN pStyleSeasonYear ssy ON sc.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleCostingHeader sch ON sch.StyleCostingHeaderID = sc.StyleCostingHeaderId	
		LEFT JOIN sExchangeRateItem eri ON eri.ExchangeRateItemID = sc.StyleCostingCurrency
		LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	
	
	WHERE sc.' + @Metric + @Criteria + @Parameter +
	
	
	'
	
	UNION

	SELECT
		scsi.StyleCostingID
		, scsi.StyleCostingTypeID
		, scsi.StyleID
		, scsi.StyleCostingCustomField3
		, scsi.StyleCostingCustomField4
		, scsi.StyleCostingCustomField6
		, scsi.StyleCostingCustomField8
		, scsi.StyleCostingCustomField10
		, scsi.StyleCostingCustomField11
		, scsi.StyleCostingCustomField12
		, scsi.StyleCostingCustomField13
		, scsi.StyleCostingCustomField14	
		, scsi.StyleCostingCustomField15
		, scsi.StyleCostingCustomField16
		, scsi.StyleCostingCustomField17
		, scsi.StyleCostingCustomField18
		, scsi.StyleCostingCustomField19		
		, scsi.StyleCostingCustomField20
		, scsi.StyleCostingName
		, eri.CurrencyType
		, scsi.StyleCostingConvertedCurr
		, scsi.StyleCostingComments
		, scsi.StyleCostingCustomField36
		, scsi.StyleCostingCustomField37
		, scsi.StyleCostingCustomField42
		, scsi.StyleCostingCustomField43
		, scsi.StyleCostingCustomField44
		, sct.StyleCostingType
		, (SELECT ISNULL(SUM(MaterialCost), 0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = scsi.StytleCostingScenarioItemsId) AS BOMTotal
		, (SELECT ISNULL(SUM(OperationCost), 0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = scsi.StytleCostingScenarioItemsId) AS BOLTotal
		, (SELECT ISNULL(SUM(AdditionalItemCost), 0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = scsi.StytleCostingScenarioItemsId) AS AdditionalTotal
		, (CASE scsi.StyleCostingTypeID 
			WHEN 4 THEN 1
			WHEN 3 THEN 3
			WHEN 1 THEN 2
		END) AS Sort
		, sh.StyleNo
		, scsi.StyleCostingScenarioNo
		,(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N''200'')) AS FilePath
		, sh.Description
		, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
		, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
		, ISNULL(sdi.StyleDevelopmentName, ''Variation '' + CAST(sdi.Variation AS NVARCHAR(5))) as Variation
		, sh.StyleType
		, sh.StyleCategory
		, ISNULL(NULLIF(LTRIM(RTRIM(sh.CustomField1)), ''''),''!'') as StyleDivision
		, ssy.StyleSeason
		, ssy.StyleYear
		, ssy.StyleSeasonYearID
		, sch.StyleCostingCustomField10	as TotalStyleCostingCustomField10
		, sch.StyleCostingCustomField6	as TotalStyleCostingCustomField6
		, sch.StyleCostingCustomField7	as TotalStyleCostingCustomField7
		, sch.StyleCostingCustomField8	as TotalStyleCostingCustomField8
		, sch.StyleCostingCustomField9	as TotalStyleCostingCustomField9
		, sch.StyleCostingCustomField12	as TotalStyleCostingCustomField12
		, sch.StyleCostingCustomField11	as TotalStyleCostingCustomField11
		, sch.StyleCostingCustomField13	as TotalStyleCostingCustomField13
		, sch.StyleCostingCustomField1	as TotalStyleCostingCustomField1
		, sch.StyleCostingCustomField2	as TotalStyleCostingCustomField2				
	FROM
		pStyleCostingScenarioItems scsi
		INNER JOIN pStyleHeader sh ON scsi.StyleID = sh.StyleID
		LEFT JOIN pStyleCostingType sct ON scsi.StyleCostingTypeID = sct.StyleCostingTypeID
		LEFT JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		INNER JOIN pStyleCostingHeader sch ON sch.StyleCostingHeaderID = scsi.StyleCostingHeaderId
		LEFT JOIN pStyleSeasonYear ssy ON scsi.StyleSeasonYearID = ssy.StyleSeasonYearID
		LEFT JOIN sExchangeRateItem eri ON eri.ExchangeRateItemID = scsi.StyleCostingCurrency
		LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	
	
	WHERE scsi.' + @Metric + @Criteria + @Parameter +
	'
	
	ORDER BY
		StyleNo
		, StyleCostingID
		, Sort
		, StyleCostingScenarioNo'
	EXEC (@strSQL)
END
ELSE
	SELECT
		sc.StyleCostingID
		, sc.StyleCostingTypeID
		, sc.StyleID
		, sc.StyleCostingCustomField3
		, sc.StyleCostingCustomField4
		, sc.StyleCostingCustomField6
		, sc.StyleCostingCustomField8
		, sc.StyleCostingCustomField10
		, sc.StyleCostingCustomField11
		, sc.StyleCostingCustomField12
		, sc.StyleCostingCustomField13
		, sc.StyleCostingCustomField14
		, sc.StyleCostingCustomField15
		, sc.StyleCostingCustomField16
		, sc.StyleCostingCustomField17
		, sc.StyleCostingCustomField18
		, sc.StyleCostingCustomField19
		, sc.StyleCostingCustomField20
		, sc.StyleCostingName
		, eri.CurrencyType
		, sc.StyleCostingConvertedCurr
		, sc.StyleCostingComments
		, sc.StyleCostingCustomField36
		, sc.StyleCostingCustomField37
		, sc.StyleCostingCustomField42
		, sc.StyleCostingCustomField43
		, sc.StyleCostingCustomField44
		, sct.StyleCostingType
		, (SELECT ISNULL(SUM(MaterialCost), 0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = sc.StyleCostingScenarioItemsId) AS BOMTotal
		, (SELECT ISNULL(SUM(OperationCost), 0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = sc.StyleCostingScenarioItemsId) AS BOLTotal
		, (SELECT ISNULL(SUM(AdditionalItemCost), 0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = sc.StyleCostingScenarioItemsId) AS AdditionalTotal
		, (CASE sc.StyleCostingTypeID 
			WHEN 4 THEN 1
			WHEN 3 THEN 3
			WHEN 1 THEN 2
		END) AS Sort
		, sh.StyleNo
		, NULL AS StyleCostingScenarioNo
		,(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'200')) AS FilePath
		, sh.Description
		, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
		, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS NVARCHAR(5))) as Variation
		, sh.StyleType
		, sh.StyleCategory
		, ISNULL(NULLIF(LTRIM(RTRIM(sh.CustomField1)), ''),'!') as StyleDivision
		, ssy.StyleSeason
		, ssy.StyleYear
		, ssy.StyleSeasonYearID
		, sch.StyleCostingCustomField10	as TotalStyleCostingCustomField10
		, sch.StyleCostingCustomField6	as TotalStyleCostingCustomField6
		, sch.StyleCostingCustomField7	as TotalStyleCostingCustomField7
		, sch.StyleCostingCustomField8	as TotalStyleCostingCustomField8
		, sch.StyleCostingCustomField9	as TotalStyleCostingCustomField9
		, sch.StyleCostingCustomField12	as TotalStyleCostingCustomField12
		, sch.StyleCostingCustomField11	as TotalStyleCostingCustomField11
		, sch.StyleCostingCustomField13	as TotalStyleCostingCustomField13
		, sch.StyleCostingCustomField1	as TotalStyleCostingCustomField1
		, sch.StyleCostingCustomField2	as TotalStyleCostingCustomField2	
	FROM
		pStyleCosting sc
		INNER JOIN pStyleHeader sh ON sc.StyleID = sh.StyleID
		LEFT JOIN pStyleCostingType sct ON sc.StyleCostingTypeID = sct.StyleCostingTypeID
		LEFT JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		LEFT JOIN pStyleSeasonYear ssy ON sc.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleCostingHeader sch ON sch.StyleCostingHeaderID = sc.StyleCostingHeaderId	
		LEFT JOIN sExchangeRateItem eri ON eri.ExchangeRateItemID = sc.StyleCostingCurrency
		LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId

	UNION

	SELECT
		scsi.StyleCostingID
		, scsi.StyleCostingTypeID
		, scsi.StyleID
		, scsi.StyleCostingCustomField3
		, scsi.StyleCostingCustomField4
		, scsi.StyleCostingCustomField6
		, scsi.StyleCostingCustomField8
		, scsi.StyleCostingCustomField10
		, scsi.StyleCostingCustomField11
		, scsi.StyleCostingCustomField12
		, scsi.StyleCostingCustomField13
		, scsi.StyleCostingCustomField14
		, scsi.StyleCostingCustomField15
		, scsi.StyleCostingCustomField16
		, scsi.StyleCostingCustomField17
		, scsi.StyleCostingCustomField18
		, scsi.StyleCostingCustomField19
		, scsi.StyleCostingCustomField20
		, scsi.StyleCostingName
		, eri.CurrencyType
		, scsi.StyleCostingConvertedCurr
		, scsi.StyleCostingComments
		, scsi.StyleCostingCustomField36
		, scsi.StyleCostingCustomField37
		, scsi.StyleCostingCustomField42
		, scsi.StyleCostingCustomField43
		, scsi.StyleCostingCustomField44
		, sct.StyleCostingType
		, (SELECT ISNULL(SUM(MaterialCost), 0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = scsi.StytleCostingScenarioItemsId) AS BOMTotal
		, (SELECT ISNULL(SUM(OperationCost), 0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = scsi.StytleCostingScenarioItemsId) AS BOLTotal
		, (SELECT ISNULL(SUM(AdditionalItemCost), 0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = scsi.StytleCostingScenarioItemsId) AS AdditionalTotal
		, (CASE scsi.StyleCostingTypeID 
			WHEN 4 THEN 1
			WHEN 3 THEN 3
			WHEN 1 THEN 2
		END) AS Sort
		, sh.StyleNo
		, scsi.StyleCostingScenarioNo
		,(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'200')) AS FilePath
		, sh.Description
		, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
		, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS NVARCHAR(5))) as Variation
		, sh.StyleType
		, sh.StyleCategory
		, ISNULL(NULLIF(LTRIM(RTRIM(sh.CustomField1)), ''),'!') as StyleDivision
		, ssy.StyleSeason
		, ssy.StyleYear
		, ssy.StyleSeasonYearID
		, sch.StyleCostingCustomField10	as TotalStyleCostingCustomField10
		, sch.StyleCostingCustomField6	as TotalStyleCostingCustomField6
		, sch.StyleCostingCustomField7	as TotalStyleCostingCustomField7
		, sch.StyleCostingCustomField8	as TotalStyleCostingCustomField8
		, sch.StyleCostingCustomField9	as TotalStyleCostingCustomField9
		, sch.StyleCostingCustomField12	as TotalStyleCostingCustomField12
		, sch.StyleCostingCustomField11	as TotalStyleCostingCustomField11
		, sch.StyleCostingCustomField13	as TotalStyleCostingCustomField13
		, sch.StyleCostingCustomField1	as TotalStyleCostingCustomField1
		, sch.StyleCostingCustomField2	as TotalStyleCostingCustomField2		
	FROM
		pStyleCostingScenarioItems scsi
		INNER JOIN pStyleHeader sh ON scsi.StyleID = sh.StyleID
		LEFT JOIN pStyleCostingType sct ON scsi.StyleCostingTypeID = sct.StyleCostingTypeID
		LEFT JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		LEFT JOIN pStyleSeasonYear ssy ON scsi.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleCostingHeader sch ON sch.StyleCostingHeaderID = scsi.StyleCostingHeaderId
		LEFT JOIN sExchangeRateItem eri ON eri.ExchangeRateItemID = scsi.StyleCostingCurrency
		LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId

	ORDER BY
		StyleNo
		, StyleCostingID
		, Sort
		, StyleCostingScenarioNo
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09791', GetDate())
GO
