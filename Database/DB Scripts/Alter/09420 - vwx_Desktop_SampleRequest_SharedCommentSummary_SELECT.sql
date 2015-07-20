IF OBJECT_ID(N'[dbo].[vwx_Desktop_SampleRequest_SharedCommentSummary_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Desktop_SampleRequest_SharedCommentSummary_SELECT]
GO

CREATE VIEW [dbo].[vwx_Desktop_SampleRequest_SharedCommentSummary_SELECT]
AS
--SELECT * FROM vwx_Desktop_SampleRequest_SharedCommentSummary_SELECT

/* Not BOM sample requests*/
SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(i.ImageID, i.[Version], '200')) AS FilePath
	, tp.TradePartnerName AS AgentName
	, tpv.VendorName
	, tpv.TradePartnerID
	, tpv.TradePartnerVendorID
	, sh.StyleNo
	, sh.StyleID
	, sh.Description AS StyleDescription
	, COALESCE(sccl.Custom, sh.SizeClass) AS SizeClass
	, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
	, LOWER(sh.StyleCategory) AS StyleCategory
	, (CASE	WHEN ISNULL(sc.StyleColorName, '') = '' THEN 'NA' ELSE sc.StyleColorName END) AS StyleColorway
	, sc.StyleColorID as StyleColorID	
	, (CASE srs.StyleSet
		WHEN 1 THEN ISNULL(sh.Pc1, CAST(srs.StyleSet AS nVARCHAR(1)) + 'st Set')
		WHEN 2 THEN ISNULL(sh.Pc2, CAST(srs.StyleSet AS nVARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(sh.Pc3, CAST(srs.StyleSet AS nVARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(sh.Pc4, CAST(srs.StyleSet AS nVARCHAR(1)) + 'th Set')
	  END) AS StyleSetName
	, srs.StyleSet
	, sw.SampleWorkflow
	, src.SampleSubmit AS Submit
	, src.SampleRequestComment AS Comment
	, src.MUser
	, src.MDate
	, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = src.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
	, 0 as isBOM
	, '00000000-0000-0000-0000-000000000000' as ItemDim1Id
	, '00000000-0000-0000-0000-000000000000' as ItemDim2Id
	, '00000000-0000-0000-0000-000000000000' as ItemDim3Id
	, srs.SampleRequestTradeID
	, srs.SampleRequestWorkflowID
	, sw.SampleWorkflowID	
FROM uTradePartner tp
INNER JOIN uTradePartnerVendor tpv ON tp.TradePartnerID = tpv.TradePartnerID
INNER JOIN pSampleRequestSubmit srs ON tpv.TradePartnerVendorID = srs.TradePartnerVendorID
INNER JOIN pStyleHeader sh ON srs.StyleID = sh.StyleID
LEFT JOIN pSizeClass sccl ON sccl.CustomID = sh.SizeClassId
INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowID = sw.SampleWorkflowID
INNER JOIN pSampleRequestTrade srt ON tpv.TradePartnerID = srt.TradePartnerID AND 
									  tpv.TradePartnerVendorID = srt.TradePartnerVendorID AND 
									  srs.SampleRequestTradeID = srt.SampleRequestTradeID AND 
									  srs.StyleColorID = srt.StyleColorID AND 
									  sh.StyleID = srt.StyleID AND 
									  srt.SampleRequestShare = 1
LEFT OUTER JOIN pStyleColorway sc ON srs.StyleID = sc.StyleID AND 
									 srs.StyleColorID = sc.StyleColorID
INNER JOIN pSampleRequestComment src ON srs.SampleRequestTradeID = src.SampleRequestTradeID AND 
									    srs.SampleRequestWorkflowID = src.SampleRequestWorkflowID AND 
										srs.StyleID = src.StyleID AND 
										srs.Submit = src.SampleSubmit AND 
										srs.StyleSet = src.StyleSet AND 
										src.SampleCommentType = 'S'
LEFT OUTER JOIN hImage i ON sh.DesignSketchID = i.ImageID AND sh.DesignSketchVersion = i.Version
UNION
/* BOM sample requests*/
SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePathChangeLogReport(i.ImageID, i.[Version], '200')) AS FilePath
	, tp.TradePartnerName AS AgentName
	, tpv.VendorName
	, tpv.TradePartnerID
	, tpv.TradePartnerVendorID
	, sh.StyleNo, sh.StyleID
	, sh.Description AS StyleDescription
	, COALESCE(sccl.Custom, sh.SizeClass) AS SizeClass
	, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
	, LOWER(sh.StyleCategory) AS StyleCategory
	, (CASE WHEN ISNULL(sc.StyleColorName, '') = '' THEN 'NA' ELSE sc.StyleColorName END) AS StyleColorway
	, '00000000-0000-0000-0000-000000000000' as StyleColorID
	, (CASE srsb.StyleSet 
		WHEN 1 THEN ISNULL(sh.Pc1, CAST(srsb.StyleSet AS nVARCHAR(1)) + 'st Set') 
		WHEN 2 THEN ISNULL(sh.Pc2, CAST(srsb.StyleSet AS nVARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(sh.Pc3, CAST(srsb.StyleSet AS nVARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(sh.Pc4, CAST(srsb.StyleSet AS nVARCHAR(1)) + 'th Set')
	   END) AS StyleSetName
	, srsb.StyleSet
	, sw.SampleWorkflow
	, src.SampleSubmit AS Submit
	, src.SampleRequestComment AS Comment
	, src.MUser
	, src.MDate
	, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = src.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
	, 1 as isBOM
	, srsb.ItemDim1Id
	, srsb.ItemDim2Id
	, srsb.ItemDim3Id
	, srsb.SampleRequestTradeID
	, srsb.SampleRequestWorkflowID
	, sw.SampleWorkflowID
FROM uTradePartner tp
INNER JOIN uTradePartnerVendor tpv ON tp.TradePartnerID = tpv.TradePartnerID
INNER JOIN pSampleRequestSubmitBOM srsb ON tpv.TradePartnerVendorID = srsb.TradePartnerVendorID
INNER JOIN pStyleHeader sh ON srsb.StyleID = sh.StyleID
LEFT JOIN pSizeClass sccl ON sccl.CustomID = sh.SizeClassId
INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
INNER JOIN pSampleWorkflow sw ON srsb.SampleWorkflowID = sw.SampleWorkflowID
INNER JOIN pSampleRequestBOMTrade srbt ON tpv.TradePartnerID = srbt.TradePartnerID AND 
										  tpv.TradePartnerVendorID = srbt.TradePartnerVendorID AND 
										  srsb.SampleRequestTradeID = srbt.SampleRequestTradeID AND 
										  srsb.ItemDim1Id = srbt.ItemDim1Id AND 
										  srsb.ItemDim2Id = srbt.ItemDim2Id AND 
										  srsb.ItemDim3Id = srbt.ItemDim3Id	AND 
										  sh.StyleID = srbt.StyleID AND 
										  srbt.SampleRequestShare = 1
LEFT OUTER JOIN pStyleColorway sc ON srbt.ItemDim1Id = sc.StyleColorID OR 
									 srbt.ItemDim2Id = sc.StyleColorID OR 
									 srbt.ItemDim3Id = sc.StyleColorID
INNER JOIN pSampleRequestComment src ON srsb.SampleRequestTradeID = src.SampleRequestTradeID AND 
										srsb.SampleRequestWorkflowID = src.SampleRequestWorkflowID AND 
										srsb.StyleID = src.StyleID AND 
										srsb.Submit = src.SampleSubmit AND 
										srsb.StyleSet = src.StyleSet AND 
										src.SampleCommentType = 'S'
LEFT OUTER JOIN hImage i ON sh.DesignSketchID = i.ImageID AND sh.DesignSketchVersion = i.Version


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09420', GetDate())
GO
