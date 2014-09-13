IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_NN_SampleRequestSubmit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_NN_SampleRequestSubmit_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_NN_SampleRequestSubmit_SELECT] 
(
	@SampleRequestSubmitID nvarchar(50)	
)
AS

/*Variables*/
DECLARE @StatusID nvarchar(5)
DECLARE @StatusDescription nvarchar(50)
DECLARE @SampleSubmitType nvarchar(50)
DECLARE @TradePartnerID nvarchar(255)
DECLARE	@TradePartnerVendorID nvarchar(255)
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
DECLARE @StyleMasterID nvarchar(255)
DECLARE @SizeClassCheck nvarchar(50)
DECLARE @IsStudio int
DECLARE @StudioFlag int
DECLARE @StudioSpec nvarchar(10) -- Really doesn't do anything.
DECLARE @StyleID nvarchar(50)
DECLARE	@SampleRequestTradeID nvarchar(50)
DECLARE	@SampleWorkflowID nvarchar(5)
DECLARE	@Submit int
DECLARE	@StyleSet int
DECLARE @Count int


/*Get some other variables needed.*/
SELECT
	@SampleRequestTradeID = SampleRequestTradeID,
	@SampleWorkflowID = SampleWorkflowID,
	@Submit = Submit,
	@StyleID = StyleID,
	@StyleSet = StyleSet
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitID = @SampleRequestSubmitID

/*Get the statusid of the submit*/ 
SELECT	@StatusID = Status
FROM	pSampleRequestSubmit
WHERE	(StyleID = @StyleID)  AND
	(SampleRequestTradeID = @SampleRequestTradeID) AND
	(@SampleWorkflowID = SampleWorkflowID) AND
	(Submit = @Submit)

/*Get the status description of the submit*/
SELECT	@StatusDescription = Status
FROM	pSampleRequestSubmitStatus
WHERE	(StatusID = @StatusID)

/*Get the name of the sample submit type*/
SELECT	@SampleSubmitType = GroupName
FROM	pSampleWorkflow
WHERE	(SampleWorkflowID = @SampleWorkflowID)

/*Get TradePartner and TradePartnerVendor ids*/
SELECT	@TradePartnerID = TradePartnerID, @TradePartnerVendorID = TradePartnerVendorID
FROM	pSampleRequestSubmit
WHERE	(StyleID = @StyleID)  AND
	(SampleRequestTradeID = @SampleRequestTradeID) AND
	(@SampleWorkflowID = SampleWorkflowID) AND
	(Submit = @Submit)

/*Get Agent's name*/
SELECT	@TradePartnerName = TradePartnerName
FROM	uTradePartner
WHERE	TradePartnerID = @TradePartnerID

/*Get Vendor's name*/
SELECT	@VendorName = VendorName
FROM	uTradePartnerVendor
WHERE	TradePartnerVendorID = @TradePartnerVendorID

/*Get all the dates and a couple 'By' names*/
SELECT	@DueDate = DueDate,
	@ReceivedDate = RecDate,
	@ApprovedDate  = EndDate,
	@VendorDate  = VendorDate,
	@ReviewedDate = RevDate,
	@ReviewedBy = RevBy,
	@ApprovedBy = EndBy
FROM	pSampleRequestSubmit
WHERE	(pSampleRequestSubmit.StyleID = @StyleID) AND
	(pSampleRequestSubmit.SampleRequestTradeID = @SampleRequestTradeID) AND
	(pSampleRequestSubmit.SampleWorkflowID = @SampleWorkflowID) AND
	(pSampleRequestSubmit.Submit = @Submit)

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

/*Get the sample size*/
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
	END) FROM pStyleSpecSize
	WHERE (StyleID = @StyleID)

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

-- /*Made the 'Approved By-Reviewed By' string*/
-- IF ((@StatusID = 2) OR (@StatusID = 3))
-- 	BEGIN
-- 		SET @ApprovedStr1 = 'Approved By: '
-- 		SET @ApprovedStr2 = @ApprovedBy + ' on ' + @ApprovedDate
-- 	END
-- ELSE IF ((@ReviewedBy IS NULL) OR (@ReviewedBy = ''))
-- 	BEGIN
-- 		SET @ApprovedStr1 = 'Reviewed By: '
-- 		SET @ApprovedStr2 = 'No Reviewer'
-- 	END
-- ELSE
-- 	BEGIN
-- 		SET @ApprovedStr1 = 'Reviewed By: '
-- 		SET @ApprovedStr2 = @ReviewedBy + ' on ' + @ReviewedDate
-- 	END

