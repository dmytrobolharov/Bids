IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_SeasonalMaterialColorway_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_SeasonalMaterialColorway_SELECT]
GO

/*
Comments:

#01 - Ryan Cabanas - 6/25/2008 - Feature #313

	Burberry wants to see the SAP Code in the Colorway report.  There is a custom "BB_Style_MaterialColorway_Body_LLT.rdl" that is going to
use this SAP Code.  Just needed to add that field to this query.  There were 3 changes to this procedure.  Parts A, B, and C.  Field "SAPCode"
was added to these three sections.  A - was to add the field to the temp table.  B - was to add the field to the INSERT and SELECT portion
of the statement.  C - was to select the field in the final SELECT statement.

#02 - Ryan Cabanas - 1/15/2009
	When an a chip was added from the Image Folder, the 'ColorName' field was getting updated with the Image Number.  Clay isn't sure why it
was set up this way, but he said it shouldn't be this way.  I've commented it out here.

#03 - Ryan Cabanas - June 8, 2009
	This new procedure has been created 'rpx_Style_SeasonalMaterialColorway_SELECT' for the new Seasonal Colorway
feature that we now have.

#04 - Ryan Cabanas - September 28, 2009
	Need to add new fields to the temp table to hold the sort values that are used so that sorting can be
worked with later when creating the Row and Column values.

#05 - Ryan Cabanas - September 28, 2009
	Create a couple of temp table to handle sorting for the materials and the colors.  These will be used
to do proper sorting at the final SELECT.  Commented out the old sorting in the initial INSERT/SELECT.

#06 - Ryan Cabanas - September 28, 2009
	Need to add a 'Group Color Column' that will keep the colors together in the report as the priority.
Also need to do this for Landscape reports versus Portrait reports.

#07 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#08 - Ryan Cabanas - September 23, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
*/


CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmit_SeasonalMaterialColorway_SELECT]
(
	@SampleRequestSubmitId NVARCHAR(50)
)
AS


--/*Testing.*/
--BEGIN
--	DECLARE @SampleRequestSubmitId NVARCHAR(50)
--	SET @SampleRequestSubmitId = '8BB4C4BB-3401-4617-B367-64A0F8126066'
--END


/****************************************************************/
/*Get some initial variables to perform the remaining logic.	*/
/****************************************************************/
--Variables.
DECLARE @StyleID varchar(255)
DECLARE @StyleSet int
DECLARE @SeasonYearID varchar(255)

DECLARE @SampleRequestTradeId NVARCHAR(50)
DECLARE @StyleSeasonYearId NVARCHAR(50)

--Get @StyleId, @StyleSet, and @SampleRequestTradeId.
SELECT @StyleId = StyleId
	,@StyleSet = StyleSet
	,@SampleRequestTradeId = SampleRequestTradeId
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitId = @SampleRequestSubmitId

--Get @StyleSeasonYearId.
SELECT @StyleSeasonYearId = StyleSeasonYearId
FROM pSampleRequestTrade
WHERE SampleRequestTradeId = @SampleRequestTradeId

--Get @SeasonYearId.
SELECT @SeasonYearID = SeasonYearID
FROM pStyleSeasonYear
WHERE StyleSeasonYearId = @StyleSeasonYearId


/*****************/
/*Comment #01 - A*/
/*****************/
--Create temp table.
CREATE TABLE #tempTable
(
	TableRow int identity(0,1)
	,MaterialDescription varchar(255)
	,StyleMaterialId varchar(50)
	,Placement nvarchar(1000)
	,MainColor varchar(255)
	,SAPCode varchar(50)
	,Qty varchar(18)
	,MaterialSize varchar(200)
	,ColorName varchar(150)
	,ColorCode varchar(50)
	,FilePath varchar(255)
	,MaterialColorNote nvarchar(1000)
	,MaterialColorImageID varchar(50)
	,MaterialColorImageVersion int
	,StyleColorSort nvarchar(10)		--Comment #04
	,StyleColorName nvarchar(200)		--Comment #04
	,StyleColorID nvarchar(200)			--Comment #04
	,MainMaterial int					--Comment #04
	,MaterialType int					--Comment #04
	,MaterialSort varchar(5)			--Comment #04
	,MaterialNo nvarchar(50)			--Comment #04
	,Row int							--Comment #04
	,[Column] int						--Comment #04
	,GroupColorColumnLandscape int		--Comment #06
	,GroupColorColumnPortrait int		--Comment #06
)

