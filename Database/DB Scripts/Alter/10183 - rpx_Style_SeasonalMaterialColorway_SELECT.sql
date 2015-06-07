IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_SeasonalMaterialColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_SeasonalMaterialColorway_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_SeasonalMaterialColorway_SELECT]  
(
	@StyleID AS nvarchar(255), 	
	@StyleSet AS int,
	@SeasonYearID nvarchar(255)	
)
AS

BEGIN

--/*Testing.*/
--BEGIN
--	DECLARE @StyleID nvarchar(255)
--	DECLARE @StyleSet int
--	DECLARE @SeasonYearID nvarchar(255)
--	SET @StyleID = 'f5bc96b7-5dea-4a2b-936b-f8bdea47229e'
--	SET @StyleSet = 1
--	SET @SeasonYearID = 'B2965D2D-2AE5-4B8D-9B77-477728946DD9'
--END

CREATE TABLE #tempTable
(
	TableRow int identity(0,1)
	,MaterialDescription nvarchar(255)
	,StyleMaterialId nvarchar(50)
	,Placement nvarchar(4000)
	,MainColor nvarchar(400)
	,SAPCode nvarchar(200)
	,Qty nvarchar(18)
	,MaterialSize nvarchar(200)
	,ColorName nvarchar(150)
	,ColorCode nvarchar(50)
	,FilePath nvarchar(255)
	,MainColorFilePath nvarchar(255)
	,MaterialColorNote nvarchar(4000)
	,MaterialColorImageID nvarchar(50)
	,MaterialColorImageVersion int
	,StyleColorSort nvarchar(10)		
	,StyleColorName nvarchar(200)		
	,StyleColorID nvarchar(200)			
	,MainMaterial int					
	,MaterialType int					
	,MaterialSort nvarchar(5)			
	,MaterialNo nvarchar(50)			
	,Row int							
	,[Column] int						
	,GroupColorColumnLandscape int		
	,GroupColorColumnPortrait int		
	,ColorwayStatus nvarchar(100) 
	,PLMCode nvarchar(100)
)


CREATE TABLE #tempMaterialSort(
	TableRow int identity(0,1)
	,StyleMaterialId nvarchar(50)
	,MainMaterial int
	,MaterialType int
	,MaterialSort nvarchar(5)
	,MaterialNo nvarchar(50)
)


CREATE TABLE #tempColorSort(
	TableRow int identity(0,1)
	,MainColor nvarchar(400)
	,StyleColorSort nvarchar(10)
	,StyleColorName nvarchar(200)
	,StyleColorID nvarchar(200)
	,GroupColorColumnLandscape int	
	,GroupColorColumnPortrait int	
)


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
	,MainColorFilePath 
	,MaterialColorNote
	,MaterialColorImageID
	,MaterialColorImageVersion
	,StyleColorSort			
	,StyleColorName			
	,StyleColorID			
	,MainMaterial			
	,MaterialType			
	,MaterialSort			
	,MaterialNo				
	,ColorwayStatus
	,PLMCode
)
SELECT
	('(' + pStyleMaterials.MaterialNo + ') ' + pStyleMaterials.MaterialName) AS MaterialDescription
	,CAST(pStyleMaterials.StyleMaterialId AS nvarchar(50)) AS StyleMaterialId
	,pStyleMaterials.Placement
	,isnull('(' + pStyleColorway.StyleColorNo + ') ','') +  pStyleColorway.MainColor AS MainColor
	,pStyleColorway.SAPCode
	,pStyleMaterials.Qty
	,ISNULL(pMaterialSize.MaterialSize, '*NA') AS MaterialSize
	,pMaterialColor.ColorName
	,pMaterialColor.ColorCode
	,dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID,pMaterialColor.ColorPaletteID, '100') AS FilePath	
	,dbo.fnx_GetStreamingColorImagePath(pColorPalette.ColorFolderID,pStyleColorway.ColorPaletteID, '100') AS MainColorFilePath	
	,pMaterialColor.MaterialColorNote
	,pMaterialColor.MaterialColorImageID
	,pMaterialColor.MaterialColorImageVersion
	,pStyleColorway.Sort AS StyleColorSort						
	,pStyleColorway.StyleColorName								
	,CAST(pStyleColorway.StyleColorID AS nvarchar(200))			
	,pStyleMaterials.MainMaterial								
	,pStyleMaterials.MaterialType								
	,pStyleMaterials.MaterialSort								
	,pStyleMaterials.MaterialNo									
	,pStyleColorwayStatus.Status
	,pStyleColorway.PLMCode
