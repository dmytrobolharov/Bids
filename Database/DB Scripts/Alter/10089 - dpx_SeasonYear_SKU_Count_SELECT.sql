IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SeasonYear_SKU_Count_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SeasonYear_SKU_Count_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SeasonYear_SKU_Count_SELECT]
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


/************************/
/*Create temp table.	*/
/************************/
CREATE TABLE #tempFinal(
	Season nvarchar(50)
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
	,ParamStyleCategory nvarchar(255))


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
	,FilePath)
SELECT
	pSeasonYear.Season
	,pSeasonYear.[Year]
	,pStyleCategory.StyleCategory
	,pStyleHeader.StyleNo
	,pStyleHeader.[Description]
	,pStyleColorway.StyleColorName
	,pStyleColorway.StyleColorNo
	,dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000) AS FilePath		--Comment #01
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
FROM #tempFinal


/********************/
/*Drop temp table.	*/
/********************/
DROP TABLE #tempFinal


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10089', GetUTCDate())
GO