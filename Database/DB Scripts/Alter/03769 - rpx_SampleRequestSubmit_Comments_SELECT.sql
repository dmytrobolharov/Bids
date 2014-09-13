IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_Comments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_Comments_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE           PROCEDURE [dbo].[rpx_SampleRequestSubmit_Comments_SELECT]
(
	@SampleRequestSubmitID varchar(50)
)
AS

--Declare variables.
DECLARE	@Submit int
DECLARE @StyleSet int
DECLARE @SampleRequestWorkflowID uniqueidentifier

CREATE TABLE #tempTable
(
	TableRow int identity(1,1),
	MUser nvarchar(200),
	MDate datetime,
	SampleRequestComment varchar(8000)
)

--Get the Submit number and SampleRequestWorkflowID and StyleSet.
IF EXISTS (SELECT * FROM pSampleRequestSubmitBOM WHERE SampleRequestSubmitID = @SampleRequestSubmitID)
BEGIN
	SELECT
		@Submit = Submit,
		@StyleSet = StyleSet,
		@SampleRequestWorkflowID = SampleRequestWorkflowID
	FROM pSampleRequestSubmitBOM
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
END
ELSE
BEGIN
	SELECT
		@Submit = Submit,
		@StyleSet = StyleSet,
		@SampleRequestWorkflowID = SampleRequestWorkflowID
	FROM pSampleRequestSubmit
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
END

--Select the shared comments into the temp table.
INSERT INTO #tempTable(MUser, MDate, SampleRequestComment)
SELECT MUser, MDate, SampleRequestComment
FROM pSampleRequestComment
WHERE SampleSubmit = @Submit
	AND SampleRequestWorkflowID = @SampleRequestWorkflowID
	AND StyleSet = @StyleSet
	AND SampleCommentType = 'S'
ORDER BY MDate DESC

--Select all fields from the temp table for the report.
SELECT *
FROM #tempTable

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03769', GetDate())
GO