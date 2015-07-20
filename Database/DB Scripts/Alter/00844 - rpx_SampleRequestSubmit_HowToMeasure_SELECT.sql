/*
Comments:

#01 - Ryan Cabanas - September 25, 2009
	Replace the old pom image string with the new image string using function.
Deleted old code.
*/




ALTER	PROCEDURE [dbo].[rpx_SampleRequestSubmit_HowToMeasure_SELECT]
(
	@SampleRequestSubmitID varchar(50)
)
AS


DECLARE @SampleRequestTradeID varchar(50)
DECLARE @SampleWorkflowID nvarchar(5)
DECLARE @StyleSet int 
DECLARE @Submit int
DECLARE @StyleID varchar(50)

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
	dbo.fnx_GetStreamingPOMImageSmallPath(pPOMLibrary.POMLibraryID) AS FilePath,	--Comment #01
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
VALUES     ('DB_Version', '4.0.0000', '844', GetDate())
GO