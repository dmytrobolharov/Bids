/*
Comments:

#01 - Ryan Cabanas - 12/2/2008
	Robbie brought up a problem with this procedure, stating that when you rip a Style Colorway workflow page report for a 2nd, 3rd, or 4th set,
the report doesn't get any results, even though there are Materials, Colorways, and color chips.  There turned out to be a couple problems.  
Overall, the problem is that 'pStyleColorway' records never have a value other than '1' for the field 'StyleSet'.  It's the Materials in the
table 'pStyleMaterials' that store the different set numbers in the 'StyleSet' field of the 'pStyleMaterials' table.  Therefore, two changes 
needed to be made to this procedure, to the SELECT statement and it's joins.
	The first problem is that on the third line of the FROM area of the SELECT statement, there was the following condition, 
"pStyleColorway.StyleSet = pStyleMaterials.StyleSet AND".  This needed to be removed because the 'StyleSet' value betweeen these two tables
will never be the same because the 'pStyleColorway' records will never have a 'StyleSet' value other than '1'.  All the colorways are essentially
housed in the first set.  So when you add a colorway to a multi-set Style, the colorways are really only added as belonging to the first set, but
they get added to all other sets when showing on screen.  Therefore, you can never have different colorways from one set to the other.
	The second problem was with the conditional line, "WHERE pStyleColorway.StyleID = @StyleID AND pStyleColorway.StyleSet = @StyleSet".  Since
the 'StyleSet' value in 'pStyleColorway' will never be anything other than '1', this is incorrect.  Therefore, the two references here needed
to be changed from pointing to the table 'pStyleColorway' to 'pStyleMaterials'.

#02 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#03 - Ryan Cabanas - September 23, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
*/


ALTER   PROCEDURE [dbo].[rpx_Style_MaterialColorwayL_SELECT]  
(
	@StyleID AS varchar(50), 	
	@StyleSet AS int
)
AS


--Create temp table.
CREATE TABLE #tempTable
(
	TableRow int identity(0,1),
	MaterialDescription varchar(255),
	StyleMaterialId varchar(50),
	Placement nvarchar(1000),
	MainColor varchar(255),
	Qty varchar(18),
	MaterialSize varchar(200),
	ColorName varchar(150),
	ColorCode varchar(50),
	FilePath varchar(255),
	MaterialColorNote nvarchar(1000),
	MaterialColorImageID varchar(50),
	MaterialColorImageVersion int
)


--Get the material colorway squares and put them in the temp table.
INSERT INTO #tempTable(
	MaterialDescription,
	StyleMaterialId,
	Placement,
	MainColor,
	Qty,
	MaterialSize,
	ColorName,
	ColorCode,
	FilePath,
	MaterialColorNote,
	MaterialColorImageID,
	MaterialColorImageVersion)
SELECT
	('(' + pStyleMaterials.MaterialNo + ') ' + pStyleMaterials.MaterialName) AS MaterialDescription, 
	CAST(pStyleMaterials.StyleMaterialId AS varchar(50)) AS StyleMaterialId,
	pStyleMaterials.Placement, 
	isnull('(' + pStyleColorway.StyleColorNo + ') ','') +  pStyleColorway.MainColor AS MainColor,
	pStyleMaterials.Qty,
	pStyleMaterials.MaterialSize,
	pMaterialColor.ColorName,
	pMaterialColor.ColorCode,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID) AS FilePath,	--Comment #03
	pMaterialColor.MaterialColorNote,
	pMaterialColor.MaterialColorImageID,
	pMaterialColor.MaterialColorImageVersion
FROM pStyleColorway WITH (NOLOCK) LEFT OUTER JOIN pStyleMaterials WITH (NOLOCK) ON
pStyleColorway.StyleID = pStyleMaterials.StyleID AND		--Comment #01
pStyleMaterials.Colorway = '1' LEFT OUTER JOIN pStyleColorwayItem WITH (NOLOCK) ON
pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID AND
pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID LEFT OUTER JOIN pMaterialColor WITH (NOLOCK) ON
pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
WHERE pStyleMaterials.StyleID = @StyleID AND pStyleMaterials.StyleSet = @StyleSet		--Comment #01
ORDER BY pStyleColorway.Sort, pStyleColorway.StyleColorName, pStyleColorway.StyleColorID,
pStyleMaterials.MainMaterial DESC, pStyleMaterials.MaterialType,
pStyleMaterials.MaterialSort, pStyleMaterials.MaterialNo

--Update the temp folder for the chips that are images from the Image folder.
UPDATE #tempTable
SET FilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version]),	--Comment #02
	ColorName = '(' + hImage.ImageNo + ')'
FROM #tempTable
	INNER JOIN hImage WITH (NOLOCK) ON	(#tempTable.MaterialColorImageID = hImage.ImageID
							AND #tempTable.MaterialColorImageVersion = hImage.Version)


--Update the temp table to include the "Die To Match (DTM)" feature request.
UPDATE #tempTable
SET ColorCode = 'DTM'
WHERE (ColorName IS NULL)
	AND (ColorCode IS NULL)
	AND (FilePath IS NULL)


--Get the desired columns from the original temp table.
SELECT
	TableRow % 3 AS [Column],
	MaterialDescription, 
	StyleMaterialId,
	Placement, 
	MainColor,
	Qty,
	MaterialSize,
	ColorName,
	ColorCode,
	FilePath,
	MaterialColorNote
FROM #tempTable


/*
SELECT *
FROM dbo.pStyleColorway WITH (NOLOCK) INNER JOIN
    dbo.pStyleColorwayItem WITH (NOLOCK) ON dbo.pStyleColorway.StyleColorID = dbo.pStyleColorwayItem.StyleColorID INNER JOIN
    dbo.pStyleMaterials WITH (NOLOCK) ON dbo.pStyleColorwayItem.StyleMaterialID = dbo.pStyleMaterials.StyleMaterialID INNER JOIN
    dbo.pMaterialColor WITH (NOLOCK) ON dbo.pStyleColorwayItem.MaterialColorID = dbo.pMaterialColor.MaterialColorID
*/

--Drop the Temp Table.
DROP TABLE #tempTable
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '849', GetDate())
GO