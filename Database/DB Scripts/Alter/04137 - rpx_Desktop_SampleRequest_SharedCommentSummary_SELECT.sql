/****** Object:  StoredProcedure [dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]    Script Date: 10/10/2012 16:37:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]    Script Date: 10/10/2012 16:37:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/*
Comments:

General - Ryan Cabanas - August 12, 2009
	Agent Sample Shared Comments report.

#01 - Ryan Cabanas - August 21, 2009
	Because of some 'pSampleRequestSubmit' records being bad and
having a 'TradePartnerID' value of NULL, the INNER JOIN might not
pull in some records.  To get around this, I'm going to have to do
an INNER JOIN for the 'pSampleRequestSubmit' table using only the
'TradePartnerVendorID' field.

#02 - Ryan Cabanas - August 21, 2009
	Having a problem with the date range constrictions.  Need to
use only the "MDate" for both search limits.  Don't use "CDate"
at all.
*/


CREATE PROCEDURE [dbo].[rpx_Desktop_SampleRequest_SharedCommentSummary_SELECT]
(
	@TradePartnerID nvarchar(200)
	,@BeginDateString nvarchar(100)
	,@EndDateString nvarchar(100)
)
AS


--/************/
--/*Testing.	*/
--/************/
--BEGIN
--	DECLARE @TradePartnerID nvarchar(200)
--	DECLARE @BeginDateString nvarchar(100)
--	DECLARE @EndDateString nvarchar(100)
--
--	SET @TradePartnerID = 'BB0C2BDD-EA84-4479-8075-618EC07C41B0'
--	SET @BeginDateString = '2009-08-20'
--	SET @EndDateString = '2009-08-20'
--END


/************************/
/*Format parameters.	*/
/************************/
BEGIN
	IF(@TradePartnerID IS NULL OR @TradePartnerID = '00000000-0000-0000-0000-000000000000')
		BEGIN
			SET @TradePartnerID = '99999999-9999-9999-9999-999999999999'
		END	

	IF(@BeginDateString = '' OR @BeginDateString IS NULL)
		BEGIN
			SET @BeginDateString = '1900-01-01 00:00:00.000'
		END
	ELSE
		BEGIN
			SET @BeginDateString = @BeginDateString + ' 00:00:00.000'
		END

	IF(@EndDateString = '' OR @EndDateString IS NULL)
		BEGIN
			SET @EndDateString = '3000-12-31 23:59:59.999'
		END
	ELSE
		BEGIN
			SET @EndDateString = @EndDateString + ' 23:59:59.999'
		END
END


/********************/
/*Select statement.	*/
/********************/

-- not BOM sample requests
SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
	 ) AS FilePath,
	uTradePartner.TradePartnerName AS AgentName
	,uTradePartnerVendor.VendorName
	,uTradePartnerVendor.TradePartnerID
	,uTradePartnerVendor.TradePartnerVendorID
	,pStyleHeader.StyleNo
	,pStyleHeader.Description AS StyleDescription
	,pStyleHeader.SizeClass
	,ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName 
	,LOWER(pStyleHeader.StyleCategory) as StyleCategory
--	,pSampleRequestSubmit.SampleRequestTradeID
--	,pSampleRequestSubmit.StyleSet
	,CASE
		WHEN	(pStyleColorway.StyleColorName = ''
				OR pStyleColorway.StyleColorName IS NULL)	THEN	'NA'
		ELSE	pStyleColorway.StyleColorName
	END AS StyleColorway
	,CASE
		WHEN	pSampleRequestSubmit.StyleSet = 1
				AND (pStyleHeader.PC1 IS NULL
					OR pStyleHeader.PC1 = '')		THEN	'1st Set'
		WHEN	pSampleRequestSubmit.StyleSet = 1
				AND (pStyleHeader.PC1 IS NOT NULL
					AND pStyleHeader.PC1 <> '')		THEN	pStyleHeader.PC1
		WHEN	pSampleRequestSubmit.StyleSet = 2
				AND (pStyleHeader.PC2 IS NULL
					OR pStyleHeader.PC2 = '')		THEN	'2nd Set'
		WHEN	pSampleRequestSubmit.StyleSet = 2
				AND (pStyleHeader.PC2 IS NOT NULL
					AND pStyleHeader.PC2 <> '')		THEN	pStyleHeader.PC2
		WHEN	pSampleRequestSubmit.StyleSet = 3
				AND (pStyleHeader.PC3 IS NULL
					OR pStyleHeader.PC3 = '')		THEN	'3rd Set'
		WHEN	pSampleRequestSubmit.StyleSet = 3
				AND (pStyleHeader.PC3 IS NOT NULL
					AND pStyleHeader.PC3 <> '')		THEN	pStyleHeader.PC3
		WHEN	pSampleRequestSubmit.StyleSet = 4
				AND (pStyleHeader.PC4 IS NULL
					OR pStyleHeader.PC4 = '')		THEN	'4th Set'
		ELSE												pStyleHeader.PC4
	END AS StyleSetName
