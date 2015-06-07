IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmit_Image_SELECT]
(
	@SampleRequestSubmitID nvarchar(50)
)
AS


DECLARE @SampleRequestTradeID nvarchar(50)
DECLARE @SampleWorkflowID nvarchar(5)
DECLARE	@Submit int
DECLARE	@StyleID nvarchar(50)
DECLARE @StyleSet int
 

/*Get some other variables needed.*/
IF EXISTS (SELECT * FROM pSampleRequestSubmitBOM WHERE SampleRequestSubmitID = @SampleRequestSubmitID)
BEGIN
	SELECT
		@SampleRequestTradeID = SampleRequestTradeID,
		@SampleWorkflowID = SampleWorkflowID,
		@Submit = Submit,
		@StyleID = StyleID,
		@StyleSet = StyleSet
	FROM pSampleRequestSubmitBOM
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
END
ELSE
BEGIN
	SELECT
		@SampleRequestTradeID = SampleRequestTradeID,
		@SampleWorkflowID = SampleWorkflowID,
		@Submit = Submit,
		@StyleID = StyleID,
		@StyleSet = StyleSet
	FROM pSampleRequestSubmit
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
END

CREATE TABLE #TemppSampleRequestSubmitImage
(
	TableRow int identity(0,1),
	FilePath nvarchar(max),
	[Description] nvarchar(max),
	MUser nvarchar(200),
	MDate datetime
)

INSERT INTO #TemppSampleRequestSubmitImage
	(FilePath
	,Description
	,MUser
	,MDate)
SELECT
	dbo.fnx_GetStreamingSampleImagePath(SampleRequestTradeID, TradePartnerVendorID, SampleRequestSubmitImageID, ImageID, '2000') AS FilePath	--Comment #01
	,ImageDescription
	,MUser
	,MDate
FROM pSampleRequestSubmitImage
WHERE StyleID = @StyleID AND
StyleSet = @StyleSet AND
SampleRequestTradeID = @SampleRequestTradeID AND
SampleWorkflowID = @SampleWorkflowID AND
Submit = @Submit
ORDER BY MDate, ImageFile

SELECT TableRow, TableRow / 2 AS Row, TableRow % 2 AS [Column], FilePath, [Description], MUser, MDate
FROM #TemppSampleRequestSubmitImage
ORDER BY TableRow

DROP TABLE #TemppSampleRequestSubmitImage



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10130', GetUTCDate())
GO