--Comment #05
CREATE TABLE #tempMaterialSort(
	TableRow int identity(0,1)
	,StyleMaterialId varchar(50)
	,MainMaterial int
	,MaterialType int
	,MaterialSort varchar(5)
	,MaterialNo nvarchar(50)
)

--Comment #05
CREATE TABLE #tempColorSort(
	TableRow int identity(0,1)
	,MainColor varchar(50)
	,StyleColorSort nvarchar(10)
	,StyleColorName nvarchar(200)
	,StyleColorID nvarchar(200)
	,GroupColorColumnLandscape int	--Comment #06
	,GroupColorColumnPortrait int	--Comment #06
)


/*****************/
/*Comment #01 - B*/
/*****************/
--Get the material colorway squares and put them in the temp table.
INSERT INTO #tempTable(
	MaterialDescription
	,StyleMaterialId
	,Placement
	,MainColor
	,SAPCode
	,Qty
	,MaterialSize
	,ColorName
	,ColorCode
	,FilePath
	,MaterialColorNote
	,MaterialColorImageID
	,MaterialColorImageVersion
	,StyleColorSort			--Comment #04
	,StyleColorName			--Comment #04
	,StyleColorID			--Comment #04
	,MainMaterial			--Comment #04
	,MaterialType			--Comment #04
	,MaterialSort			--Comment #04
	,MaterialNo				--Comment #04
)
SELECT
	('(' + pStyleMaterials.MaterialNo + ') ' + pStyleMaterials.MaterialName) AS MaterialDescription
	,CAST(pStyleMaterials.StyleMaterialId AS varchar(50)) AS StyleMaterialId
	,pStyleMaterials.Placement
	,isnull('(' + pStyleColorway.StyleColorNo + ') ','') +  pStyleColorway.MainColor AS MainColor
	,pStyleColorway.SAPCode
	,pStyleMaterials.Qty
	,ISNULL(pMaterialSize.MaterialSize, '*NA') AS MaterialSize
	,pMaterialColor.ColorName
	,pMaterialColor.ColorCode
	,dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID) AS FilePath	--Comment #08
	,pMaterialColor.MaterialColorNote
	,pMaterialColor.MaterialColorImageID
	,pMaterialColor.MaterialColorImageVersion
	,pStyleColorway.Sort AS StyleColorSort						--Comment #04
	,pStyleColorway.StyleColorName								--Comment #04
	,CAST(pStyleColorway.StyleColorID AS nvarchar(200))			--Comment #04
	,pStyleMaterials.MainMaterial								--Comment #04
	,pStyleMaterials.MaterialType								--Comment #04
	,pStyleMaterials.MaterialSort								--Comment #04
	,pStyleMaterials.MaterialNo									--Comment #04
FROM pStyleColorway
	LEFT OUTER JOIN pStyleMaterials ON	pStyleColorway.StyleID = pStyleMaterials.StyleID
										AND pStyleMaterials.Colorway = 1
	LEFT OUTER JOIN pStyleColorwayItem ON	pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID
											AND pStyleMaterials.StyleSet = pStyleColorwayItem.StyleSet
											AND pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID
	LEFT OUTER JOIN pMaterialColor ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pStyleColorwaySeasonYear ON	pStyleColorway.StyleID = pStyleColorwaySeasonYear.StyleID						--Comment #03
											AND pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID		--Comment #03
	INNER JOIN pStyleSeasonYear ON	pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID			--Comment #03
									AND pStyleColorwaySeasonYear.StyleID = pStyleSeasonYear.StyleID							--Comment #03
	LEFT OUTER JOIN pMaterialSize ON	pStyleMaterials.MaterialSizeId = pMaterialSize.MaterialSizeId
WHERE pStyleColorway.StyleID = @StyleID
	AND pStyleColorwayItem.StyleSet = @StyleSet
	AND pStyleSeasonYear.SeasonYearID = @SeasonYearID
--ORDER BY pStyleColorway.Sort				--Comment #05
--	,pStyleColorway.StyleColorName			--Comment #05
--	,pStyleColorway.StyleColorID			--Comment #05
--	,pStyleMaterials.MainMaterial DESC		--Comment #05
--	,pStyleMaterials.MaterialType			--Comment #05
--	,pStyleMaterials.MaterialSort			--Comment #05
--	,pStyleMaterials.MaterialNo				--Comment #05

