IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_Material_VendorComments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_Material_VendorComments_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmit_Material_VendorComments_SELECT]
(
	@SampleRequestSubmitID varchar(50)
)
AS

/*Declare variables.*/
DECLARE @StatusDescription nvarchar(200)
DECLARE	@DueDate nvarchar(50)
DECLARE @ReceivedBy nvarchar(200)
DECLARE	@ReceivedDate nvarchar(50)
DECLARE @ApprovedBy nvarchar(255)
DECLARE	@ApprovedDate nvarchar(50)
DECLARE @ReviewedBy nvarchar(255)
DECLARE	@ReviewedDate nvarchar(50)
DECLARE @VendorBy nvarchar(200)
DECLARE	@VendorDate nvarchar(50)
DECLARE	@TradePartnerName nvarchar(255)
DECLARE	@VendorName nvarchar(255)
DECLARE @SampleWorkflowID varchar(10)
DECLARE @ComponentType nvarchar(255)
DECLARE @StyleID varchar(50)
DECLARE @Count int
DECLARE @HeadingStr nvarchar(255)
DECLARE	@Submit int
DECLARE @SampleSubmitType nvarchar(50)
DECLARE @SubmitNumberExtension nvarchar(5)

IF EXISTS (SELECT * FROM pSampleRequestSubmitBOM WHERE SampleRequestSubmitID = @SampleRequestSubmitID)
BEGIN

	/*Start by grabbing some information.*/
	SELECT
		@Submit = Submit,
		@StyleID  = b.StyleID,
		@SampleWorkflowID = b.SampleWorkflowID,
		@StatusDescription = a.Status,
		@DueDate = b.DueDate,
		@ReceivedBy = b.RecBy,
		@ReceivedDate = b.RecDate,
		@ApprovedBy = b.EndBy,
		@ApprovedDate = b.EndDate,
		@ReviewedBy = b.RevBy,
		@ReviewedDate = b.RevDate,
		@VendorBy = b.VendorName,
		@VendorDate = b.VendorDate,
		@TradePartnerName = c.TradePartnerName,
		@VendorName = d.VendorName
	FROM pSampleRequestSubmitBOM b
		LEFT OUTER JOIN pSampleRequestSubmitStatus a ON	b.[Status] = a.StatusID
		LEFT OUTER JOIN uTradePartner c ON	b.TradePartnerID = c.TradePartnerID
		LEFT OUTER JOIN uTradePartnerVendor d ON	b.TradePartnerVendorID = d.TradePartnerVendorID
	WHERE b.SampleRequestSubmitID = @SampleRequestSubmitID
	
	/*Get the name of the sample submit type*/
	SELECT	@SampleSubmitType = GroupName
	FROM	pSampleWorkflow
	WHERE	(SampleWorkflowID = @SampleWorkflowID)	
	
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
		CAST(Year(@VendorDate) AS nvarchar(10)) SET	@ReviewedDate = CAST(Month(@ReviewedDate) AS nvarchar(10)) + '/' +
		CAST(Day(@ReviewedDate) AS nvarchar(10)) + '/' +
		CAST(Year(@ReviewedDate) AS nvarchar(10))


	/*Do counts to find out if there are any records.*/
	SELECT @Count = COUNT(*)
	FROM pSampleRequestMaterialBOM a
		LEFT OUTER JOIN pSampleRequestSubmitStatus b ON	a.Status = b.StatusID
		RIGHT OUTER JOIN pSampleRequestSubmitBOM c ON	a.SampleRequestWorkflowID = c.SampleRequestWorkflowID
		LEFT OUTER JOIN pSampleWorkflow d ON	c.SampleWorkflowID = d.SampleWorkflowID
		LEFT OUTER JOIN pStyleBOM e ON	a.StyleID = e.StyleID
												AND a.StyleMaterialID = e.StyleMaterialID
		LEFT OUTER JOIN pComponentType f ON	a.MaterialType = f.ComponentTypeID
	WHERE c.SampleRequestSubmitID = @SampleRequestSubmitID


	/*Final Select statement.*/
	IF (@Count <> 0)
		BEGIN
			SELECT
				a.MaterialNo,
				a.MaterialName,
				a.MaterialSize,
				b.[Status],
				a.Submit,
				@HeadingStr AS HeadingStr,
				d.GroupName + ' Comment' AS CommentTitle,
				d.GroupName AS Title,
				c.Comment AS Comments,
				e.Placement,
				f.ComponentDescription,
				@StatusDescription AS StatusDescription,
				@DueDate AS DueDate,
				@ReceivedBy AS ReceivedBy,
				@ReceivedDate AS ReceivedDate,
				@ApprovedBy AS ApprovedBy,
				@ApprovedDate AS ApprovedDate,
				@ReviewedBy AS ReviewedBy,
				@ReviewedDate AS ReviewedDate,
				@VendorBy AS VendorBy,
				@VendorDate AS VendorDate,
				@TradePartnerName AS TradePartnerName,
				@VendorName AS VendorName
			FROM pSampleRequestMaterialBOM a
				LEFT OUTER JOIN pSampleRequestSubmitStatus b ON	a.[Status] = b.StatusID
				RIGHT OUTER JOIN pSampleRequestSubmitBOM c ON	a.SampleRequestWorkflowID = c.SampleRequestWorkflowID
				LEFT OUTER JOIN pSampleWorkflow d ON	c.SampleWorkflowID = d.SampleWorkflowID
				LEFT OUTER JOIN pStyleBOM e ON	a.StyleID = e.StyleID
														AND a.StyleMaterialID = e.StyleMaterialID
				LEFT OUTER JOIN pComponentType f ON	a.MaterialType = f.ComponentTypeID
			WHERE c.SampleRequestSubmitID = @SampleRequestSubmitID
			ORDER BY f.ComponentDescription, a.MaterialName
		END
	ELSE IF (@Count = 0)
		BEGIN
			SELECT
				NULL AS MaterialNo,
				NULL AS MaterialName,
				NULL AS MaterialSize,
				a.[Status],
				NULL AS Submit,
				@HeadingStr AS HeadingStr,
				e.GroupName + ' Comment' AS CommentTitle,
				e.GroupName AS Title,
				b.Comment AS Comments,
				NULL AS Placement,
				NULL AS ComponentDescription,
				@StatusDescription AS StatusDescription,
				@DueDate AS DueDate,
				@ReceivedBy AS ReceivedBy,
				@ReceivedDate AS ReceivedDate,
				@ApprovedBy AS ApprovedBy,
				@ApprovedDate AS ApprovedDate,
				@ReviewedBy AS ReviewedBy,
				@ReviewedDate AS ReviewedDate,
				@VendorBy AS VendorBy,
				@VendorDate AS VendorDate,
				@TradePartnerName AS TradePartnerName,
				@VendorName AS VendorName
			FROM pSampleRequestSubmitBOM b
				LEFT OUTER JOIN pSampleRequestSubmitStatus a	ON b.[Status] = a.StatusID
				LEFT OUTER JOIN uTradePartner c	ON b.TradePartnerID = c.TradePartnerID
				LEFT OUTER JOIN uTradePartnerVendor d	ON b.TradePartnerVendorID = d.TradePartnerVendorID
				LEFT OUTER JOIN pSampleWorkflow e	ON b.SampleWorkflowID = e.SampleWorkflowID
			WHERE b.SampleRequestSubmitID = @SampleRequestSubmitID
		END

