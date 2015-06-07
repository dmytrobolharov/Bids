IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_HowToMeasure_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_HowToMeasure_SELECT]
GO

CREATE	PROCEDURE [dbo].[rpx_SampleRequestSubmit_HowToMeasure_SELECT]
(
	@SampleRequestSubmitID nvarchar(50)
)
AS


DECLARE @SampleRequestTradeID nvarchar(50)
DECLARE @SampleWorkflowID nvarchar(5)
DECLARE @StyleSet int 
DECLARE @Submit int
DECLARE @StyleID nvarchar(50)

/*Get the remaining variables needed.*/
SELECT
	@SampleRequestTradeID = SampleRequestTradeID,
	@SampleWorkflowID = SampleWorkflowID,
	@StyleSet = StyleSet,
	@Submit = Submit,
	@StyleID = StyleID
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitID = @SampleRequestSubmitID

/*Creat temporary table*/
CREATE       TABLE #TempHowTo
(
	RowNumber int identity(0,1),
	POM nvarchar(5),
	PointMeasur nvarchar(200),
	HowToMeasurText nvarchar(4000),
	FilePath nvarchar(255),
	Sort nvarchar(5)
)


/*Insert values into the temporary table*/
INSERT INTO #TempHowTo(POM, PointMeasur, HowToMeasurText, FilePath, Sort)
SELECT	pSampleRequestSpecItem.POM,
	pSampleRequestSpecItem.PointMeasur,
	pPOMLibrary.HowToMeasurText,
	dbo.fnx_GetStreamingPOMImageSmallPath(pPOMLibrary.POMLibraryID, '500') AS FilePath,
	pSampleRequestSpecItem.Sort
FROM	pSampleRequestSpecItem INNER JOIN pPOMLibrary ON
	pSampleRequestSpecItem.POM = pPOMLibrary.POM
WHERE	(pSampleRequestSpecItem.StyleID = @StyleID) AND
	(pSampleRequestSpecItem.SampleRequestTradeID = @SampleRequestTradeID) AND
	(pSampleRequestSpecItem.SampleWorkflowID = @SampleWorkflowID) AND
	(pSampleRequestSpecItem.Submit = @Submit) AND
	(pSampleRequestSpecItem.Ask <>0) AND
	(pSampleRequestSpecItem.StyleSet = @StyleSet)
ORDER BY	pSampleRequestSpecItem.Sort

/*Select the temporary table*/
SELECT	Sort, RowNumber / 3 AS [Rows], RowNumber % 3 AS [Columns], POM, PointMeasur, HowToMeasurText, FilePath
FROM	#TempHowTo
ORDER BY Sort, [Columns] DESC

DROP TABLE #TempHowTo


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10129', GetUTCDate())
GO