--	,pSampleRequestSubmit.SampleWorkflowID
	,pSampleWorkflow.SampleWorkflow
	,pSampleRequestComment.SampleSubmit AS Submit
	,pSampleRequestComment.SampleRequestComment AS Comment
	,pSampleRequestComment.MUser
	,pSampleRequestComment.MDate
	,@TradePartnerID AS TradePartnerParamID
	,@BeginDateString AS BeginDateString
	,@EndDateString AS EndDateString,
	CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = pSampleRequestComment.CTeamID) THEN 0 ELSE 1 END as IsSrmOn
FROM uTradePartner
	INNER JOIN uTradePartnerVendor ON	uTradePartner.TradePartnerID = uTradePartnerVendor.TradePartnerID
	INNER JOIN pSampleRequestSubmit ON	/*uTradePartnerVendor.TradePartnerID = pSampleRequestSubmit.TradePartnerID		--Comment #01
											AND*/ uTradePartnerVendor.TradePartnerVendorID = pSampleRequestSubmit.TradePartnerVendorID		--Comment #01
	INNER JOIN pStyleHeader ON	pSampleRequestSubmit.StyleID = pStyleHeader.StyleID
	INNER JOIN pStyleDevelopmentItem ON	pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
	INNER JOIN pSampleWorkflow ON	pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN pSampleRequestTrade ON	uTradePartnerVendor.TradePartnerID = pSampleRequestTrade.TradePartnerID
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
	LEFT OUTER JOIN hImage ON	pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version										
WHERE (uTradePartner.TradePartnerID = @TradePartnerID
		OR @TradePartnerID = '99999999-9999-9999-9999-999999999999')
	AND pSampleRequestComment.MDate >= CAST(@BeginDateString AS datetime)	--Comment #02
	AND pSampleRequestComment.MDate <= CAST(@EndDateString AS datetime)


UNION


-- BOM sample requests
SELECT
	(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
	 ) AS FilePath,
	uTradePartner.TradePartnerName AS AgentName
	,uTradePartnerVendor.VendorName
	,uTradePartnerVendor.TradePartnerID
	,uTradePartnerVendor.TradePartnerVendorID
	,pStyleHeader.StyleNo
	,pStyleHeader.Description AS StyleDescription
	,pStyleHeader.SizeClass
	,ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, 'Variation ' + CAST(pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName 
	,LOWER(pStyleHeader.StyleCategory) as StyleCategory
--	,pSampleRequestSubmit.SampleRequestTradeID
--	,pSampleRequestSubmit.StyleSet
	,CASE
		WHEN	(pColorPalette.ColorName = ''
				OR pColorPalette.ColorPaletteID IS NULL)	THEN	'NA'
		ELSE	pColorPalette.ColorName
	END AS StyleColorway
	,CASE
		WHEN	pSampleRequestSubmitBOM.StyleSet = 1
				AND (pStyleHeader.PC1 IS NULL
					OR pStyleHeader.PC1 = '')		THEN	'1st Set'
		WHEN	pSampleRequestSubmitBOM.StyleSet = 1
				AND (pStyleHeader.PC1 IS NOT NULL
					AND pStyleHeader.PC1 <> '')		THEN	pStyleHeader.PC1
		WHEN	pSampleRequestSubmitBOM.StyleSet = 2
				AND (pStyleHeader.PC2 IS NULL
					OR pStyleHeader.PC2 = '')		THEN	'2nd Set'
		WHEN	pSampleRequestSubmitBOM.StyleSet = 2
				AND (pStyleHeader.PC2 IS NOT NULL
					AND pStyleHeader.PC2 <> '')		THEN	pStyleHeader.PC2
		WHEN	pSampleRequestSubmitBOM.StyleSet = 3
				AND (pStyleHeader.PC3 IS NULL
					OR pStyleHeader.PC3 = '')		THEN	'3rd Set'
		WHEN	pSampleRequestSubmitBOM.StyleSet = 3
				AND (pStyleHeader.PC3 IS NOT NULL
					AND pStyleHeader.PC3 <> '')		THEN	pStyleHeader.PC3
		WHEN	pSampleRequestSubmitBOM.StyleSet = 4
				AND (pStyleHeader.PC4 IS NULL
					OR pStyleHeader.PC4 = '')		THEN	'4th Set'
		ELSE												pStyleHeader.PC4
	END AS StyleSetName
--	,pSampleRequestSubmit.SampleWorkflowID
	,pSampleWorkflow.SampleWorkflow
	,pSampleRequestComment.SampleSubmit AS Submit
	,pSampleRequestComment.SampleRequestComment AS Comment
	,pSampleRequestComment.MUser
	,pSampleRequestComment.MDate
	,@TradePartnerID AS TradePartnerParamID
	,@BeginDateString AS BeginDateString
	,@EndDateString AS EndDateString,
	CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = pSampleRequestComment.CTeamID) THEN 0 ELSE 1 END as IsSrmOn
