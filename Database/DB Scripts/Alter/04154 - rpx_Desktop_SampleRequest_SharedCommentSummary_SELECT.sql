IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]

AS

BEGIN
SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(hImage.ImageID, hImage.[Version], '200')) AS FilePath
	, uTradePartner.TradePartnerName AS AgentName
	, uTradePartnerVendor.VendorName
	, uTradePartnerVendor.TradePartnerID
	, uTradePartnerVendor.TradePartnerVendorID
	, pStyleHeader.StyleNo
	, pStyleHeader.StyleID	
	, pStyleHeader.Description AS StyleDescription
	, pStyleHeader.SizeClass
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName 
	, LOWER(pStyleHeader.StyleCategory) as StyleCategory
	, (CASE
		WHEN ISNULL(pStyleColorway.StyleColorName, '') = '' THEN 'NA'
		ELSE pStyleColorway.StyleColorName
	  END) AS StyleColorway
	, (CASE pSampleRequestSubmit.StyleSet
		WHEN 1 THEN ISNULL(pStyleHeader.Pc1,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'st Set')
		WHEN 2 THEN ISNULL(pStyleHeader.Pc2,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(pStyleHeader.Pc3,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(pStyleHeader.Pc4,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'th Set')
	  END) as StyleSetName
	, pSampleWorkflow.SampleWorkflow
	, pSampleRequestComment.SampleSubmit AS Submit
	, pSampleRequestComment.SampleRequestComment AS Comment
	, pSampleRequestComment.MUser
	, pSampleRequestComment.MDate
	, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = pSampleRequestComment.CTeamID) THEN 0 ELSE 1 END as IsSrmOn
FROM uTradePartner
INNER JOIN uTradePartnerVendor ON uTradePartner.TradePartnerID = uTradePartnerVendor.TradePartnerID
INNER JOIN pSampleRequestSubmit ON uTradePartnerVendor.TradePartnerVendorID = pSampleRequestSubmit.TradePartnerVendorID
INNER JOIN pStyleHeader ON pSampleRequestSubmit.StyleID = pStyleHeader.StyleID
INNER JOIN pStyleDevelopmentItem ON	pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
INNER JOIN pSampleWorkflow ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
INNER JOIN pSampleRequestTrade ON uTradePartnerVendor.TradePartnerID = pSampleRequestTrade.TradePartnerID
	AND uTradePartnerVendor.TradePartnerVendorID = pSampleRequestTrade.TradePartnerVendorID
	AND pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
	AND pSampleRequestSubmit.StyleColorID = pSampleRequestTrade.StyleColorID
	AND pStyleHeader.StyleID = pSampleRequestTrade.StyleID
	AND pSampleRequestTrade.SampleRequestShare = 1
LEFT OUTER JOIN pStyleColorway ON	pSampleRequestSubmit.StyleID = pStyleColorway.StyleID
	AND pSampleRequestSubmit.StyleColorID = pStyleColorway.StyleColorID
INNER JOIN pSampleRequestComment ON	pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestComment.SampleRequestTradeID
	AND pSampleRequestSubmit.SampleRequestWorkflowID = pSampleRequestComment.SampleRequestWorkflowID
	AND pSampleRequestSubmit.StyleID = pSampleRequestComment.StyleID
	AND pSampleRequestSubmit.Submit = pSampleRequestComment.SampleSubmit
	AND pSampleRequestSubmit.StyleSet = pSampleRequestComment.StyleSet
	AND pSampleRequestComment.SampleCommentType = 'S'
LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID
	AND pStyleHeader.DesignSketchVersion = hImage.Version										
UNION
-- BOM sample requests
SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(hImage.ImageID, hImage.[Version], '200')) AS FilePath
	, uTradePartner.TradePartnerName AS AgentName
	, uTradePartnerVendor.VendorName
	, uTradePartnerVendor.TradePartnerID
	, uTradePartnerVendor.TradePartnerVendorID
	, pStyleHeader.StyleNo
	, pStyleHeader.StyleID
	, pStyleHeader.Description AS StyleDescription
	, pStyleHeader.SizeClass
	, ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName 
	, LOWER(pStyleHeader.StyleCategory) as StyleCategory
	, (CASE
		WHEN ISNULL(pColorPalette.ColorName, '') = '' THEN 'NA'
		ELSE pColorPalette.ColorName
	  END) AS StyleColorway		
	, (CASE pSampleRequestSubmitBOM.StyleSet
		WHEN 1 THEN ISNULL(pStyleHeader.Pc1,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'st Set')
		WHEN 2 THEN ISNULL(pStyleHeader.Pc2,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(pStyleHeader.Pc3,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(pStyleHeader.Pc4,CAST(pStyleHeader.StyleSet AS VARCHAR(1)) + 'th Set')
	  END) as StyleSetName
	, pSampleWorkflow.SampleWorkflow
	, pSampleRequestComment.SampleSubmit AS Submit
	, pSampleRequestComment.SampleRequestComment AS Comment
	, pSampleRequestComment.MUser
	, pSampleRequestComment.MDate
	, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = pSampleRequestComment.CTeamID) THEN 0 ELSE 1 END as IsSrmOn
FROM uTradePartner
INNER JOIN uTradePartnerVendor ON uTradePartner.TradePartnerID = uTradePartnerVendor.TradePartnerID
INNER JOIN pSampleRequestSubmitBOM ON uTradePartnerVendor.TradePartnerVendorID = pSampleRequestSubmitBOM.TradePartnerVendorID		--Comment #01
INNER JOIN pStyleHeader ON pSampleRequestSubmitBOM.StyleID = pStyleHeader.StyleID
INNER JOIN pStyleDevelopmentItem ON	pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
INNER JOIN pSampleWorkflow ON pSampleRequestSubmitBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
INNER JOIN pSampleRequestBOMTrade ON uTradePartnerVendor.TradePartnerID = pSampleRequestBOMTrade.TradePartnerID
	AND uTradePartnerVendor.TradePartnerVendorID = pSampleRequestBOMTrade.TradePartnerVendorID
	AND pSampleRequestSubmitBOM.SampleRequestTradeID = pSampleRequestBOMTrade.SampleRequestTradeID
	AND pSampleRequestSubmitBOM.ItemDim1Id = pSampleRequestBOMTrade.ItemDim1Id
	AND pSampleRequestSubmitBOM.ItemDim2Id = pSampleRequestBOMTrade.ItemDim2Id
	AND pSampleRequestSubmitBOM.ItemDim3Id = pSampleRequestBOMTrade.ItemDim3Id
	AND pStyleHeader.StyleID = pSampleRequestBOMTrade.StyleID
	AND pSampleRequestBOMTrade.SampleRequestShare = 1
LEFT OUTER JOIN pColorPalette ON	pSampleRequestBOMTrade.ItemDim1Id = pColorPalette.ColorPaletteID
	OR pSampleRequestBOMTrade.ItemDim2Id = pColorPalette.ColorPaletteID
	OR pSampleRequestBOMTrade.ItemDim3Id = pColorPalette.ColorPaletteID
INNER JOIN pSampleRequestComment ON	pSampleRequestSubmitBOM.SampleRequestTradeID = pSampleRequestComment.SampleRequestTradeID
	AND pSampleRequestSubmitBOM.SampleRequestWorkflowID = pSampleRequestComment.SampleRequestWorkflowID
	AND pSampleRequestSubmitBOM.StyleID = pSampleRequestComment.StyleID
	AND pSampleRequestSubmitBOM.Submit = pSampleRequestComment.SampleSubmit
	AND pSampleRequestSubmitBOM.StyleSet = pSampleRequestComment.StyleSet
	AND pSampleRequestComment.SampleCommentType = 'S'
LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID
	AND pStyleHeader.DesignSketchVersion = hImage.Version										
ORDER BY
	pStyleHeader.StyleNo
	, uTradePartner.TradePartnerName
	, uTradePartnerVendor.VendorName
	, pSampleRequestComment.SampleSubmit DESC
	, pSampleRequestComment.MDate DESC
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04154', GetDate())
GO