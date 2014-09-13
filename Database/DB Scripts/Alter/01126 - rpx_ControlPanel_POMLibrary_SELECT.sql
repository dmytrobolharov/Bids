/*
Comments:

#01 - Ryan Cabanas - September 25, 2009
	Replace the old pom image string with the new image string using function.
Deleted old code.
*/

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'rpx_ControlPanel_POMLibrary_SELECT')
   DROP PROCEDURE rpx_ControlPanel_POMLibrary_SELECT
GO

CREATE PROCEDURE [dbo].[rpx_ControlPanel_POMLibrary_SELECT]

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
		dbo.fnx_GetStreamingImagePOMPath(POMLibraryID) AS FilePath	--Comment #01
FROM pPOMLibrary
ORDER BY POM

/*Select the temporary table*/
SELECT	RowNumber / 4 AS [Row], RowNumber % 4 AS [Column], POM, PointMeasur, HowToMeasurText, FilePath
FROM	#TempHowTo
ORDER BY RowNumber

DROP TABLE #TempHowTo
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01126', GetDate())
GO