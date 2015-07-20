/*
Comments:

General - Ryan Cabanas - June 15, 2009
	Initial creation of the procedure.

#01 - Ryan Cabanas - October 21, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SeasonYear_SKU_Count_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SeasonYear_SKU_Count_Summary_SELECT]
GO


CREATE PROCEDURE [dbo].[dpx_SeasonYear_SKU_Count_Summary_SELECT]
(
	@Season nvarchar(50)
	,@Year nvarchar(20)
	,@StyleCategory nvarchar(255)
)

AS


--/************/
--/*TESTING	*/
--/************/
--BEGIN
--	DECLARE @Season nvarchar(50)
--	DECLARE @Year nvarchar(20)
--	DECLARE @StyleCategory nvarchar(255)
--	SET @Season = ''
--	SET @Year = ''
--	SET @StyleCategory = ''
--END


/****************************/
/*Default the parameters.	*/
/****************************/
BEGIN
	IF(@Season IS NULL OR @Season = '')
		BEGIN
			SET @Season = '(ALL)'
		END

	IF(@Year IS NULL OR @Year = '')
		BEGIN
			SET @Year = '(ALL)'
		END

	IF(@StyleCategory IS NULL OR @StyleCategory = '')
		BEGIN
			SET @StyleCategory = '(ALL)'
		END
END


/********************/
/*Create variables.	*/
/********************/
BEGIN
	DECLARE @TotalCount int
	DECLARE @RowCounter int

	DECLARE @MatrixColumn int
	DECLARE @MatrixRow int

	DECLARE @MatrixMaxColumn int
END


/********************************************************/
/*Set the max number of columns for the report matrix.	*/
/********************************************************/
BEGIN
	SET @MatrixMaxColumn = 4
END


/************************/
/*Create temp tables.	*/
/************************/
CREATE TABLE #tempFinal(
	TableRow int identity(1,1)
	,Season nvarchar(50)
	,[Year] nvarchar(20)
	,SeasonYear nvarchar(100)
	,StyleCategory nvarchar(255)
	,StyleNo nvarchar(50)
	,[Description] nvarchar(100)
	,StyleColorName nvarchar(200)
	,StyleColorNo nvarchar(200)
	,FilePath nvarchar(255)
	,ParamSeason nvarchar(50)
	,ParamYear nvarchar(20)
	,ParamStyleCategory nvarchar(255)
	,MatrixColumn int
	,MatrixRow int
	,SeasonCustomSort nvarchar(20))

CREATE TABLE #tempMatrixSorting(
	TableRow int identity(0,1)
	,Season nvarchar(50)
	,[Year] nvarchar(20)
	,SeasonYear nvarchar(100)
	,SeasonCustomSort nvarchar(20)
	,MatrixColumn int
	,MatrixRow int)


/****************************************/
/*Get records and put in temp table.	*/
/****************************************/
INSERT INTO #tempFinal(
	Season
	,[Year]
	,StyleCategory
	,StyleNo
	,[Description]
	,StyleColorName
	,StyleColorNo
	,FilePath
	,SeasonCustomSort)
SELECT
	pSeasonYear.Season
	,pSeasonYear.[Year]
	,pStyleCategory.StyleCategory
	,pStyleHeader.StyleNo
	,pStyleHeader.[Description]
	,pStyleColorway.StyleColorName
	,pStyleColorway.StyleColorNo
	,dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version]) AS FilePath		--Comment #01
	,pSeason.CustomSort AS SeasonCustomSort
FROM pSeasonYear
	LEFT OUTER JOIN pSeason ON pSeasonYear.Season = pSeason.Custom
	INNER JOIN pStyleSeasonYear ON	pSeasonYear.SeasonYearID = pStyleSeasonYear.SeasonYearID
	INNER JOIN pStyleHeader ON	pStyleSeasonYear.StyleID = pStyleHeader.StyleID
	INNER JOIN pStyleCategory ON	pStyleHeader.StyleCategory = pStyleCategory.StyleCategoryID
	INNER JOIN pStyleColorwaySeasonYear ON	pStyleSeasonYear.StyleSeasonYearID = pStyleColorwaySeasonYear.StyleSeasonYearID
											AND pStyleSeasonYear.StyleID = pStyleColorwaySeasonYear.StyleID
	INNER JOIN pStyleColorway ON	pStyleColorwaySeasonYear.StyleColorwayID = pStyleColorway.StyleColorID
	LEFT OUTER JOIN hImage ON	pStyleHeader.DesignSketchID = hImage.ImageID
								AND pStyleHeader.DesignSketchVersion = hImage.Version
