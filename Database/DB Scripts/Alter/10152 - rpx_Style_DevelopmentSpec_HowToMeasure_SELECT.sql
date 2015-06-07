IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DevelopmentSpec_HowToMeasure_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_HowToMeasure_SELECT]
GO

CREATE    PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_HowToMeasure_SELECT]
(
	@StyleSet INT
	, @StyleID NVARCHAR(50)
)
AS


/*Creat temporary table*/
CREATE     TABLE #TempHowTo
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
SELECT	a.POM,
		a.PointMeasur,
		b.HowToMeasurText,
		dbo.fnx_GetStreamingPOMImageSmallPath(b.POMLibraryID, '500') AS FilePath,
		a.Sort
FROM pStyleSpec a LEFT OUTER JOIN pPOMLibrary b ON
	a.POM = b.POM
WHERE (a.StyleID = @StyleID) AND (a.StyleSet = @StyleSet)
ORDER BY a.Sort, a.POM

/*Select the temporary table*/
SELECT	Sort, RowNumber / 3 AS [Rows], RowNumber % 3 AS [Columns], POM, PointMeasur, HowToMeasurText, FilePath
FROM	#TempHowTo

DROP TABLE #TempHowTo


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10152', GetUTCDate())
GO