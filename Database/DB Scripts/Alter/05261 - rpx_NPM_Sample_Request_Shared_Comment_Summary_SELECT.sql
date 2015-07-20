IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_SELECT]
	@TradePartnerID VARCHAR(MAX)
AS
BEGIN
	SET @TradePartnerID = REPLACE(@TradePartnerID, ' ', '')

SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(hImage.ImageID, hImage.[Version], '200')) AS FilePath
	, pSampleRequestTrade.TradePartnerID
	, tprl.AgentID
	, tprl.VendorID
	, tprl.FactoryID
	, tprl.TradePartnerRelationshipLevelID
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, ''), 2,1000) AS PartnerName
	, pStyleHeader.StyleNo, pStyleHeader.StyleID
	, pStyleHeader.Description AS StyleDescription
	, pStyleHeader.SizeClass
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName
	, LOWER(pStyleHeader.StyleCategory) AS StyleCategory
	, (CASE	WHEN ISNULL(pStyleColorway.StyleColorName, '') = '' THEN 'NA' ELSE pStyleColorway.StyleColorName END) AS StyleColorway
	, pStyleColorway.StyleColorID as StyleColorID	
	, (CASE pSampleRequestSubmit.StyleSet 
		WHEN 1 THEN ISNULL(pStyleHeader.Pc1, CAST(pSampleRequestSubmit.StyleSet AS VARCHAR(1)) + 'st Set') 
		WHEN 2 THEN ISNULL(pStyleHeader.Pc2, CAST(pSampleRequestSubmit.StyleSet AS VARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(pStyleHeader.Pc3, CAST(pSampleRequestSubmit.StyleSet AS VARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(pStyleHeader.Pc4, CAST(pSampleRequestSubmit.StyleSet AS VARCHAR(1)) + 'th Set')
	   END) AS StyleSetName
	, pSampleRequestSubmit.StyleSet
	, pSampleWorkflow.SampleWorkflow
	, pSampleRequestComment.SampleSubmit AS Submit
	, pSampleRequestComment.SampleRequestComment AS Comment
	, pSampleRequestComment.MUser
	, pSampleRequestComment.MDate
	, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = pSampleRequestComment.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
	, 0 as isBOM
	, '00000000-0000-0000-0000-000000000000' as ItemDim1Id
	, '00000000-0000-0000-0000-000000000000' as ItemDim2Id
	, '00000000-0000-0000-0000-000000000000' as ItemDim3Id
	, pSampleRequestSubmit.SampleRequestTradeID
	, pSampleRequestSubmit.SampleRequestWorkflowID
	, pSampleWorkflow.SampleWorkflowID
FROM pSampleRequestTrade
	INNER JOIN pSampleRequestSubmit ON pSampleRequestTrade.SampleRequestTradeID = pSampleRequestSubmit.SampleRequestTradeID
	INNER JOIN pStyleHeader ON pSampleRequestSubmit.StyleID = pStyleHeader.StyleID
	INNER JOIN pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
	INNER JOIN pSampleWorkflow ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pSampleRequestTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	LEFT OUTER JOIN pStyleColorway ON pSampleRequestSubmit.StyleID = pStyleColorway.StyleID
		AND pSampleRequestSubmit.StyleColorID = pStyleColorway.StyleColorID
	INNER JOIN pSampleRequestComment ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestComment.SampleRequestTradeID
		AND pSampleRequestSubmit.SampleRequestWorkflowID = pSampleRequestComment.SampleRequestWorkflowID
		AND pSampleRequestSubmit.StyleID = pSampleRequestComment.StyleID
		AND pSampleRequestSubmit.Submit = pSampleRequestComment.SampleSubmit
		AND pSampleRequestSubmit.StyleSet = pSampleRequestComment.StyleSet
		AND pSampleRequestComment.SampleCommentType = 'S'
	LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID
		AND pStyleHeader.DesignSketchVersion = hImage.Version
WHERE 
	tprl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')) 

UNION 

SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(hImage.ImageID, hImage.[Version], '200')) AS FilePath
	, pSampleRequestBOMTrade.TradePartnerID
	, tprl.AgentID
	, tprl.VendorID
	, tprl.FactoryID
	, tprl.TradePartnerRelationshipLevelID
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, ''), 2,1000) AS PartnerName
	, pStyleHeader.StyleNo, pStyleHeader.StyleID
	, pStyleHeader.Description AS StyleDescription
	, pStyleHeader.SizeClass
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName
	, LOWER(pStyleHeader.StyleCategory) AS StyleCategory
	, (CASE WHEN ISNULL(pColorPalette.ColorName, '') = '' THEN 'NA' ELSE pColorPalette.ColorName END)AS StyleColorway
	, '00000000-0000-0000-0000-000000000000' as StyleColorID
	, (CASE pSampleRequestSubmitBOM.StyleSet 
		WHEN 1 THEN ISNULL(pStyleHeader.Pc1, CAST(pSampleRequestSubmitBOM.StyleSet AS VARCHAR(1)) + 'st Set') 
		WHEN 2 THEN ISNULL(pStyleHeader.Pc2, CAST(pSampleRequestSubmitBOM.StyleSet AS VARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(pStyleHeader.Pc3, CAST(pSampleRequestSubmitBOM.StyleSet AS VARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(pStyleHeader.Pc4, CAST(pSampleRequestSubmitBOM.StyleSet AS VARCHAR(1)) + 'th Set')
	   END) AS StyleSetName
	, pSampleRequestSubmitBOM.StyleSet
	, pSampleWorkflow.SampleWorkflow
	, pSampleRequestComment.SampleSubmit AS Submit
	, pSampleRequestComment.SampleRequestComment AS Comment
	, pSampleRequestComment.MUser
	, pSampleRequestComment.MDate
	, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = pSampleRequestComment.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
	, 1 as isBOM
	, pSampleRequestSubmitBOM.ItemDim1Id
	, pSampleRequestSubmitBOM.ItemDim2Id
	, pSampleRequestSubmitBOM.ItemDim3Id
	, pSampleRequestSubmitBOM.SampleRequestTradeID
	, pSampleRequestSubmitBOM.SampleRequestWorkflowID
	, pSampleWorkflow.SampleWorkflowID
FROM pSampleRequestBOMTrade
	INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestSubmitBOM.SampleRequestTradeID
	INNER JOIN pStyleHeader ON pSampleRequestSubmitBOM.StyleID = pStyleHeader.StyleID
	INNER JOIN pStyleDevelopmentItem ON pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
	INNER JOIN pSampleWorkflow ON pSampleRequestSubmitBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pSampleRequestBOMTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	LEFT OUTER JOIN pColorPalette ON pSampleRequestBOMTrade.ItemDim1Id = pColorPalette.ColorPaletteID
		OR pSampleRequestBOMTrade.ItemDim2Id = pColorPalette.ColorPaletteID
		OR pSampleRequestBOMTrade.ItemDim3Id = pColorPalette.ColorPaletteID
	INNER JOIN pSampleRequestComment ON pSampleRequestSubmitBOM.SampleRequestTradeID = pSampleRequestComment.SampleRequestTradeID
		AND pSampleRequestSubmitBOM.SampleRequestWorkflowID = pSampleRequestComment.SampleRequestWorkflowID
		AND pSampleRequestSubmitBOM.StyleID = pSampleRequestComment.StyleID
		AND pSampleRequestSubmitBOM.Submit = pSampleRequestComment.SampleSubmit
		AND pSampleRequestSubmitBOM.StyleSet = pSampleRequestComment.StyleSet
		AND pSampleRequestComment.SampleCommentType = 'S'
	LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID
		AND pStyleHeader.DesignSketchVersion = hImage.Version
WHERE 
	tprl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')) 

ORDER BY 
	StyleNo
	, PartnerName
	, Submit DESC
	, MDate DESC
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05261', GetDate())
GO
