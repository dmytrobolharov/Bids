/*****************
 * 4/30/07 - 5:00pm EST - Ryan Cabanas - Added the "@SampleRequestWorkflowID" variable, grabbed the value for that 
 * variable in the initial SELECT statement from the pSampleRequestSubmit table, and then I changed the CASE
 * selection where the SampleSize was chosen.  Selected the SampleSize from the pSampleRequestSpecSize table now.
 ****************/


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmit_SELECT]
(
	@SampleRequestSubmitID varchar(50)
)
AS

/*Variables*/
DECLARE @StatusID nvarchar(5)
DECLARE @StatusDescription nvarchar(50)
DECLARE @SampleSubmitType nvarchar(50)
DECLARE @TradePartnerID uniqueidentifier
DECLARE	@TradePartnerVendorID uniqueidentifier
DECLARE	@TradePartnerName nvarchar(255)
DECLARE	@VendorName nvarchar(255)
DECLARE	@DueDate nvarchar(50)
DECLARE	@ReceivedDate nvarchar(50)
DECLARE	@ApprovedDate nvarchar(50)
DECLARE	@VendorDate nvarchar(50)
DECLARE	@ReviewedDate nvarchar(50)
DECLARE @WashType nvarchar(50)
DECLARE	@SpecSketchID nvarchar(255)
DECLARE	@SpecSketchVersion int
DECLARE @ImageID nvarchar(255)
DECLARE	@ImageHistoryID nvarchar(255)
DECLARE	@Version int
DECLARE @HeadingStr nvarchar(255)
DECLARE	@SampleSize nvarchar(10)
DECLARE @SubmitNumberExtension nvarchar(5)
DECLARE @ApprovedStr1 nvarchar(255)
DECLARE @ApprovedStr2 nvarchar(255)
DECLARE @ApprovedBy nvarchar(255)
DECLARE @ReviewedBy nvarchar(255)
DECLARE	@SampleRequestTradeID varchar(255)
DECLARE	@SampleWorkflowID nvarchar(5)
DECLARE	@Submit int
DECLARE	@StyleID varchar(50)
DECLARE @StyleSet int 
DECLARE @Count int
DECLARE @SampleRequestWorkflowID uniqueidentifier

/*Get some other variables needed.*/
SELECT
	@SampleRequestTradeID = SampleRequestTradeID,
	@SampleWorkflowID = SampleWorkflowID,
	@Submit = Submit,
	@StyleID = StyleID,
	@StyleSet = StyleSet,
	@StatusID = Status,
	@TradePartnerID = TradePartnerID,
	@TradePartnerVendorID = TradePartnerVendorID,
	@DueDate = DueDate,
	@ReceivedDate = RecDate,
	@ApprovedDate  = EndDate,
	@VendorDate  = VendorDate,
	@ReviewedDate = RevDate,
	@ReviewedBy = RevBy,
	@ApprovedBy = EndBy,
	@SampleRequestWorkflowID = SampleRequestWorkflowID
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitID = @SampleRequestSubmitID

/*Get the status description of the submit*/
SELECT	@StatusDescription = Status
FROM	pSampleRequestSubmitStatus
WHERE	(StatusID = @StatusID)

/*Get the name of the sample submit type*/
SELECT	@SampleSubmitType = GroupName
FROM	pSampleWorkflow
WHERE	(SampleWorkflowID = @SampleWorkflowID)

/*Get Agent's name*/
SELECT	@TradePartnerName = TradePartnerName
FROM	uTradePartner
WHERE	TradePartnerID = @TradePartnerID

/*Get Vendor's name*/
SELECT	@VendorName = VendorName
FROM	uTradePartnerVendor
WHERE	TradePartnerVendorID = @TradePartnerVendorID

/*Change all the dates to a shorter date format*/
SET	@DueDate = CAST(Month(@DueDate) AS nvarchar(10)) + '/' +
	CAST(Day(@DueDate) AS nvarchar(10)) + '/' +
	CAST(Year(@DueDate) AS nvarchar(10))
SET	@ReceivedDate = CAST(Month(@ReceivedDate) AS nvarchar(10)) + '/' +
	CAST(Day(@ReceivedDate) AS nvarchar(10)) + '/' +
	CAST(Year(@ReceivedDate) AS nvarchar(10))
SET	@ApprovedDate = CAST(Month(@ApprovedDate) AS nvarchar(10)) + '/' +
	CAST(Day(@ApprovedDate) AS nvarchar(10)) + '/' +
	CAST(Year(@ApprovedDate) AS nvarchar(10))
SET	@VendorDate = CAST(Month(@VendorDate) AS nvarchar(10)) + '/' +
	CAST(Day(@VendorDate) AS nvarchar(10)) + '/' +
	CAST(Year(@VendorDate) AS nvarchar(10))
SET	@ReviewedDate = CAST(Month(@ReviewedDate) AS nvarchar(10)) + '/' +
	CAST(Day(@ReviewedDate) AS nvarchar(10)) + '/' +
	CAST(Year(@ReviewedDate) AS nvarchar(10))

