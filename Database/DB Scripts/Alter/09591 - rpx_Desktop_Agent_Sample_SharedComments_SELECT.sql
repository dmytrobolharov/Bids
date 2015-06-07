IF OBJECT_ID(N'[dbo].[rpx_Desktop_Agent_Sample_SharedComments_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Desktop_Agent_Sample_SharedComments_SELECT]
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

CREATE PROCEDURE [dbo].[rpx_Desktop_Agent_Sample_SharedComments_SELECT]
(
	@TradePartnerID nvarchar(200)
	,@BeginDateString datetime
	,@EndDateString datetime
)
AS


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

	IF(@EndDateString = '' OR @EndDateString IS NULL)
		BEGIN
			SET @EndDateString = '3000-12-31 23:59:59.999'
		END
	ELSE
		BEGIN
			SET @EndDateString = DATEADD(day,1,@EndDateString)
		END
END


/********************/
/*Select statement.	*/
/********************/
SELECT
	uTradePartner.TradePartnerName AS AgentName
	,uTradePartnerVendor.VendorName
	,uTradePartnerVendor.TradePartnerID
	,uTradePartnerVendor.TradePartnerVendorID
	,sh.StyleNo
	,sh.Description AS StyleDescription
	,COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
--	,pSampleRequestSubmit.SampleRequestTradeID
--	,pSampleRequestSubmit.StyleSet
	,CASE
		WHEN	(pStyleColorway.StyleColorName = ''
				OR pStyleColorway.StyleColorName IS NULL)	THEN	'NA'
		ELSE	pStyleColorway.StyleColorName
	END AS StyleColorway
	,CASE
		WHEN	pSampleRequestSubmit.StyleSet = 1
				AND (sh.PC1 IS NULL
					OR sh.PC1 = '')		THEN	'1st Set'
		WHEN	pSampleRequestSubmit.StyleSet = 1
				AND (sh.PC1 IS NOT NULL
					AND sh.PC1 <> '')		THEN	sh.PC1
		WHEN	pSampleRequestSubmit.StyleSet = 2
				AND (sh.PC2 IS NULL
					OR sh.PC2 = '')		THEN	'2nd Set'
		WHEN	pSampleRequestSubmit.StyleSet = 2
				AND (sh.PC2 IS NOT NULL
					AND sh.PC2 <> '')		THEN	sh.PC2
		WHEN	pSampleRequestSubmit.StyleSet = 3
				AND (sh.PC3 IS NULL
					OR sh.PC3 = '')		THEN	'3rd Set'
		WHEN	pSampleRequestSubmit.StyleSet = 3
				AND (sh.PC3 IS NOT NULL
					AND sh.PC3 <> '')		THEN	sh.PC3
		WHEN	pSampleRequestSubmit.StyleSet = 4
				AND (sh.PC4 IS NULL
					OR sh.PC4 = '')		THEN	'4th Set'
		ELSE												sh.PC4
	END AS StyleSetName
--	,pSampleRequestSubmit.SampleWorkflowID
	,pSampleWorkflow.SampleWorkflow
	,pSampleRequestComment.SampleSubmit AS Submit
	,pSampleRequestComment.SampleRequestComment AS Comment
	,pSampleRequestComment.MUser
	,pSampleRequestComment.MDate
	,@TradePartnerID AS TradePartnerParamID
	,@BeginDateString AS BeginDate
	,@EndDateString AS EndDate
FROM uTradePartner
	INNER JOIN uTradePartnerVendor ON	uTradePartner.TradePartnerID = uTradePartnerVendor.TradePartnerID
	INNER JOIN pSampleRequestSubmit ON	/*uTradePartnerVendor.TradePartnerID = pSampleRequestSubmit.TradePartnerID		--Comment #01
											AND*/ uTradePartnerVendor.TradePartnerVendorID = pSampleRequestSubmit.TradePartnerVendorID		--Comment #01
	INNER JOIN pStyleHeader sh ON pSampleRequestSubmit.StyleID = sh.StyleID
	INNER JOIN pSampleWorkflow ON	pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	INNER JOIN pSampleRequestTrade ON	uTradePartnerVendor.TradePartnerID = pSampleRequestTrade.TradePartnerID
										AND uTradePartnerVendor.TradePartnerVendorID = pSampleRequestTrade.TradePartnerVendorID
										AND pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
										AND pSampleRequestSubmit.StyleColorID = pSampleRequestTrade.StyleColorID
										AND sh.StyleID = pSampleRequestTrade.StyleID
										AND pSampleRequestTrade.SampleRequestShare = 1
	LEFT OUTER JOIN pStyleColorway ON	pSampleRequestSubmit.StyleID = pStyleColorway.StyleID
										AND pSampleRequestSubmit.StyleColorID = pStyleColorway.StyleColorID
	INNER JOIN pSampleRequestComment ON	pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestComment.SampleRequestTradeID
										AND pSampleRequestSubmit.SampleRequestWorkflowID = pSampleRequestComment.SampleRequestWorkflowID
										AND pSampleRequestSubmit.StyleID = pSampleRequestComment.StyleID
										AND pSampleRequestSubmit.Submit = pSampleRequestComment.SampleSubmit
										AND pSampleRequestSubmit.StyleSet = pSampleRequestComment.StyleSet
										AND pSampleRequestComment.SampleCommentType = 'S'
    LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE (uTradePartner.TradePartnerID = @TradePartnerID
		OR @TradePartnerID = '99999999-9999-9999-9999-999999999999')
	AND pSampleRequestComment.MDate >= @BeginDateString	--Comment #02
	AND pSampleRequestComment.MDate < @EndDateString
ORDER BY
	uTradePartner.TradePartnerName
	,uTradePartnerVendor.VendorName
	,sh.StyleNo
	,pSampleRequestSubmit.SampleRequestTradeID
	,pSampleRequestSubmit.StyleSet
	,pSampleWorkflow.SampleWorkflowSort
	,pSampleRequestSubmit.SampleWorkflowID
	,pSampleRequestComment.SampleSubmit DESC
	,pSampleRequestComment.MDate DESC


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09591', GetDate())
GO
