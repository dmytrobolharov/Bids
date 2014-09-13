IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Style_CostingScenario_Report_SEL]'))
DROP VIEW [dbo].[vwx_Style_CostingScenario_Report_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Style_CostingScenario_Report_SEL]
AS
SELECT
	pStyleCosting.StyleCostingID
	, pStyleCosting.StyleCostingTypeID
	, pStyleCosting.StyleID
	, pStyleCosting.StyleCostingCustomField3
	, pStyleCosting.StyleCostingCustomField4
	, pStyleCosting.StyleCostingCustomField6
	, pStyleCosting.StyleCostingCustomField8
	, pStyleCosting.StyleCostingCustomField10
	, pStyleCosting.StyleCostingCustomField12
	, pStyleCosting.StyleCostingCustomField13
	, pStyleCosting.StyleCostingCustomField14
	, pStyleCosting.StyleCostingCustomField15
	, pStyleCosting.StyleCostingCustomField16
	, pStyleCosting.StyleCostingCustomField17
	, pStyleCosting.StyleCostingCustomField18
	, pStyleCosting.StyleCostingCustomField19
	, pStyleCosting.StyleCostingCustomField20
	, pStyleCosting.StyleCostingName
	, pCurrency.Custom
	, pStyleCosting.StyleCostingConvertedCurr
	, pStyleCosting.StyleCostingComments
	, pStyleCosting.StyleCostingCustomField36
	, pStyleCosting.StyleCostingCustomField39
	, pStyleCosting.StyleCostingCustomField42
	, pStyleCosting.StyleCostingCustomField43
	, pStyleCosting.StyleCostingCustomField44
	, pStyleCostingType.StyleCostingType
	, (SELECT ISNULL(SUM(MaterialCost), 0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = pStyleCosting.StyleCostingScenarioItemsId) AS BOMTotal
	, (SELECT ISNULL(SUM(OperationCost), 0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = pStyleCosting.StyleCostingScenarioItemsId) AS BOLTotal
	, (SELECT ISNULL(SUM(AdditionalItemCost), 0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = pStyleCosting.StyleCostingScenarioItemsId) AS AdditionalTotal
	, (CASE pStyleCosting.StyleCostingTypeID 
		WHEN 4 THEN 1
		WHEN 3 THEN 3
		WHEN 1 THEN 2
	END) AS Sort
	, pStyleHeader.StyleNo
	, NULL AS StyleCostingScenarioNo
	,(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion, N'200')) AS FilePath
	, pStyleHeader.Description
	, pStyleHeader.SizeClass
	, pStyleHeader.SizeRange
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS NVARCHAR(5))) as Variation
	, pStyleHeader.StyleType
	, pStyleHeader.StyleCategory
	, ISNULL(NULLIF(LTRIM(RTRIM(pStyleHeader.CustomField1)), ''),'!') as StyleDivision
	, pStyleSeasonYear.StyleSeason
	, pStyleSeasonYear.StyleYear
	, pStyleSeasonYear.StyleSeasonYearID
	, pStyleCostingHeader.StyleCostingCustomField10	as TotalStyleCostingCustomField10
	, pStyleCostingHeader.StyleCostingCustomField6	as TotalStyleCostingCustomField6
	, pStyleCostingHeader.StyleCostingCustomField7	as TotalStyleCostingCustomField7
	, pStyleCostingHeader.StyleCostingCustomField8	as TotalStyleCostingCustomField8
	, pStyleCostingHeader.StyleCostingCustomField9	as TotalStyleCostingCustomField9
	, pStyleCostingHeader.StyleCostingCustomField12	as TotalStyleCostingCustomField12
	, pStyleCostingHeader.StyleCostingCustomField11	as TotalStyleCostingCustomField11
	, pStyleCostingHeader.StyleCostingCustomField13	as TotalStyleCostingCustomField13
FROM
	pStyleCosting
	INNER JOIN pStyleHeader ON pStyleCosting.StyleID = pStyleHeader.StyleID
	LEFT JOIN pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID
	LEFT JOIN pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
	LEFT JOIN pStyleSeasonYear ON pStyleCosting.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	INNER JOIN pStyleCostingHeader ON pStyleCostingHeader.StyleCostingHeaderID = pStyleCosting.StyleCostingHeaderId	
	LEFT JOIN pCurrency ON pStyleCosting.StyleCostingCurrency = pCurrency.CustomId
	
UNION