/*Check to see if the size class you're at isn't already the Studio size class.*/
SELECT	@SizeClassCheck = SizeClass
FROM	pStyleHeader
WHERE	StyleID = @StyleID

/*Track whether the original size class is Studio, or not.*/
IF (@SizeClassCheck = 'STUDIO')
	SET @IsStudio = 1
ELSE
	SET @IsStudio = 0

/*Get the StyleMasterID to see if there's a Studio size.*/
SELECT @StyleMasterID = StyleMasterID
FROM pStyleHeader
WHERE StyleID = @StyleID

/*Create a temp table to throw everything into.*/
CREATE TABLE #tempTableOriginal
(
	TableRow int,
	ApprovedStr1 nvarchar(255),
	ApprovedStr2 nvarchar(255),
	HeadingStr nvarchar(255),
	SampleSize nvarchar(10),
	StatusID nvarchar(5),
	StatusDescription nvarchar(50),
	SampleSubmitType nvarchar(50),
	TradePartnerID nvarchar(255),
	TradePartnerVendorID nvarchar(255),
	TradePartnerName nvarchar(255),
	VendorName nvarchar(255),
	Critical int,
	POM nvarchar(10),
	PointMeasur nvarchar(255),
	TOL nvarchar(10),
	TOLN nvarchar(10),
	Ask nvarchar(10),
	[Var] nvarchar(10),
	Vendor nvarchar(10),
	Spec nvarchar(10),
	Rev nvarchar(10),
	Final nvarchar(10),
	DueDate nvarchar(50),
	NoTolerance int,
	ReceivedBy nvarchar(200),
	ReceivedDate nvarchar(50),
	ApprovedBy nvarchar(255),
	ApprovedDate nvarchar(50),
	VendorBy nvarchar(200),
	VendorDate nvarchar(50),
	ReceivedWeight nvarchar(50),
	VendorWeight nvarchar(50),
	ShipMethod nvarchar(200),
	TrackingNo nvarchar(100),
	ReviewedBy nvarchar(255),
	ReviewedDate nvarchar(50),
	FitComments ntext,
	VendorComments ntext,
	WashType nvarchar(50)
)

CREATE TABLE #tempTableStudio
(
	TableRow int,
	POM nvarchar(10),
	StudioSpec nvarchar(10)
)


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
IF (@IsStudio = 1 AND @Count <> 0)
	BEGIN
		/*Since this is the studio, set the studio flag equal to 1*/
		SET		@StudioFlag = 1

		SELECT
		 	@ApprovedStr1 AS ApprovedStr1,
		 	@ApprovedStr2 AS ApprovedStr2,
			@HeadingStr AS HeadingStr,
			@SampleSize AS SampleSize,
			@StatusID AS StatusID,
			@StatusDescription AS StatusDescription,
			@SampleSubmitType AS SampleSubmitType,
			@TradePartnerID AS TradePartnerID,
			@TradePartnerVendorID AS TradepartnerVendorID,
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
			REPLACE(CAST(pSampleRequestSubmit.Comment AS NVARCHAR(2000)), 'span', 'u') AS FitComments,
			pSampleRequestSubmit.VendorComment AS VendorComments,
			@WashType AS WashType,
			@StudioSpec AS StudioSpec,
			@IsStudio AS IsStudio,
			@StudioFlag AS StudioFlag
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
		ORDER BY	pSampleRequestSpecItem.Sort, pSampleRequestSpecItem.POM, pSampleRequestSpecItem.PointMeasur
	END
ELSE IF (@IsStudio = 1 AND @Count = 0)
	BEGIN
		/*Since this is the studio, set the studio flag equal to 1*/
		SET		@StudioFlag = 1

		SELECT
		 	@ApprovedStr1 AS ApprovedStr1,
		 	@ApprovedStr2 AS ApprovedStr2,
			@HeadingStr AS HeadingStr,
			@SampleSize AS SampleSize,
			@StatusID AS StatusID,
			@StatusDescription AS StatusDescription,
			@SampleSubmitType AS SampleSubmitType,
			@TradePartnerID AS TradePartnerID,
			@TradePartnerVendorID AS TradepartnerVendorID,
			@TradePartnerName AS TradePartnerName,
			@VendorName AS VendorName,
			0 AS Critical,
			'' AS [POM],
			'' AS [PointMeasur],
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
			REPLACE(CAST(pSampleRequestSubmit.Comment AS NVARCHAR(2000)), 'span', 'u') AS FitComments,
			pSampleRequestSubmit.VendorComment AS VendorComments,
			@WashType AS WashType,
			@StudioSpec AS StudioSpec,
			@IsStudio AS IsStudio,
			@StudioFlag AS StudioFlag
		FROM	pSampleRequestWorkflow INNER JOIN pSampleRequestSubmit ON
			pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID
		WHERE pSampleRequestSubmit.SampleRequestSubmitID = @SampleRequestSubmitID
		
	END