FROM uTradePartner
	INNER JOIN uTradePartnerVendor ON	uTradePartner.TradePartnerID = uTradePartnerVendor.TradePartnerID
	INNER JOIN pSampleRequestSubmitBOM ON	/*uTradePartnerVendor.TradePartnerID = pSampleRequestSubmit.TradePartnerID		--Comment #01
											AND*/ uTradePartnerVendor.TradePartnerVendorID = pSampleRequestSubmitBOM.TradePartnerVendorID		--Comment #01
	INNER JOIN pStyleHeader ON	pSampleRequestSubmitBOM.StyleID = pStyleHeader.StyleID
	INNER JOIN pStyleDevelopmentItem ON	pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID
	INNER JOIN pSampleWorkflow ON	pSampleRequestSubmitBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN pSampleRequestBOMTrade ON	uTradePartnerVendor.TradePartnerID = pSampleRequestBOMTrade.TradePartnerID
										AND uTradePartnerVendor.TradePartnerVendorID = pSampleRequestBOMTrade.TradePartnerVendorID
										AND pSampleRequestSubmitBOM.SampleRequestTradeID = pSampleRequestBOMTrade.SampleRequestTradeID
										AND pSampleRequestSubmitBOM.ItemDim1Id = pSampleRequestBOMTrade.ItemDim1Id
										AND pSampleRequestSubmitBOM.ItemDim2Id = pSampleRequestBOMTrade.ItemDim2Id
										AND pSampleRequestSubmitBOM.ItemDim3Id = pSampleRequestBOMTrade.ItemDim3Id
										AND pStyleHeader.StyleID = pSampleRequestBOMTrade.StyleID
										AND pSampleRequestBOMTrade.SampleRequestShare = 1
	LEFT OUTER JOIN pColorPalette ON	pSampleRequestBOMTrade.ItemDim1Id = pColorPalette.ColorPaletteID OR 
										pSampleRequestBOMTrade.ItemDim2Id = pColorPalette.ColorPaletteID OR
										pSampleRequestBOMTrade.ItemDim3Id = pColorPalette.ColorPaletteID
	INNER JOIN pSampleRequestComment ON	pSampleRequestSubmitBOM.SampleRequestTradeID = pSampleRequestComment.SampleRequestTradeID
										AND pSampleRequestSubmitBOM.SampleRequestWorkflowID = pSampleRequestComment.SampleRequestWorkflowID
										AND pSampleRequestSubmitBOM.StyleID = pSampleRequestComment.StyleID
										AND pSampleRequestSubmitBOM.Submit = pSampleRequestComment.SampleSubmit
										AND pSampleRequestSubmitBOM.StyleSet = pSampleRequestComment.StyleSet
										AND pSampleRequestComment.SampleCommentType = 'S'
	LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID AND
							  pStyleHeader.DesignSketchVersion = hImage.Version										
WHERE (uTradePartner.TradePartnerID = @TradePartnerID
		OR @TradePartnerID = '99999999-9999-9999-9999-999999999999')
	AND pSampleRequestComment.MDate >= CAST(@BeginDateString AS datetime)	--Comment #02
	AND pSampleRequestComment.MDate <= CAST(@EndDateString AS datetime)



ORDER BY
	pStyleHeader.StyleNo
	,uTradePartner.TradePartnerName
	,uTradePartnerVendor.VendorName
	--,pSampleRequestSubmit.SampleRequestTradeID
	--,pSampleRequestSubmit.StyleSet
	--,pSampleWorkflow.SampleWorkflowSort
	--,pSampleRequestSubmit.SampleWorkflowID
	,pSampleRequestComment.SampleSubmit DESC
	,pSampleRequestComment.MDate DESC


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04137', GetDate())
GO