IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'rpx_SampleRequestSubmit_Material_VendorComments_SELECT')
   DROP PROCEDURE rpx_SampleRequestSubmit_Material_VendorComments_SELECT
GO

CREATE PROCEDURE [rpx_SampleRequestSubmit_Material_VendorComments_SELECT]
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

/*Start by grabbing some information.*/
SELECT
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

/*Final Select statement.*/
SELECT
	a.MaterialNo,
	a.MaterialName,
	a.MaterialSize,
	b.Status,
	a.Submit,
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
	LEFT OUTER JOIN pSampleRequestSubmitStatus b ON	a.Status = b.StatusID
	RIGHT OUTER JOIN pSampleRequestSubmit c ON	a.SampleRequestWorkflowID = c.SampleRequestWorkflowID
	LEFT OUTER JOIN pSampleWorkflow d ON	c.SampleWorkflowID = d.SampleWorkflowID
	LEFT OUTER JOIN pStyleMaterials e ON	a.StyleID = e.StyleID
											AND a.StyleMaterialID = e.StyleMaterialID
	LEFT OUTER JOIN pComponentType f ON	a.MaterialType = f.ComponentTypeID
WHERE c.SampleRequestSubmitID = @SampleRequestSubmitID
ORDER BY f.ComponentDescription, a.MaterialName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '898', GetDate())
GO