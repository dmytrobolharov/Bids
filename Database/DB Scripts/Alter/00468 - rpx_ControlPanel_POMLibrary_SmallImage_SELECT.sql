/*
Comments:

#01 - Ryan Cabanas - September 25, 2009
	Replace the old pom image string with the new image string using function.
Deleted old code.

#02 - Ryan Cabanas - September 25, 2009
	Smaller image version of this procedure.
*/



ALTER  PROCEDURE [dbo].[rpx_ControlPanel_POMLibrary_SmallImage_SELECT]

AS


/*Creat temporary table*/
CREATE     TABLE #TempHowTo
(	
	RowNumber int identity(0,1),
	POM nvarchar(5),
	PointMeasur nvarchar(200),
	HowToMeasurText nvarchar(4000),
	FilePath nvarchar(255)
)


/*Insert values into the temporary table*/
INSERT INTO #TempHowTo(POM, PointMeasur, HowToMeasurText, FilePath)
SELECT	POM,
		PointMeasur,
		HowToMeasurText,
		dbo.fnx_GetStreamingPOMImageSmallPath(POMLibraryID) AS FilePath	--Comment #01, #02
FROM pPOMLibrary WITH (NOLOCK)
ORDER BY POM

/*Select the temporary table*/
SELECT	RowNumber / 4 AS [Row], RowNumber % 4 AS [Column], POM, PointMeasur, HowToMeasurText, FilePath
FROM	#TempHowTo
ORDER BY RowNumber

DROP TABLE #TempHowTo
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '468', GetDate())
GO