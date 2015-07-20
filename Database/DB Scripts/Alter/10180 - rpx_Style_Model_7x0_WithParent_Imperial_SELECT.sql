IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Model_7x0_WithParent_Imperial_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Model_7x0_WithParent_Imperial_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Model_7x0_WithParent_Imperial_SELECT]
(
	@StyleId NVARCHAR(50)
	,@StyleSet INT
)
AS


/*Create temp table.*/
CREATE TABLE #tempMain
(
	TableRow INT IDENTITY(0,1)
	,ModelCode INT
	,ModelName NVARCHAR(50)
	,ModelDescription NVARCHAR(255)
	,ModelComments NVARCHAR(500)
	,ModelLinked NVARCHAR(5)
	,ModelSampleSize NVARCHAR(50)
	,ModelNumberMaterials INT
	,ModelNumberPieces INT
	,ModelNumberSizes INT
	,ModelCreateDate NVARCHAR(10)
	,ModelModifiedDate NVARCHAR(10)
	,ModelModifiedBy NVARCHAR(200)
	
	,PieceQty INT
	,PieceName NVARCHAR(100)
	,PieceFabricType NVARCHAR(100)
	,PieceDescription NVARCHAR(550)
	,PieceCategory NVARCHAR(550)
	,PieceRuleTableName NVARCHAR(100)
	,PieceComments NVARCHAR(500)
	,PieceArea NVARCHAR(20)						--Show in square inches.
	,PiecePerimeter NVARCHAR(20)				--Show in inches.
	,PieceUnflipped INT
	,PieceOpposite INT
	,PiecePosition INT
	,PieceImageFilePath NVARCHAR(255)
	
	,IsParent INT
)

CREATE TABLE #tempMain2
(
	TableRow INT IDENTITY(0,1)
	,ModelCode INT
	,ModelName NVARCHAR(50)
	,ModelDescription NVARCHAR(255)
	,ModelComments NVARCHAR(500)
	,ModelLinked NVARCHAR(5)
	,ModelSampleSize NVARCHAR(50)
	,ModelNumberMaterials INT
	,ModelNumberPieces INT
	,ModelNumberSizes INT
	,ModelCreateDate NVARCHAR(10)
	,ModelModifiedDate NVARCHAR(10)
	,ModelModifiedBy NVARCHAR(200)
	
	,PieceQty INT
	,PieceName NVARCHAR(100)
	,PieceFabricType NVARCHAR(100)
	,PieceDescription NVARCHAR(550)
	,PieceCategory NVARCHAR(550)
	,PieceRuleTableName NVARCHAR(100)
	,PieceComments NVARCHAR(500)
	,PieceArea NVARCHAR(20)						--Show in square inches.
	,PiecePerimeter NVARCHAR(20)				--Show in inches.
	,PieceUnflipped INT
	,PieceOpposite INT
	,PiecePosition INT
	,PieceImageFilePath NVARCHAR(255)
	
	,IsParent INT
)


/*Get records.*/
INSERT INTO #tempMain
(
	ModelCode
	,ModelName
	,ModelDescription
	,ModelComments
	,ModelLinked
	,ModelSampleSize
	,ModelNumberMaterials
	,ModelNumberPieces
	,ModelNumberSizes
	,ModelCreateDate
	,ModelModifiedDate
	,ModelModifiedBy
	
	,PieceQty
	,PieceName
	,PieceFabricType
	,PieceDescription
	,PieceCategory
	,PieceRuleTableName
	,PieceComments
	,PieceArea
	,PiecePerimeter
	,PieceUnflipped
	,PieceOpposite
	,PiecePosition
	,PieceImageFilePath
)
SELECT
	pBodyPatternSheetModel.Model_Code AS ModelCode
	,pBodyPatternSheetModel.Model_Name AS ModelName
	,pBodyPatternSheetModel.Model_Description AS ModelDescription
	,CAST(pBodyPatternSheetModel.Model_Comments AS NVARCHAR(500)) AS ModelComments
	,CASE
		WHEN pBodyPatternSheetModel.IsLinked = 0	THEN 'No'
		WHEN pBodyPatternSheetModel.IsLinked = 1	THEN 'Yes'
		ELSE ''
	 END AS ModelLinked
	,pBodyPatternSheetModel.Model_SampleSize AS ModelSampleSize
	,pBodyPatternSheetModel.Model_nMaterials AS ModelNumberMaterials
	,pBodyPatternSheetModel.Model_nPieces AS ModelNumberPieces
	,pBodyPatternSheetModel.Model_nSizes AS ModelNumberSizes
	,CONVERT(NVARCHAR(10), pBodyPatternSheetModel.CDate, 101) AS ModelCreateDate
	,CONVERT(NVARCHAR(10), pBodyPatternSheetModel.MDate, 101) AS ModelModifiedDate
	,pBodyPatternSheetModel.MUser AS ModelModifiedBy
	
	,ISNULL(pBodyPatternSheetPiece.Piece_nUnflipped, 0) + ISNULL(pBodyPatternSheetPiece.Piece_nOpposite, 0) AS PieceQty
	,pBodyPatternSheetPiece.Piece_Name AS PieceName
	,pBodyPatternSheetPiece.Piece_Image_Name AS PieceFabricType
	,pBodyPatternSheetPiece.Piece_Description AS PieceDescription
	,pBodyPatternSheetPiece.Piece_Category AS PieceCategory
	,pBodyPatternSheetPiece.Rule_Table_Name AS PieceRuleTableName
	,pBodyPatternSheetPiece.Piece_Comments AS PieceComments
	,ISNULL(CAST(ROUND(pBodyPatternSheetPiece.Piece_Area, 4) AS NVARCHAR(20)), '') + ' SQ IN' AS PieceArea
	,ISNULL(CAST(ROUND(pBodyPatternSheetPiece.Piece_Perimeter, 4) AS NVARCHAR(20)), '') + ' IN' AS PiecePerimeter
	,pBodyPatternSheetPiece.Piece_nUnflipped AS PieceUnflipped
	,pBodyPatternSheetPiece.Piece_nOpposite AS PieceOpposite
	,pBodyPatternSheetPiece.PiecePosition
	,dbo.fnx_GetStreamingImageCADStyleModelPiecePath(pBodyPatternSheetModel.StyleId, pBodyPatternSheetModel.Id, pBodyPatternSheetPiece.Id, '600') AS PieceImageFilePath
