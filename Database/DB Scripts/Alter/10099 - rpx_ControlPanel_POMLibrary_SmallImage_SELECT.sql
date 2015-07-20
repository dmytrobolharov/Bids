IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_POMLibrary_SmallImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_POMLibrary_SmallImage_SELECT]
GO

CREATE  PROCEDURE [dbo].[rpx_ControlPanel_POMLibrary_SmallImage_SELECT]

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
		dbo.fnx_GetStreamingPOMImageSmallPath(POMLibraryID, '500') AS FilePath
FROM pPOMLibrary WITH (NOLOCK)
ORDER BY POM

/*Select the temporary table*/
SELECT	RowNumber / 4 AS [Row], RowNumber % 4 AS [Column], POM, PointMeasur, HowToMeasurText, FilePath
FROM	#TempHowTo
ORDER BY RowNumber

DROP TABLE #TempHowTo


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10099', GetUTCDate())
GO