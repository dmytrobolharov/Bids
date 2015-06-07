IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Model_1x0_Metric_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Model_1x0_Metric_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Model_1x0_Metric_SELECT]
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
	,PieceArea NVARCHAR(20)						--Show in square centimeters.
	,PiecePerimeter NVARCHAR(20)				--Show in centimeters.
	,PieceUnflipped INT
	,PieceOpposite INT
	,PiecePosition INT
	,PieceImageFilePath NVARCHAR(255)
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
	,CONVERT(NVARCHAR(10), pBodyPatternSheetModel.Model_Create, 101) AS ModelCreateDate			-- pBodyPatternSheetModel.CDate
	,CONVERT(NVARCHAR(10), pBodyPatternSheetModel.Model_Rev1, 101) AS ModelModifiedDate			-- pBodyPatternSheetModel.MDate
	,pBodyPatternSheetModel.MUser AS ModelModifiedBy
	
	,ISNULL(pBodyPatternSheetPiece.Piece_nUnflipped, 0) + ISNULL(pBodyPatternSheetPiece.Piece_nOpposite, 0) AS PieceQty
	,pBodyPatternSheetPiece.Piece_Name AS PieceName
	,pBodyPatternSheetPiece.Piece_Image_Name AS PieceFabricType
	,pBodyPatternSheetPiece.Piece_Description AS PieceDescription
	,pBodyPatternSheetPiece.Piece_Category AS PieceCategory
	,pBodyPatternSheetPiece.Rule_Table_Name AS PieceRuleTableName
	,pBodyPatternSheetPiece.Piece_Comments AS PieceComments
	,ISNULL(CAST(ROUND(pBodyPatternSheetPiece.Piece_Area * 6.4516, 4) AS NVARCHAR(20)), '') + ' SQ CM' AS PieceArea
	,ISNULL(CAST(ROUND(pBodyPatternSheetPiece.Piece_Perimeter * 2.54, 4) AS NVARCHAR(20)), '') + ' CM' AS PiecePerimeter
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


/*Final select.*/
SELECT
	TableRow / 1 AS Row
	,TableRow % 1 AS [Column]
	,*
FROM #tempMain
ORDER BY TableRow


/*Drop temp table.*/
DROP TABLE #tempMain



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10179', GetUTCDate())
GO