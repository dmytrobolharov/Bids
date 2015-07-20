IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SampleFolder_WHERECount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SampleFolder_WHERECount_SELECT]
GO


CREATE PROCEDURE [dbo].[dpx_SampleFolder_WHERECount_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
)

AS

DECLARE @StyleCount INT
DECLARE @ColorCount INT
DECLARE @SampleCount INT
DECLARE @SampleCountBOM INT
DECLARE @SupplierCount INT
DECLARE @SupplierCountBOM INT
DECLARE @CountryCount INT
DECLARE @OpenSubmitCount INT
DECLARE @OpenSubmitCountBOM INT
DECLARE @LateSubmitCount INT
DECLARE @LateSubmitCountBOM INT
DECLARE @ApprovedSubmitCount INT
DECLARE @ApprovedSubmitCountBOM INT

SET @StyleCount = 0
SET @ColorCount = 0
SET @SampleCount = 0
SET @SampleCountBOM = 0
SET @SupplierCount = 0
SET @CountryCount = 0
SET @OpenSubmitCount = 0
SET @LateSubmitCount = 0
SET @ApprovedSubmitCount = 0


IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END


-- Get Total # of Style
BEGIN
	SET @StyleCount = (
							SELECT     COUNT(*) AS StyleCount
							FROM  pStyleHeader INNER JOIN
							pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID INNER JOIN
							pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID	
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
)
END

-- Get Total # of Color
BEGIN
	SET @ColorCount = (
						SELECT COUNT(*) AS StyleColorCount
						FROM pStyleColorwaySeasonYear INNER JOIN
							pStyleHeader ON pStyleColorwaySeasonYear.StyleID = pStyleHeader.StyleID INNER JOIN
							pStyleSeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
						WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
)
END

-- Get Total # of Sample
BEGIN
	SET @SampleCount = (
							SELECT COUNT(*)
							FROM pStyleHeader
								INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID
								INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
							WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
)     
END

-- Get Total # of BOM Sample
BEGIN
	SET @SampleCountBOM = (
							SELECT COUNT(*)
							FROM pStyleHeader
								INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
								INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
							WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
)     
END

-- Get Total # of Supplier
BEGIN
	SET @SupplierCount = (
							SELECT  COUNT(*) AS StyleCount
							FROM  pSampleRequestTrade INNER JOIN
								  pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								  pStyleHeader ON pSampleRequestTrade.StyleID = pStyleHeader.StyleID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID) 
							--GROUP BY pSampleRequestTrade.TradePartnerID
)
END

-- Get Total # of BOM Supplier
BEGIN
	SET @SupplierCountBOM = (
							SELECT  COUNT(*) AS StyleCount
							FROM  pSampleRequestBOMTrade INNER JOIN
								  pStyleSeasonYear ON pSampleRequestBOMTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								  pStyleHeader ON pSampleRequestBOMTrade.StyleID = pStyleHeader.StyleID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID) 
							--GROUP BY pSampleRequestTrade.TradePartnerID
)
END

-- Get Total # of Open Submit
BEGIN
	SET @OpenSubmitCount = (
							SELECT COUNT(*) AS StyleCount
							FROM pSampleRequestTrade INNER JOIN
								pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								pSampleRequestWorkflow ON 
								pSampleRequestTrade.SampleRequestTradeID = pSampleRequestWorkflow.SampleRequestTradeID INNER JOIN
								pSampleRequestSubmit ON 
								pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID INNER JOIN
								pStyleHeader ON pSampleRequestTrade.StyleID = pStyleHeader.StyleID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)   
							AND (pSampleRequestSubmit.Status = 1 OR pSampleRequestSubmit.Status = 0)
)
END

-- Get Total # of BOM Open Submit
BEGIN
	SET @OpenSubmitCountBOM = (
							SELECT COUNT(*) AS StyleCount
							FROM pSampleRequestBOMTrade INNER JOIN
								pStyleSeasonYear ON pSampleRequestBOMTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								pSampleRequestWorkflowBOM ON 
								pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestWorkflowBOM.SampleRequestTradeID INNER JOIN
								pSampleRequestSubmitBOM ON 
								pSampleRequestWorkflowBOM.SampleRequestWorkflowID = pSampleRequestSubmitBOM.SampleRequestWorkflowID INNER JOIN
								pStyleHeader ON pSampleRequestBOMTrade.StyleID = pStyleHeader.StyleID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)   
							AND (pSampleRequestSubmitBOM.Status = 1 OR pSampleRequestSubmitBOM.Status = 0)
)
END