FROM pStyleColorway
	LEFT OUTER JOIN pStyleMaterials ON	pStyleColorway.StyleID = pStyleMaterials.StyleID
										AND pStyleMaterials.Colorway = 1
	LEFT OUTER JOIN pStyleColorwayItem ON	pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID
											AND pStyleMaterials.StyleSet = pStyleColorwayItem.StyleSet
											AND pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID
	LEFT OUTER JOIN pMaterialColor ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pStyleColorwaySeasonYear ON	pStyleColorway.StyleID = pStyleColorwaySeasonYear.StyleID						
											AND pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID		
	INNER JOIN pStyleSeasonYear ON	pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID			
									AND pStyleColorwaySeasonYear.StyleID = pStyleSeasonYear.StyleID							
	LEFT OUTER JOIN pMaterialSize ON	pStyleMaterials.MaterialSizeId = pMaterialSize.MaterialSizeId
	LEFT OUTER JOIN pColorPalette ON pStyleColorway.ColorPaletteID=pColorPalette.ColorPaletteID 
	LEFT OUTER JOIN pStyleColorwayStatus  ON pStyleColorwayStatus.StatusID = pStyleColorwaySeasonYear.StyleColorStatus
WHERE pStyleColorway.StyleID = @StyleID
	AND pStyleColorwayItem.StyleSet = @StyleSet
	AND pStyleSeasonYear.SeasonYearID = @SeasonYearID

--Update the temp folder for the chips that are images from the Image folder.
UPDATE #tempTable
SET FilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000)	
--	ColorName = '(' + hImage.ImageNo + ')'  
FROM #tempTable
	INNER JOIN hImage ON	(#tempTable.MaterialColorImageID = hImage.ImageID
							AND #tempTable.MaterialColorImageVersion = hImage.Version)


--Update the temp table to include the "Die To Match (DTM)" feature request.
UPDATE #tempTable
SET ColorCode = ''
WHERE (ColorName IS NULL)
	AND (ColorCode IS NULL)
	AND (FilePath IS NULL)



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

	
	/*Declare variables.*/
	DECLARE @TotalCount int
	DECLARE @RowCounter int
	DECLARE @GroupCountLandscape int
	DECLARE @GroupCutOffLandscape int
	DECLARE @GroupCountPortrait int
	DECLARE @GroupCutOffPortrait int

	
	/*Get counts.*/
	SELECT @TotalCount = COUNT(*) from #tempColorSort
	SET @RowCounter = 0
	SET @GroupCountLandscape = 0
	SET @GroupCutOffLandscape = 6
	SET @GroupCountPortrait = 0
	SET @GroupCutOffPortrait = 3

	
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

--Get the desired columns from the original temp table.
SELECT
	Row		
	,[Column]	
	,GroupColorColumnLandscape	
	,GroupColorColumnPortrait	
	,MaterialDescription
	,StyleMaterialId
	,Placement
	,MainColor
	,MainColorFilePath
	,SAPCode
	,Qty
	,MaterialSize
	,ColorName
	,ColorCode
	,FilePath
	,MaterialColorNote
	,ColorwayStatus
	,PLMCode
FROM #tempTable
ORDER BY
	Row		
	,[Column]	

--Drop the Temp Table.
DROP TABLE #tempTable
DROP TABLE #tempMaterialSort	
DROP TABLE #tempColorSort		


END
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10183', GetUTCDate())
GO