--Update the temp folder for the chips that are images from the Image folder.
UPDATE #tempTable
SET FilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #07
--	ColorName = '(' + hImage.ImageNo + ')'  --Comment #02
FROM #tempTable
	INNER JOIN hImage ON	(#tempTable.MaterialColorImageID = hImage.ImageID
							AND #tempTable.MaterialColorImageVersion = hImage.Version)


--Update the temp table to include the "Die To Match (DTM)" feature request.
UPDATE #tempTable
SET ColorCode = ''
WHERE (ColorName IS NULL)
	AND (ColorCode IS NULL)
	AND (FilePath IS NULL)


--Comment #05
BEGIN
	/*Get the materials and put them in temp table to sort.*/
	INSERT INTO #tempMaterialSort(
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	)
	SELECT
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	FROM #tempTable
	GROUP BY
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	ORDER BY 
		MainMaterial DESC
		,MaterialType
		,MaterialSort
		,MaterialNo

	/*Get the colors and put them in temp table to sort.*/
	INSERT INTO #tempColorSort(
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	)
	SELECT
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	FROM #tempTable
	GROUP BY
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	ORDER BY 
		StyleColorSort
		,StyleColorName
		,StyleColorID

	--Comment #06
	/*Declare variables.*/
	DECLARE @TotalCount int
	DECLARE @RowCounter int
	DECLARE @GroupCountLandscape int
	DECLARE @GroupCutOffLandscape int
	DECLARE @GroupCountPortrait int
	DECLARE @GroupCutOffPortrait int

	--Comment #06
	/*Get counts.*/
	SELECT @TotalCount = COUNT(*) from #tempColorSort
	SET @RowCounter = 0
	SET @GroupCountLandscape = 0
	SET @GroupCutOffLandscape = 6
	SET @GroupCountPortrait = 0
	SET @GroupCutOffPortrait = 3

	--Comment #06
	/*Loop to set 'Group Color Column' values.*/
	WHILE(@RowCounter < @TotalCount)
		BEGIN
			/*Update the 'Group Color Column' value.*/
			UPDATE #tempColorSort
			SET GroupColorColumnLandscape = @GroupCountLandscape
				,GroupColorColumnPortrait = @GroupCountPortrait
			WHERE TableRow = @RowCounter

			/*Up 'Group Color Column' count, if necessary, for landscape.*/
			IF(@RowCounter % @GroupCutOffLandscape = @GroupCutOffLandscape - 1)
				BEGIN
					SET @GroupCountLandscape = @GroupCountLandscape + 1
				END

			/*Up 'Group Color Column' count, if necessary, for portrait.*/
			IF(@RowCounter % @GroupCutOffPortrait = @GroupCutOffPortrait - 1)
				BEGIN
					SET @GroupCountPortrait = @GroupCountPortrait + 1
				END

			/*Up row counter.*/
			SET @RowCounter = @RowCounter + 1
		END

	/*Update main temp table with Row and Column values.*/
	UPDATE #tempTable
	SET Row = #tempMaterialSort.TableRow
		,[Column] = #tempColorSort.TableRow
		,GroupColorColumnLandscape = #tempColorSort.GroupColorColumnLandscape
		,GroupColorColumnPortrait = #tempColorSort.GroupColorColumnPortrait
	FROM #tempTable
		INNER JOIN #tempMaterialSort	ON	#tempTable.StyleMaterialID = #tempMaterialSort.StyleMaterialID
		INNER JOIN #tempColorSort	ON	#tempTable.MainColor = #tempColorSort.MainColor
END


/*****************/
/*Comment #01 - C*/
/*****************/
--Get the desired columns from the original temp table.
SELECT
	Row		--Comment #05
	,[Column]	--Comment #05
	,GroupColorColumnLandscape	--Comment #06
	,GroupColorColumnPortrait	--Comment #06
	,MaterialDescription
	,StyleMaterialId
	,Placement
	,MainColor
	,SAPCode
	,Qty
	,MaterialSize
	,ColorName
	,ColorCode
	,FilePath
	,MaterialColorNote
FROM #tempTable
ORDER BY
	Row		--Comment #05
	,[Column]	--Comment #05


/*
SELECT *
FROM dbo.pStyleColorway INNER JOIN
    dbo.pStyleColorwayItem ON dbo.pStyleColorway.StyleColorID = dbo.pStyleColorwayItem.StyleColorID INNER JOIN
    dbo.pStyleMaterials ON dbo.pStyleColorwayItem.StyleMaterialID = dbo.pStyleMaterials.StyleMaterialID INNER JOIN
    dbo.pMaterialColor ON dbo.pStyleColorwayItem.MaterialColorID = dbo.pMaterialColor.MaterialColorID
*/

--Drop the Temp Table.
DROP TABLE #tempTable
DROP TABLE #tempMaterialSort	--Comment #05
DROP TABLE #tempColorSort		--Comment #05
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01906', GetDate())
GO