ELSE IF (@IsStudio <> 1 AND @Count <> 0)
	BEGIN
		/*Flag to see if there was a Studio size class.*/
		SET		@StudioFlag = 0
		
		SELECT 	@StudioFlag = COUNT(*)
		FROM	pStyleHeader
		WHERE	(StyleMasterID = @StyleMasterID) AND
				(SizeClass = 'STUDIO')

		/*Put all original information into the temp original table.*/
		INSERT INTO #tempTableOriginal
		(
			ApprovedStr1,
			ApprovedStr2,
			HeadingStr,
			SampleSize,
			StatusID,
			StatusDescription,
			SampleSubmitType,
			TradePartnerID,
			TradePartnerVendorID,
			TradePartnerName,
			VendorName,
			Critical,
			POM,
			PointMeasur,
			TOL,
			TOLN,
			Ask,
			[Var],
			Vendor,
			Spec,
			Rev,
			Final,
			DueDate,
			NoTolerance,
			ReceivedBy,
			ReceivedDate,
			ApprovedBy,
			ApprovedDate,
			VendorBy,
			VendorDate,
			ReceivedWeight,
			VendorWeight,
			ShipMethod,
			TrackingNo,
			ReviewedBy,
			ReviewedDate,
			FitComments,
			VendorComments,
			WashType
		)
		SELECT
		 	@ApprovedStr1 AS ApprovedStr1,
		 	@ApprovedStr2 AS ApprovedStr2,
			@HeadingStr AS HeadingStr,
			@SampleSize AS SampleSize,
			@StatusID AS StatusID,
			@StatusDescription AS StatusDescription,
			@SampleSubmitType AS SampleSubmitType,
			@TradePartnerID AS TradePartnerID,
			@TradePartnerVendorID AS TradepartnerVendorID,
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
			REPLACE(CAST(pSampleRequestSubmit.Comment AS NVARCHAR(2000)), 'span', 'u') AS FitComments,
			pSampleRequestSubmit.VendorComment AS VendorComments,
			@WashType AS WashType
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
		ORDER BY	pSampleRequestSpecItem.Sort, pSampleRequestSpecItem.POM, pSampleRequestSpecItem.PointMeasur


		/*Insert the studio spec information into its temp table.*/
		INSERT INTO #tempTableStudio (POM, StudioSpec)
		SELECT ps.POM, dbo.fnx_Num2Frac(ps.Spec)
		FROM	pStyleSpec ps LEFT OUTER JOIN pStyleHeader sh ON
				(ps.StyleID = sh.StyleID)
		WHERE	(sh.StyleMasterID = @StyleMasterID) AND
				(sh.SizeClass = 'STUDIO') AND
				(ps.StyleSet = @StyleSet)
		ORDER BY ps.POM

		/*Join the two tables together to get the Studio Spec info with the original info.*/
		SELECT
			a.ApprovedStr1,
			a.ApprovedStr2,
			a.HeadingStr,
			a.SampleSize,
			a.StatusID,
			a.StatusDescription,
			a.SampleSubmitType,
			a.TradePartnerID,
			a.TradePartnerVendorID,
			a.TradePartnerName,
			a.VendorName,
			a.Critical,
			a.POM,
			a.PointMeasur,
			a.TOL,
			a.TOLN,
			a.Ask,
			a.[Var],
			a.Vendor,
			a.Spec,
			a.Rev,
			a.Final,
			a.DueDate,
			a.NoTolerance,
			a.ReceivedBy,
			a.ReceivedDate,
			a.ApprovedBy,
			a.ApprovedDate,
			a.VendorBy,
			a.VendorDate,
			a.ReceivedWeight,
			a.VendorWeight,
			a.ShipMethod,
			a.TrackingNo,
			a.ReviewedBy,
			a.ReviewedDate,
			a.FitComments,
			a.VendorComments,
			a.WashType,
			b.StudioSpec,
			@IsStudio AS IsStudio,
			@StudioFlag AS StudioFlag
		FROM #tempTableOriginal a LEFT OUTER JOIN #tempTableStudio b ON
			a.POM = b.POM
	END