/*Get wash type of the style*/
SELECT	@WashType = WashType
FROM	pStyleHeader
WHERE	(StyleID = @StyleID)

/*Make sure washtype is not null*/
SET	@WashType = 
		CASE 
			WHEN UPPER(@WashType) IS NULL THEN 'TOL'
			WHEN UPPER(@WashType) = '' THEN 'TOL'
			WHEN UPPER(@WashType) = 'WASH' THEN 'TOL'
			ELSE 'TOLN'
		END 

/********************************/
/*Logic to get the sample size.	*/
/********************************/
BEGIN
	/*Try the old location first.*/
	SELECT  @SampleSize =
		(CASE 
			WHEN Sel0 = 1 THEN Size0
			WHEN Sel1 = 1 THEN Size1
			WHEN Sel2 = 1 THEN Size2
			WHEN Sel3 = 1 THEN Size3
			WHEN Sel4 = 1 THEN Size4
			WHEN Sel5 = 1 THEN Size5
			WHEN Sel6 = 1 THEN Size6
			WHEN Sel7 = 1 THEN Size7
			WHEN Sel8 = 1 THEN Size8
			WHEN Sel9 = 1 THEN Size9
			WHEN Sel10 = 1 THEN Size10
			WHEN Sel11 = 1 THEN Size11

			WHEN Sel12 = 1 THEN Size12
			WHEN Sel13 = 1 THEN Size13
			WHEN Sel14 = 1 THEN Size14
			WHEN Sel15 = 1 THEN Size15
			WHEN Sel16 = 1 THEN Size16
			WHEN Sel17 = 1 THEN Size17
			WHEN Sel18 = 1 THEN Size18
			WHEN Sel19 = 1 THEN Size19
		END)
	FROM pSampleRequestSpecSize
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)
		AND (SampleRequestTradeID = @SampleRequestTradeID)
		AND (StyleID = @StyleID)
	
	/*Try the new location, if empty data found in the old location.*/
	IF(@SampleSize IS NULL OR @SampleSize = '')
		BEGIN
			SELECT  @SampleSize = SampleSize
			FROM pMSEvalHeader
			WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)
				AND (SampleRequestTradeID = @SampleRequestTradeID)
				AND (StyleID = @StyleID)
				AND (StyleSet = @StyleSet)	
		END
END

/*Make heading string*/
IF (@Submit = 0)
	BEGIN
		SET @SubmitNumberExtension = 'th'
	END
ELSE IF (@Submit = 1)
	BEGIN
		SET @SubmitNumberExtension = 'st'
	END
ELSE IF (@Submit = 2)
	BEGIN
		SET @SubmitNumberExtension = 'nd'
	END
ELSE IF (@Submit = 3)
	BEGIN
		SET @SubmitNumberExtension = 'rd'
	END
ELSE 
	BEGIN
		SET @SubmitNumberExtension = 'th'
	END

SET @HeadingStr = @SampleSubmitType + ' / ' + CAST(@Submit AS nvarchar(2)) +
	@SubmitNumberExtension + ' Submit'

/*Made the 'Approved By-Reviewed By' string*/
IF ((@StatusID = 2) OR (@StatusID = 3))
	BEGIN
		SET @ApprovedStr1 = 'Approved By: '
		SET @ApprovedStr2 = @ApprovedBy + ' on ' + @ApprovedDate
	END
ELSE IF ((@ReviewedBy IS NULL) OR (@ReviewedBy = ''))
	BEGIN
		SET @ApprovedStr1 = 'Reviewed By: '
		SET @ApprovedStr2 = 'No Reviewer'
	END
ELSE
	BEGIN
		SET @ApprovedStr1 = 'Reviewed By: '
		SET @ApprovedStr2 = @ReviewedBy + ' on ' + @ReviewedDate
	END

/*Do counts to find out if there are any records.*/
SELECT @Count = COUNT(*)
FROM	pSampleRequestSpecItem LEFT OUTER JOIN pSampleRequestWorkflow ON
	pSampleRequestSpecItem.SampleRequestWorkflowID = pSampleRequestWorkflow.SampleRequestWorkflowID LEFT OUTER JOIN
	pSampleRequestSubmit ON
	pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID
WHERE	(pSampleRequestSpecItem.StyleID = @StyleID) AND
	(pSampleRequestSpecItem.SampleRequestTradeID = @SampleRequestTradeID) AND
	(pSampleRequestSpecItem.SampleWorkflowID = @SampleWorkflowID) AND
	(pSampleRequestSpecItem.Submit = @Submit) AND
	(pSampleRequestSpecItem.Ask <> 0) AND 
	(pSampleRequestSpecItem.StyleSet = @StyleSet) AND
	(pSampleRequestSubmit.SampleRequestSubmitID = @SampleRequestSubmitID)