SELECT
	pStyleCostingScenarioItems.StyleCostingID
	, pStyleCostingScenarioItems.StyleCostingTypeID
	, pStyleCostingScenarioItems.StyleID
	, pStyleCostingScenarioItems.StyleCostingCustomField3
	, pStyleCostingScenarioItems.StyleCostingCustomField4
	, pStyleCostingScenarioItems.StyleCostingCustomField6
	, pStyleCostingScenarioItems.StyleCostingCustomField8
	, pStyleCostingScenarioItems.StyleCostingCustomField10
	, pStyleCostingScenarioItems.StyleCostingCustomField11
	, pStyleCostingScenarioItems.StyleCostingCustomField12
	, pStyleCostingScenarioItems.StyleCostingCustomField13
	, pStyleCostingScenarioItems.StyleCostingCustomField14	
	, pStyleCostingScenarioItems.StyleCostingCustomField15
	, pStyleCostingScenarioItems.StyleCostingCustomField16
	, pStyleCostingScenarioItems.StyleCostingCustomField17
	, pStyleCostingScenarioItems.StyleCostingCustomField18
	, pStyleCostingScenarioItems.StyleCostingCustomField20
	, pStyleCostingScenarioItems.StyleCostingName
	, pCurrency.Custom
	, pStyleCostingScenarioItems.StyleCostingConvertedCurr
	, pStyleCostingScenarioItems.StyleCostingComments
	, pStyleCostingScenarioItems.StyleCostingCustomField36
	, pStyleCostingScenarioItems.StyleCostingCustomField39
	, pStyleCostingScenarioItems.StyleCostingCustomField42
	, pStyleCostingScenarioItems.StyleCostingCustomField43
	, pStyleCostingScenarioItems.StyleCostingCustomField44
	, pStyleCostingType.StyleCostingType
	, (SELECT ISNULL(SUM(MaterialCost), 0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = pStyleCostingScenarioItems.StytleCostingScenarioItemsId) AS BOMTotal
	, (SELECT ISNULL(SUM(OperationCost), 0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = pStyleCostingScenarioItems.StytleCostingScenarioItemsId) AS BOLTotal
	, (SELECT ISNULL(SUM(AdditionalItemCost), 0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = pStyleCostingScenarioItems.StytleCostingScenarioItemsId) AS AdditionalTotal
	, (CASE pStyleCostingScenarioItems.StyleCostingTypeID 
		WHEN 4 THEN 1
		WHEN 3 THEN 3
		WHEN 1 THEN 2
	END) AS Sort
	, pStyleHeader.StyleNo
	, pStyleCostingScenarioItems.StyleCostingScenarioNo
	,(SELECT TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion, N'200')) AS FilePath
	, pStyleHeader.Description
	, pStyleHeader.SizeClass
	, pStyleHeader.SizeRange
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS NVARCHAR(5))) as Variation
	, pStyleHeader.StyleType
	, pStyleHeader.StyleCategory
	, ISNULL(NULLIF(LTRIM(RTRIM(pStyleHeader.CustomField1)), ''),'!') as StyleDivision
	, pStyleSeasonYear.StyleSeason
	, pStyleSeasonYear.StyleYear
	, pStyleSeasonYear.StyleSeasonYearID
	, pStyleCostingHeader.StyleCostingCustomField10	as TotalStyleCostingCustomField10
	, pStyleCostingHeader.StyleCostingCustomField6	as TotalStyleCostingCustomField6
	, pStyleCostingHeader.StyleCostingCustomField7	as TotalStyleCostingCustomField7
	, pStyleCostingHeader.StyleCostingCustomField8	as TotalStyleCostingCustomField8
	, pStyleCostingHeader.StyleCostingCustomField9	as TotalStyleCostingCustomField9
	, pStyleCostingHeader.StyleCostingCustomField12	as TotalStyleCostingCustomField12
	, pStyleCostingHeader.StyleCostingCustomField11	as TotalStyleCostingCustomField11
	, pStyleCostingHeader.StyleCostingCustomField13	as TotalStyleCostingCustomField13
FROM
	pStyleCostingScenarioItems
	INNER JOIN pStyleHeader ON pStyleCostingScenarioItems.StyleID = pStyleHeader.StyleID
	LEFT JOIN pStyleCostingType ON pStyleCostingScenarioItems.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID
	LEFT JOIN pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
	LEFT JOIN pStyleSeasonYear ON pStyleCostingScenarioItems.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	INNER JOIN pStyleCostingHeader ON pStyleCostingHeader.StyleCostingHeaderID = pStyleCostingScenarioItems.StyleCostingHeaderId
	LEFT JOIN pCurrency ON pStyleCostingScenarioItems.StyleCostingCurrency = pCurrency.CustomId	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04315', GetDate())
GO