WHERE	((pSeasonYear.Season = @Season)
		OR (@Season = '(ALL)'))
	AND ((pSeasonYear.[Year] = @Year)
		OR (@Year = '(ALL)'))
	AND	((pStyleCategory.StyleCategory = @StyleCategory)
		OR (@StyleCategory = '(ALL)'))
ORDER BY pSeasonYear.[Year]				--Season/Year sorting
		,pSeason.CustomSort				--Season/Year sorting
		,pSeason.Custom					--Season/Year sorting
		,pStyleCategory.Sort			--Category sorting
		,pStyleCategory.StyleCategory	--Category sorting
		,pStyleHeader.StyleNo			--Style sorting
		,pStyleColorway.Sort			--Colorway sorting
		,pStyleColorway.StyleColorName	--Colorway sorting


/************************************************************************/
/*Combine the 'Season' and 'Year' fields to make a 'SeasonYear' field.	*/
/************************************************************************/
BEGIN
	UPDATE #tempFinal
	SET SeasonYear = Season + ' ' + [Year]
END


/****************************************************/
/*Update the temp table with the parameter values.	*/
/****************************************************/
BEGIN
	UPDATE #tempFinal
	SET ParamSeason = @Season
		,ParamYear = @Year
		,ParamStyleCategory = @StyleCategory
END


/****************************************************/
/*Get records and begin sorting for report matrix.	*/
/****************************************************/
BEGIN
	/*Get Season/Year groupings.*/
	INSERT INTO #tempMatrixSorting(
		Season
		,[Year]
		,SeasonYear
		,SeasonCustomSort)
	SELECT
		Season
		,[Year]
		,SeasonYear
		,SeasonCustomSort
	FROM #tempFinal
	GROUP BY Season
		,[Year]
		,SeasonYear
		,SeasonCustomSort
	ORDER BY [Year]
		,SeasonCustomSort
		,Season

	/*Set the counters.*/
	SELECT @TotalCount = COUNT(*) FROM #tempMatrixSorting
	SET @RowCounter = 0

	/*Set the matrix column and row.*/
	SET @MatrixColumn = 0
	SET @MatrixRow = 0

	/*Loop through and assign matrix column and row to group .*/
	WHILE(@RowCounter < @TotalCount)
		BEGIN
			/*Columns.*/
			WHILE(@MatrixColumn < @MatrixMaxColumn AND @RowCounter < @TotalCount)
				BEGIN
					/*Write the matrix column and row values.*/
					UPDATE #tempMatrixSorting
					SET MatrixColumn = @MatrixColumn
						,MatrixRow = @MatrixRow
					WHERE TableRow = @RowCounter

					/*Up the row counter and matrix column.*/
					SET @MatrixColumn = @MatrixColumn + 1
					SET @RowCounter = @RowCounter + 1
				END

			/*Up the matrix row.*/
			SET @MatrixRow = @MatrixRow + 1

			/*Reset the matrix column because you're on a new row.*/
			SET @MatrixColumn = 0
		END
END


/************************************************************************/
/*Take the finalized matrix sortings and assign to final temp table.	*/
/************************************************************************/
BEGIN
	/*Update.*/
	UPDATE #tempFinal
	SET #tempFinal.MatrixColumn = #tempMatrixSorting.MatrixColumn
		,#tempFinal.MatrixRow = #tempMatrixSorting.MatrixRow
	FROM #tempFinal
		INNER JOIN #tempMatrixSorting ON	#tempFinal.SeasonYear = #tempMatrixSorting.SeasonYear
END


/****************/
/*Final select.	*/
/****************/
SELECT
	Season
	,[Year]
	,SeasonYear
	,StyleCategory
	,StyleNo
	,[Description]
	,StyleColorName
	,StyleColorNo
	,FilePath
	,ParamSeason
	,ParamYear
	,ParamStyleCategory
	,MatrixColumn
	,MatrixRow
FROM #tempFinal


/********************/
/*Drop temp table.	*/
/********************/
DROP TABLE #tempFinal
DROP TABLE #tempMatrixSorting
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '177', GetDate())

GO
