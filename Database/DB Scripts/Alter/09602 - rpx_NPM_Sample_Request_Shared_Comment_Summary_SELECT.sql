IF OBJECT_ID(N'[dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_SELECT]
	@TradePartnerID nVARCHAR(MAX)
	, @CUser nVARCHAR(MAX)
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
	, sh.StyleNo, sh.StyleID
	, sh.Description AS StyleDescription
	, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
	, LOWER(sh.StyleCategory) AS StyleCategory
	, (CASE	WHEN ISNULL(pStyleColorway.StyleColorName, '') = '' THEN 'NA' ELSE pStyleColorway.StyleColorName END) AS StyleColorway
	, pStyleColorway.StyleColorID as StyleColorID	
	, (CASE pSampleRequestSubmit.StyleSet 
		WHEN 1 THEN ISNULL(sh.Pc1, CAST(pSampleRequestSubmit.StyleSet AS nVARCHAR(1)) + 'st Set') 
		WHEN 2 THEN ISNULL(sh.Pc2, CAST(pSampleRequestSubmit.StyleSet AS nVARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(sh.Pc3, CAST(pSampleRequestSubmit.StyleSet AS nVARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(sh.Pc4, CAST(pSampleRequestSubmit.StyleSet AS nVARCHAR(1)) + 'th Set')
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
	, NULL as BOMName
FROM pSampleRequestTrade
	INNER JOIN pSampleRequestSubmit ON pSampleRequestTrade.SampleRequestTradeID = pSampleRequestSubmit.SampleRequestTradeID
	INNER JOIN pStyleHeader sh ON pSampleRequestSubmit.StyleID = sh.StyleID
	INNER JOIN pStyleDevelopmentItem ON sh.StyleID = pStyleDevelopmentItem.StyleID
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
	LEFT OUTER JOIN hImage ON sh.DesignSketchID = hImage.ImageID
		AND sh.DesignSketchVersion = hImage.Version
    LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE 
	(tprl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')))
	AND pSampleRequestComment.CTeamID IN (SELECT value FROM dbo.fnx_Split(@CUser, ','))

UNION 

SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(hImage.ImageID, hImage.[Version], '200')) AS FilePath
	, pSampleRequestBOMTrade.TradePartnerID
	, tprl.AgentID
	, tprl.VendorID
	, tprl.FactoryID
	, tprl.TradePartnerRelationshipLevelID
	, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, ''), 2,1000) AS PartnerName
	, sh.StyleNo, sh.StyleID
	, sh.Description AS StyleDescription
	, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
	, LOWER(sh.StyleCategory) AS StyleCategory
	, (CASE WHEN ISNULL(pStyleColorway.StyleColorName, '') = '' THEN 'NA' ELSE pStyleColorway.StyleColorName END) AS StyleColorway
	, '00000000-0000-0000-0000-000000000000' as StyleColorID
	, (CASE pSampleRequestSubmitBOM.StyleSet 
		WHEN 1 THEN ISNULL(sh.Pc1, CAST(pSampleRequestSubmitBOM.StyleSet AS nVARCHAR(1)) + 'st Set') 
		WHEN 2 THEN ISNULL(sh.Pc2, CAST(pSampleRequestSubmitBOM.StyleSet AS nVARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(sh.Pc3, CAST(pSampleRequestSubmitBOM.StyleSet AS nVARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(sh.Pc4, CAST(pSampleRequestSubmitBOM.StyleSet AS nVARCHAR(1)) + 'th Set')
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
	, pWorkFlowItem.WorkFlowItemName AS BOMName
FROM pSampleRequestBOMTrade
	INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestSubmitBOM.SampleRequestTradeID
	INNER JOIN pStyleHeader sh ON pSampleRequestSubmitBOM.StyleID = sh.StyleID
	INNER JOIN pStyleDevelopmentItem ON sh.StyleID = pStyleDevelopmentItem.StyleID
	INNER JOIN pSampleWorkflow ON pSampleRequestSubmitBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pSampleRequestBOMTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	LEFT OUTER JOIN pStyleColorway ON pSampleRequestBOMTrade.ItemDim1Id = pStyleColorway.StyleColorID
		OR pSampleRequestBOMTrade.ItemDim2Id = pStyleColorway.StyleColorID
		OR pSampleRequestBOMTrade.ItemDim3Id = pStyleColorway.StyleColorID
	INNER JOIN pSampleRequestComment ON pSampleRequestSubmitBOM.SampleRequestTradeID = pSampleRequestComment.SampleRequestTradeID
		AND pSampleRequestSubmitBOM.SampleRequestWorkflowID = pSampleRequestComment.SampleRequestWorkflowID
		AND pSampleRequestSubmitBOM.StyleID = pSampleRequestComment.StyleID
		AND pSampleRequestSubmitBOM.Submit = pSampleRequestComment.SampleSubmit
		AND pSampleRequestSubmitBOM.StyleSet = pSampleRequestComment.StyleSet
		AND pSampleRequestComment.SampleCommentType = 'S'
	LEFT OUTER JOIN hImage ON sh.DesignSketchID = hImage.ImageID
		AND sh.DesignSketchVersion = hImage.Version
	LEFT OUTER JOIN pWorkFlowItem ON pSampleRequestBOMTrade.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
    LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE 
	(tprl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')))
	AND pSampleRequestComment.CTeamID IN (SELECT value FROM dbo.fnx_Split(@CUser, ','))

ORDER BY 
	StyleNo
	, PartnerName
	, Submit DESC
	, MDate DESC
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09602', GetDate())
GO
