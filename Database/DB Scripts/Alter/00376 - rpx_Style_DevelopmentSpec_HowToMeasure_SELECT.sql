/*
Comments:

#01 - Ryan Cabanas - September 25, 2009
	Replace the old pom image string with the new image string using function.
Deleted old code.
*/



ALTER    PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_HowToMeasure_SELECT]
(
	@StyleSet int,
	@StyleID varchar(50)
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
		dbo.fnx_GetStreamingPOMImageSmallPath(b.POMLibraryID) AS FilePath,	--Comment #01
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
VALUES     ('DB_Version', '4.0.0000', '376', GetDate())
GO