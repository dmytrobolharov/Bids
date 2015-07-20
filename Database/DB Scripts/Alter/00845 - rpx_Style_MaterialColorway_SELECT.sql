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

#03 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#04 - Ryan Cabanas - September 23, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.

*/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_MaterialColorway_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_Style_MaterialColorway_SELECT]
GO

CREATE  PROCEDURE [dbo].[rpx_Style_MaterialColorway_SELECT]  
(
	@StyleID AS varchar(255), 	
	@StyleSet AS int
)
AS


/*****************/
/*Comment #01 - A*/
/*****************/
--Create temp table.
CREATE TABLE #tempTable
(
	TableRow int identity(0,1),
	MaterialDescription varchar(255),
	StyleMaterialId varchar(50),
	Placement nvarchar(1000),
	MainColor varchar(255),
	SAPCode varchar(50),
	Qty varchar(18),
	MaterialSize varchar(200),
	ColorName varchar(150),
	ColorCode varchar(50),
	FilePath varchar(255),
	MaterialColorNote nvarchar(1000),
	MaterialColorImageID varchar(50),
	MaterialColorImageVersion int
)


/*****************/
/*Comment #01 - B*/
/*****************/
--Get the material colorway squares and put them in the temp table.
INSERT INTO #tempTable(
	MaterialDescription,
	StyleMaterialId,
	Placement,
	MainColor,
	SAPCode,
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
	pStyleColorway.SAPCode,
	pStyleMaterials.Qty,
	pStyleMaterials.MaterialSize,
	pMaterialColor.ColorName,
	pMaterialColor.ColorCode,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID) AS FilePath,	--Comment #04	
	pMaterialColor.MaterialColorNote,
	pMaterialColor.MaterialColorImageID,
	pMaterialColor.MaterialColorImageVersion
FROM pStyleColorway LEFT OUTER JOIN pStyleMaterials ON
pStyleColorway.StyleID = pStyleMaterials.StyleID AND
pStyleColorway.StyleSet = pStyleMaterials.StyleSet AND
pStyleMaterials.Colorway = 1 LEFT OUTER JOIN pStyleColorwayItem ON
pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID AND
pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID LEFT OUTER JOIN pMaterialColor ON
pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
WHERE pStyleColorway.StyleID = @StyleID AND pStyleColorway.StyleSet = @StyleSet
ORDER BY pStyleColorway.Sort, pStyleColorway.StyleColorName, pStyleColorway.StyleColorID,
pStyleMaterials.MainMaterial DESC, pStyleMaterials.MaterialType,
pStyleMaterials.MaterialSort, pStyleMaterials.MaterialNo

--Update the temp folder for the chips that are images from the Image folder.
UPDATE #tempTable
SET FilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version]) -- Comment 03,
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


/*****************/
/*Comment #01 - C*/
/*****************/
--Get the desired columns from the original temp table.
SELECT
	TableRow % 5 AS [Column],
	MaterialDescription, 
	StyleMaterialId,
	Placement, 
	MainColor,
	SAPCode,
	Qty,
	MaterialSize,
	ColorName,
	ColorCode,
	FilePath,
	MaterialColorNote
FROM #tempTable


/*
SELECT *
FROM dbo.pStyleColorway INNER JOIN
    dbo.pStyleColorwayItem ON dbo.pStyleColorway.StyleColorID = dbo.pStyleColorwayItem.StyleColorID INNER JOIN
    dbo.pStyleMaterials ON dbo.pStyleColorwayItem.StyleMaterialID = dbo.pStyleMaterials.StyleMaterialID INNER JOIN
    dbo.pMaterialColor ON dbo.pStyleColorwayItem.MaterialColorID = dbo.pMaterialColor.MaterialColorID
*/

--Drop the Temp Table.
DROP TABLE #tempTable
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '845', GetDate())
GO