FROM pBodyPatternSheetModel
	INNER JOIN pBodyPatternSheetPiece ON	pBodyPatternSheetModel.Model_Code = pBodyPatternSheetPiece.Model_Code
											AND pBodyPatternSheetModel.StyleId = pBodyPatternSheetPiece.StyleId
											AND pBodyPatternSheetModel.StyleSet = pBodyPatternSheetPiece.StyleSet
WHERE pBodyPatternSheetModel.StyleId = @StyleId
	AND pBodyPatternSheetModel.StyleSet = @StyleSet
ORDER BY pBodyPatternSheetModel.Model_Name
	,pBodyPatternSheetPiece.PiecePosition


/*Insert a copy of the parent records in as a child record, as well, for the unique layout of the RDL this goes with.*/
INSERT INTO #tempMain
(
	ModelCode
	,ModelName
	,PieceName
	,IsParent
)
SELECT
	pBodyPatternSheetModel.Model_Code AS ModelCode
	,pBodyPatternSheetModel.Model_Name AS ModelName
	,pBodyPatternSheetModel.Model_Name AS PieceName
	,1 AS IsParent
FROM pBodyPatternSheetModel
WHERE pBodyPatternSheetModel.StyleId = @StyleId
	AND pBodyPatternSheetModel.StyleSet = @StyleSet


/*Insert records from first temp to second temp to finalize sorting.*/
INSERT INTO #tempMain2
(
	ModelCode
	,ModelName
	,ModelDescription
	,ModelComments
	,ModelLinked
	,ModelSampleSize
	,ModelNumberMaterials
	,ModelNumberPieces
	,ModelNumberSizes
	,ModelCreateDate
	,ModelModifiedDate
	,ModelModifiedBy
	
	,PieceQty
	,PieceName
	,PieceFabricType
	,PieceDescription
	,PieceCategory
	,PieceRuleTableName
	,PieceComments
	,PieceArea
	,PiecePerimeter
	,PieceUnflipped
	,PieceOpposite
	,PiecePosition
	,PieceImageFilePath
	
	,IsParent
)
SELECT
	ModelCode
	,ModelName
	,ModelDescription
	,ModelComments
	,ModelLinked
	,ModelSampleSize
	,ModelNumberMaterials
	,ModelNumberPieces
	,ModelNumberSizes
	,ModelCreateDate
	,ModelModifiedDate
	,ModelModifiedBy
	
	,PieceQty
	,PieceName
	,PieceFabricType
	,PieceDescription
	,PieceCategory
	,PieceRuleTableName
	,PieceComments
	,PieceArea
	,PiecePerimeter
	,PieceUnflipped
	,PieceOpposite
	,PiecePosition
	,PieceImageFilePath
	
	,IsParent
FROM #tempMain
ORDER BY ModelName
	,PiecePosition


/*Final select.*/
SELECT
	TableRow / 7 AS Row
	,TableRow % 7 AS [Column]
	,*
FROM #tempMain2
ORDER BY TableRow


/*Drop temp table.*/
DROP TABLE #tempMain
DROP TABLE #tempMain2


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10180', GetUTCDate())
GO