END
ELSE
BEGIN

	/*Start by grabbing some information.*/
	SELECT
		@Submit = Submit,
		@StyleID  = b.StyleID,
		@SampleWorkflowID = b.SampleWorkflowID,
		@StatusDescription = a.Status,
		@DueDate = b.DueDate,
		@ReceivedBy = b.RecBy,
		@ReceivedDate = b.RecDate,
		@ApprovedBy = b.EndBy,
		@ApprovedDate = b.EndDate,
		@ReviewedBy = b.RevBy,
		@ReviewedDate = b.RevDate,
		@VendorBy = b.VendorName,
		@VendorDate = b.VendorDate,
		@TradePartnerName = c.TradePartnerName,
		@VendorName = d.VendorName
	FROM pSampleRequestSubmit b
		LEFT OUTER JOIN pSampleRequestSubmitStatus a ON	b.[Status] = a.StatusID
		LEFT OUTER JOIN uTradePartner c ON	b.TradePartnerID = c.TradePartnerID
		LEFT OUTER JOIN uTradePartnerVendor d ON	b.TradePartnerVendorID = d.TradePartnerVendorID
	WHERE b.SampleRequestSubmitID = @SampleRequestSubmitID
	
	/*Get the name of the sample submit type*/
	SELECT	@SampleSubmitType = GroupName
	FROM	pSampleWorkflow
	WHERE	(SampleWorkflowID = @SampleWorkflowID)	
	
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
		CAST(Year(@VendorDate) AS nvarchar(10)) SET	@ReviewedDate = CAST(Month(@ReviewedDate) AS nvarchar(10)) + '/' +
		CAST(Day(@ReviewedDate) AS nvarchar(10)) + '/' +
		CAST(Year(@ReviewedDate) AS nvarchar(10))


	/*Do counts to find out if there are any records.*/
	SELECT @Count = COUNT(*)
	FROM pSampleRequestMaterial a
		LEFT OUTER JOIN pSampleRequestSubmitStatus b ON	a.Status = b.StatusID
		RIGHT OUTER JOIN pSampleRequestSubmit c ON	a.SampleRequestWorkflowID = c.SampleRequestWorkflowID
		LEFT OUTER JOIN pSampleWorkflow d ON	c.SampleWorkflowID = d.SampleWorkflowID
		LEFT OUTER JOIN pStyleMaterials e ON	a.StyleID = e.StyleID
												AND a.StyleMaterialID = e.StyleMaterialID
		LEFT OUTER JOIN pComponentType f ON	a.MaterialType = f.ComponentTypeID
	WHERE c.SampleRequestSubmitID = @SampleRequestSubmitID


	/*Final Select statement.*/
	IF (@Count <> 0)
		BEGIN
			SELECT
				a.MaterialNo,
				a.MaterialName,
				a.MaterialSize,
				b.[Status],
				a.Submit,
				@HeadingStr AS HeadingStr,
				d.GroupName + ' Comment' AS CommentTitle,
				d.GroupName AS Title,
				c.Comment AS Comments,
				e.Placement,
				f.ComponentDescription,
				@StatusDescription AS StatusDescription,
				@DueDate AS DueDate,
				@ReceivedBy AS ReceivedBy,
				@ReceivedDate AS ReceivedDate,
				@ApprovedBy AS ApprovedBy,
				@ApprovedDate AS ApprovedDate,
				@ReviewedBy AS ReviewedBy,
				@ReviewedDate AS ReviewedDate,
				@VendorBy AS VendorBy,
				@VendorDate AS VendorDate,
				@TradePartnerName AS TradePartnerName,
				@VendorName AS VendorName
			FROM pSampleRequestMaterial a
				LEFT OUTER JOIN pSampleRequestSubmitStatus b ON	a.[Status] = b.StatusID
				RIGHT OUTER JOIN pSampleRequestSubmit c ON	a.SampleRequestWorkflowID = c.SampleRequestWorkflowID
				LEFT OUTER JOIN pSampleWorkflow d ON	c.SampleWorkflowID = d.SampleWorkflowID
				LEFT OUTER JOIN pStyleMaterials e ON	a.StyleID = e.StyleID
														AND a.StyleMaterialID = e.StyleMaterialID
				LEFT OUTER JOIN pComponentType f ON	a.MaterialType = f.ComponentTypeID
			WHERE c.SampleRequestSubmitID = @SampleRequestSubmitID
			ORDER BY f.ComponentDescription, a.MaterialName
		END
	ELSE IF (@Count = 0)
		BEGIN
			SELECT
				NULL AS MaterialNo,
				NULL AS MaterialName,
				NULL AS MaterialSize,
				a.[Status],
				NULL AS Submit,
				@HeadingStr AS HeadingStr,
				e.GroupName + ' Comment' AS CommentTitle,
				e.GroupName AS Title,
				b.Comment AS Comments,
				NULL AS Placement,
				NULL AS ComponentDescription,
				@StatusDescription AS StatusDescription,
				@DueDate AS DueDate,
				@ReceivedBy AS ReceivedBy,
				@ReceivedDate AS ReceivedDate,
				@ApprovedBy AS ApprovedBy,
				@ApprovedDate AS ApprovedDate,
				@ReviewedBy AS ReviewedBy,
				@ReviewedDate AS ReviewedDate,
				@VendorBy AS VendorBy,
				@VendorDate AS VendorDate,
				@TradePartnerName AS TradePartnerName,
				@VendorName AS VendorName
			FROM pSampleRequestSubmit b
				LEFT OUTER JOIN pSampleRequestSubmitStatus a	ON b.[Status] = a.StatusID
				LEFT OUTER JOIN uTradePartner c	ON b.TradePartnerID = c.TradePartnerID
				LEFT OUTER JOIN uTradePartnerVendor d	ON b.TradePartnerVendorID = d.TradePartnerVendorID
				LEFT OUTER JOIN pSampleWorkflow e	ON b.SampleWorkflowID = e.SampleWorkflowID
			WHERE b.SampleRequestSubmitID = @SampleRequestSubmitID
		END


END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04992', GetDate())
GO