/*Get status information fields*/
IF (@Count <> 0)
	BEGIN
		SELECT
			@ApprovedStr1 AS ApprovedStr1,
			@ApprovedStr2 AS ApprovedStr2,
			@HeadingStr AS HeadingStr,
			@SampleSize AS SampleSize,
			@StatusID AS StatusID,
			@StatusDescription AS StatusDescription,
			@SampleSubmitType AS SampleSubmitType,
			--@TradePartnerID AS TradePartnerID,
			--@TradePartnerVendorID AS TradepartnerVendorID,
			@TradePartnerName AS TradePartnerName,
			@VendorName AS VendorName,
			pSampleRequestSpecItem.Critical,
			pSampleRequestSpecItem.POM,
			pSampleRequestSpecItem.PointMeasur,
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.TOL) AS TOL,
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.TOLN) AS TOLN,
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.Ask) AS Ask,
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.[Var]) AS [Var],
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.Vendor) AS Vendor,
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.Spec) AS Spec,
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.Rev) AS Rev,
			dbo.fnx_Num2Frac(pSampleRequestSpecItem.Final) AS Final,
			@DueDate AS DueDate,
			pSampleRequestSubmit.NoTolerance,
			pSampleRequestSubmit.RecBy AS ReceivedBy,
			@ReceivedDate AS ReceivedDate, 
			@ApprovedBy AS ApprovedBy,
			@ApprovedDate AS ApprovedDate,
			pSampleRequestSubmit.VendorName AS VendorBy,
			@VendorDate AS VendorDate,
			pSampleRequestSubmit.RecWeight AS ReceivedWeight,
			pSampleRequestSubmit.VendorWeight AS VendorWeight,
			pSampleRequestSubmit.RecCarrier AS ShipMethod,
			pSampleRequestSubmit.RecTrackNo AS TrackingNo,
			@ReviewedBy AS ReviewedBy,
			@ReviewedDate AS ReviewedDate,
			pSampleRequestSubmit.Comment AS FitComments,
			pSampleRequestSubmit.VendorComment AS VendorComments,
			@WashType AS WashType,
			CASE
				WHEN (pSampleRequestSpecItem.[Var] > pSampleRequestSpecItem.TOL)	THEN 1
				ELSE 0
			END AS OutOfTolerance
		FROM	pSampleRequestSpecItem LEFT OUTER JOIN pSampleRequestWorkflow ON
			pSampleRequestSpecItem.SampleRequestWorkflowID = pSampleRequestWorkflow.SampleRequestWorkflowID LEFT OUTER JOIN
			pSampleRequestSubmit ON
			pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID
		WHERE	(pSampleRequestSpecItem.StyleID = @StyleID) AND
			(pSampleRequestSpecItem.SampleRequestTradeID = @SampleRequestTradeID) AND
			(pSampleRequestSpecItem.SampleWorkflowID = @SampleWorkflowID) AND
			(pSampleRequestSpecItem.Submit = @Submit) AND
			(pSampleRequestSpecItem.Ask <> 0) AND 
			(pSampleRequestSpecItem.StyleSet = @StyleSet) AND
			(pSampleRequestSubmit.SampleRequestSubmitID = @SampleRequestSubmitID)
		ORDER BY	pSampleRequestSpecItem. Sort, pSampleRequestSpecItem.POM, pSampleRequestSpecItem.PointMeasur
	END
ELSE IF (@Count = 0)
	BEGIN
		SELECT
			@ApprovedStr1 AS ApprovedStr1,
			@ApprovedStr2 AS ApprovedStr2,
			@HeadingStr AS HeadingStr,
			@SampleSize AS SampleSize,
			@StatusID AS StatusID,
			@StatusDescription AS StatusDescription,
			@SampleSubmitType AS SampleSubmitType,
			--@TradePartnerID AS TradePartnerID,
			--@TradePartnerVendorID AS TradepartnerVendorID,
			@TradePartnerName AS TradePartnerName,
			@VendorName AS VendorName,
			0 AS Critical,
			'' AS POM,
			'' AS PointMeasur,
			NULL AS TOL,
			NULL AS TOLN,
			NULL AS Ask,
			NULL AS [Var],
			NULL AS Vendor,
			NULL AS Spec,
			NULL AS Rev,
			NULL AS Final,
			@DueDate AS DueDate,
			pSampleRequestSubmit.NoTolerance,
			pSampleRequestSubmit.RecBy AS ReceivedBy,
			@ReceivedDate AS ReceivedDate, 
			@ApprovedBy AS ApprovedBy,
			@ApprovedDate AS ApprovedDate,
			pSampleRequestSubmit.VendorName AS VendorBy,
			@VendorDate AS VendorDate,
			pSampleRequestSubmit.RecWeight AS ReceivedWeight,
			pSampleRequestSubmit.VendorWeight AS VendorWeight,
			pSampleRequestSubmit.RecCarrier AS ShipMethod,
			pSampleRequestSubmit.RecTrackNo AS TrackingNo,
			@ReviewedBy AS ReviewedBy,
			@ReviewedDate AS ReviewedDate,
			pSampleRequestSubmit.Comment AS FitComments,
			pSampleRequestSubmit.VendorComment AS VendorComments,
			@WashType AS WashType,
			0 AS OutOfTolerance
		FROM	pSampleRequestWorkflow INNER JOIN pSampleRequestSubmit ON
			pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID
		WHERE pSampleRequestSubmit.SampleRequestSubmitID = @SampleRequestSubmitID
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03376', GetDate())
GO