ELSE IF (@IsStudio <> 1 AND @Count = 0)
	BEGIN
		/*Flag to see if there was a Studio size class.*/
		SET		@StudioFlag = 0
		
		SELECT 	@StudioFlag = COUNT(*)
		FROM	pStyleHeader
		WHERE	(StyleMasterID = @StyleMasterID) AND
				(SizeClass = 'STUDIO')

		/*Put all original information into the temp original table.*/
		INSERT INTO #tempTableOriginal
		(
			ApprovedStr1,
			ApprovedStr2,
			HeadingStr,
			SampleSize,
			StatusID,
			StatusDescription,
			SampleSubmitType,
			TradePartnerID,
			TradePartnerVendorID,
			TradePartnerName,
			VendorName,
			Critical,
			POM,
			PointMeasur,
			TOL,
			TOLN,
			Ask,
			[Var],
			Vendor,
			Spec,
			Rev,
			Final,
			DueDate,
			NoTolerance,
			ReceivedBy,
			ReceivedDate,
			ApprovedBy,
			ApprovedDate,
			VendorBy,
			VendorDate,
			ReceivedWeight,
			VendorWeight,
			ShipMethod,
			TrackingNo,
			ReviewedBy,
			ReviewedDate,
			FitComments,
			VendorComments,
			WashType
		)
		SELECT
		 	@ApprovedStr1 AS ApprovedStr1,
		 	@ApprovedStr2 AS ApprovedStr2,
			@HeadingStr AS HeadingStr,
			@SampleSize AS SampleSize,
			@StatusID AS StatusID,
			@StatusDescription AS StatusDescription,
			@SampleSubmitType AS SampleSubmitType,
			@TradePartnerID AS TradePartnerID,
			@TradePartnerVendorID AS TradepartnerVendorID,
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
			REPLACE(CAST(pSampleRequestSubmit.Comment AS NVARCHAR(2000)), 'span', 'u') AS FitComments,
			pSampleRequestSubmit.VendorComment AS VendorComments,
			@WashType AS WashType
		FROM	pSampleRequestWorkflow INNER JOIN pSampleRequestSubmit ON
			pSampleRequestWorkflow.SampleRequestWorkflowID = pSampleRequestSubmit.SampleRequestWorkflowID
		WHERE pSampleRequestSubmit.SampleRequestSubmitID = @SampleRequestSubmitID


		/*Insert the studio spec information into its temp table.*/
		INSERT INTO #tempTableStudio (POM, StudioSpec)
		SELECT ps.POM, dbo.fnx_Num2Frac(ps.Spec)
		FROM	pStyleSpec ps LEFT OUTER JOIN pStyleHeader sh ON
				(ps.StyleID = sh.StyleID)
		WHERE	(sh.StyleMasterID = @StyleMasterID) AND
				(sh.SizeClass = 'STUDIO') AND
				(ps.StyleSet = @StyleSet)
		ORDER BY ps.POM

		/*Join the two tables together to get the Studio Spec info with the original info.*/
		SELECT
			a.ApprovedStr1,
			a.ApprovedStr2,
			a.HeadingStr,
			a.SampleSize,
			a.StatusID,
			a.StatusDescription,
			a.SampleSubmitType,
			a.TradePartnerID,
			a.TradePartnerVendorID,
			a.TradePartnerName,
			a.VendorName,
			a.Critical,
			a.POM,
			a.PointMeasur,
			a.TOL,
			a.TOLN,
			a.Ask,
			a.[Var],
			a.Vendor,
			a.Spec,
			a.Rev,
			a.Final,
			a.DueDate,
			a.NoTolerance,
			a.ReceivedBy,
			a.ReceivedDate,
			a.ApprovedBy,
			a.ApprovedDate,
			a.VendorBy,
			a.VendorDate,
			a.ReceivedWeight,
			a.VendorWeight,
			a.ShipMethod,
			a.TrackingNo,
			a.ReviewedBy,
			a.ReviewedDate,
			a.FitComments,
			a.VendorComments,
			a.WashType,
			b.StudioSpec,
			@IsStudio AS IsStudio,
			@StudioFlag AS StudioFlag
		FROM #tempTableOriginal a LEFT OUTER JOIN #tempTableStudio b ON
			a.POM = b.POM
	END


DROP TABLE #tempTableOriginal
DROP TABLE #tempTableStudio










GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08573', GetDate())
GO