-- Get Total # of Approved Submit
BEGIN
	SET @ApprovedSubmitCount = (
							SELECT COUNT(*) AS StyleCount
							FROM pSampleRequestTrade INNER JOIN
								pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								pSampleRequestWorkflow ON 
								pSampleRequestTrade.SampleRequestTradeID = pSampleRequestWorkflow.SampleRequestTradeID INNER JOIN
								pSampleRequestSubmit ON 
								pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID INNER JOIN
								pStyleHeader ON pSampleRequestTrade.StyleID = pStyleHeader.StyleID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)  
							AND (pSampleRequestSubmit.Status = 2 OR pSampleRequestSubmit.Status = 3)
)
END

-- Get Total # of BOM Approved Submit
BEGIN
	SET @ApprovedSubmitCountBOM = (
							SELECT COUNT(*) AS StyleCount
							FROM pSampleRequestBOMTrade INNER JOIN
								pStyleSeasonYear ON pSampleRequestBOMTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								pSampleRequestWorkflowBOM ON 
								pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestWorkflowBOM.SampleRequestTradeID INNER JOIN
								pSampleRequestSubmitBOM ON 
								pSampleRequestWorkflowBOM.SampleRequestWorkflowID = pSampleRequestSubmitBOM.SampleRequestWorkflowID INNER JOIN
								pStyleHeader ON pSampleRequestBOMTrade.StyleID = pStyleHeader.StyleID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)  
							AND (pSampleRequestSubmitBOM.Status = 2 OR pSampleRequestSubmitBOM.Status = 3)
)
END

-- Get Total # of Late Submit
BEGIN
	SET @LateSubmitCount = (
							SELECT COUNT(*) AS StyleCount
							FROM pSampleRequestTrade INNER JOIN
								pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								pSampleRequestWorkflow ON 
								pSampleRequestTrade.SampleRequestTradeID = pSampleRequestWorkflow.SampleRequestTradeID INNER JOIN
								pSampleRequestSubmit ON 
								pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID INNER JOIN
								pStyleHeader ON pSampleRequestTrade.StyleID = pStyleHeader.StyleID  
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)  
							AND (pSampleRequestSubmit.Status = 1 OR pSampleRequestSubmit.Status = 0) AND pSampleRequestSubmit.DueDate <= GETDATE()
)
END

-- Get Total # of BOM Late Submit
BEGIN
	SET @LateSubmitCountBOM = (
							SELECT COUNT(*) AS StyleCount
							FROM pSampleRequestBOMTrade INNER JOIN
								pStyleSeasonYear ON pSampleRequestBOMTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
								pSampleRequestWorkflowBOM ON 
								pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestWorkflowBOM.SampleRequestTradeID INNER JOIN
								pSampleRequestSubmitBOM ON 
								pSampleRequestWorkflowBOM.SampleRequestWorkflowID = pSampleRequestSubmitBOM.SampleRequestWorkflowID INNER JOIN
								pStyleHeader ON pSampleRequestBOMTrade.StyleID = pStyleHeader.StyleID  
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)  
							AND (pSampleRequestSubmitBOM.Status = 1 OR pSampleRequestSubmitBOM.Status = 0) AND pSampleRequestSubmitBOM.DueDate <= GETDATE()
)
END

BEGIN
	CREATE TABLE #tmpStyleCount(
		StyleCount int NULL,
		ColorCount int NULL,
		SampleCount int NULL,
		SupplierCount int NULL,
		CountryCount int NULL,
		OpenSubmitCount int NULL,
		LateSubmitCount int NULL,
		ApprovedSubmitCount int NULL
	) 
END

BEGIN
	INSERT INTO #tmpStyleCount(StyleCount, ColorCount, SampleCount, SupplierCount, CountryCount, OpenSubmitCount, LateSubmitCount, ApprovedSubmitCount)
		VALUES (@StyleCount, @ColorCount, ISNULL(@SampleCount,0) + ISNULL(@SampleCountBOM,0), ISNULL(@SupplierCount,0) + ISNULL(@SupplierCountBOM,0), @CountryCount, ISNULL(@OpenSubmitCount,0) + ISNULL(@OpenSubmitCountBOM,0), ISNULL(@LateSubmitCount,0) + ISNULL(@LateSubmitCountBOM,0), ISNULL(@ApprovedSubmitCount,0) + ISNULL(@ApprovedSubmitCountBOM,0))
END

BEGIN
	SELECT TOP 1 * FROM #tmpStyleCount
END

BEGIN
	DROP TABLE #tmpStyleCount
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06885', GetDate())
GO
