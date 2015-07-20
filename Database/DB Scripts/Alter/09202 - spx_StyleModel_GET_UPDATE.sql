IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleModel_GET_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleModel_GET_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleModel_GET_UPDATE] (
	@CADDB nVARCHAR(50)
	, @Catalog nVARCHAR(50)
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @strSortOrder nVARCHAR(50)
	)
AS
BEGIN
	DECLARE @ID UNIQUEIDENTIFIER
	DECLARE @Model_Code INT
	DECLARE @Sortsql NVARCHAR(max)
	DECLARE @strCADsql NVARCHAR(max)

	SELECT ROW_NUMBER() OVER (
			ORDER BY Model_Code DESC
			) AS 'rownum'
		, *
	INTO #tempTblBody
	FROM pBodyPatternSheetModel
	WHERE StyleID = @StyleID
		AND StyleSet = @StyleSet
		AND IsLinked = 1

	DECLARE @ModelID UNIQUEIDENTIFIER
	DECLARE @RowCnt INT

	SELECT @RowCnt = 1

	DECLARE @MaxRows INT

	SELECT @MaxRows = count(*)
	FROM #tempTblBody

	WHILE @RowCnt <= @MaxRows
	BEGIN
		------------------------------------------------
		SET @Model_Code = (SELECT Model_Code FROM #tempTblBody WHERE rownum = @RowCnt)
		SET @StyleID = (SELECT StyleID FROM #tempTblBody WHERE rownum = @RowCnt)
		SET @ID = (SELECT ID FROM #tempTblBody WHERE rownum = @RowCnt)

		------------------------------------------------
		CREATE TABLE #tempTBLCAD (
			[Model_Code] [int] NOT NULL DEFAULT((0))
			, [Model_Name] [nvarchar](100) NULL
			, [Last_Updated] [datetime] NULL
			, [IsActive] [int] NULL DEFAULT((- 1))
			, [IsLinked] [int] NULL DEFAULT((0))
			, [ClassifierId] [int] NULL
			, [SystemId] [int] NULL
			, [Marker_Code] [int] NULL
			, [Model_Description] [nvarchar](255) NULL
			, [Model_CrOpId] [nvarchar](50) NULL
			, [Model_Create] [datetime] NULL
			, [Model_RevOp1] [nvarchar](50) NULL
			, [Model_Rev1] [datetime] NULL
			, [Model_RevOp2] [nvarchar](50) NULL
			, [Model_Rev2] [datetime] NULL
			, [Model_GRTable] [nvarchar](50) NULL
			, [Model_MTMFile] [nvarchar](50) NULL
			, [Model_SAName] [nvarchar](50) NULL
			, [Model_SYNTable] [nvarchar](50) NULL
			, [Model_HPTable] [nvarchar](50) NULL
			, [Model_SampleSize] [nvarchar](60) NULL
			, [Model_nMaterials] [int] NULL
			, [Model_nPieces] [int] NULL
			, [Model_nSizes] [int] NULL
			, [Model_Image_SN] [int] NULL
			, [Model_Image_Name] [nvarchar](255) NULL
			, [Model_Comments] [nvarchar](max) NULL
			, [PreferMetric] [int] NULL DEFAULT((0))
			, [UserDefined1] [nvarchar](50) NULL
			, [UserDefined2] [nvarchar](50) NULL
			, [UserDefined3] [nvarchar](50) NULL
			, [UserDefined4] [nvarchar](50) NULL
			, [UserDefined5] [nvarchar](50) NULL
			, [Total_Area] [float] NULL
			, [LastCADRefresh] [datetime] NULL
			, [PlotFileLocation] [nvarchar](255) NULL
			, [NotchFile] [nvarchar](50) NULL
			, [AnnotationFile] [nvarchar](50) NULL
			, [StorageType] [int] NULL
			)

		SELECT @strCADsql = 'INSERT
		INTO #tempTBLCAD
		SELECT 
			[Model_Code],
			[Model_Name],
			[Last_Updated],
			[IsActive],
			[IsLinked],
			[ClassifierId],
			[SystemId],
			[Marker_Code],
			[Model_Description],
			[Model_CrOpId],
			[Model_Create],
			[Model_RevOp1],
			[Model_Rev1],
			[Model_RevOp2],
			[Model_Rev2],
			[Model_GRTable],
			[Model_MTMFile],
			[Model_SAName],
			[Model_SYNTable],
			[Model_HPTable],
			[Model_SampleSize],
			[Model_nMaterials],
			[Model_nPieces],
			[Model_nSizes],
			[Model_Image_SN],
			[Model_Image_Name],
			[Model_Comments],
			[PreferMetric],
			[UserDefined1],
			[UserDefined2],
			[UserDefined3],
			[UserDefined4],
			[UserDefined5],
			[Total_Area],
			[LastCADRefresh],
			[PlotFileLocation],
			[NotchFile],
			[AnnotationFile],
			[StorageType] 
		FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Model_Details WHERE  Model_Code = ' + Convert(nVARCHAR(50), @Model_Code)

		EXEC (@strCADsql)

		IF (SELECT COUNT(*) FROM #tempTBLCAD) > 0
		BEGIN
			UPDATE pBodyPatternSheetModel
			SET [Marker_Code] = (SELECT Model_Code FROM #tempTBLCAD)
				, [Model_Name] = (SELECT Model_Name FROM #tempTBLCAD)
				, [Model_Description] = (SELECT Model_Description FROM #tempTBLCAD)
				, [Active] = 1
				, [IsLinked] = 1
				, [Model_CrOpId] = (SELECT Model_CrOpId FROM #tempTBLCAD)
				, [Model_Create] = (SELECT Model_Create FROM #tempTBLCAD)
				, [Model_RevOp1] = (SELECT Model_RevOp1 FROM #tempTBLCAD)
				, [Model_Rev1] = (SELECT Model_Rev1 FROM #tempTBLCAD)
				, [Model_RevOp2] = (SELECT Model_RevOp2 FROM #tempTBLCAD)
				, [Model_Rev2] = (SELECT Model_Rev2 FROM #tempTBLCAD)
				, [Model_GRTable] = (SELECT Model_GRTable FROM #tempTBLCAD)
				, [Model_MTMFile] = (SELECT Model_MTMFile FROM #tempTBLCAD)
				, [Model_SAName] = (SELECT Model_SAName FROM #tempTBLCAD)
				, [Model_SYNTable] = (SELECT Model_SYNTable FROM #tempTBLCAD)
				, [Model_HPTable] = (SELECT Model_HPTable FROM #tempTBLCAD)
				, [Model_SampleSize] = (SELECT Model_SampleSize FROM #tempTBLCAD)
				, [Model_nMaterials] = (SELECT Model_nMaterials FROM #tempTBLCAD)
				, [Model_nPieces] = (SELECT Model_nPieces FROM #tempTBLCAD)
				, [Model_nSizes] = (SELECT Model_nSizes FROM #tempTBLCAD)
				, [Model_Image_SN] = (SELECT Model_Image_SN FROM #tempTBLCAD)
				, [Model_Image_Name] = (SELECT REPLACE(Model_Image_Name, '#', '\') FROM #tempTBLCAD)
				--,[Model_Comments] = (SELECT Model_Comments from  #tempTBLCAD) -- Don't rewrite comments from CAD
				, [PreferMetric] = (SELECT PreferMetric FROM #tempTBLCAD)
				, [UserDefined1] = (SELECT UserDefined1 FROM #tempTBLCAD)
				, [UserDefined2] = (SELECT UserDefined2 FROM #tempTBLCAD)
				, [UserDefined3] = (SELECT UserDefined3 FROM #tempTBLCAD)
				, [UserDefined4] = (SELECT UserDefined4 FROM #tempTBLCAD)
				, [UserDefined5] = (SELECT UserDefined5 FROM #tempTBLCAD)
				, [Total_Area] = (SELECT Total_Area FROM #tempTBLCAD)
				, [LastCADRefresh] = (SELECT LastCADRefresh FROM #tempTBLCAD)
				, [PlotFileLocation] = (SELECT PlotFileLocation FROM #tempTBLCAD)
				, [NotchFile] = (SELECT NotchFile FROM #tempTBLCAD)
				, [AnnotationFile] = (SELECT AnnotationFile FROM #tempTBLCAD)
				, [StorageType] = (SELECT StorageType FROM #tempTBLCAD)
			WHERE pBodyPatternSheetModel.Model_Code = (SELECT Model_Code FROM #tempTblBody WHERE rownum = @RowCnt)
				AND pBodyPatternSheetModel.StyleID = @StyleID
				AND StyleSet = @StyleSet
				AND IsLinked = 1
		END

		SET @ModelID = (
				SELECT ID
				FROM pBodyPatternSheetModel
				WHERE pBodyPatternSheetModel.Model_Code = (SELECT Model_Code FROM #tempTblBody WHERE rownum = @RowCnt)
					AND pBodyPatternSheetModel.StyleID = @StyleID
					AND StyleSet = @StyleSet
					AND IsLinked = 1
				)

		SELECT @RowCnt = @RowCnt + 1

		EXEC [spx_BodyPatternSheetPiece_GET_UPDATE] @ModelID
			, @CADDB
			, @Catalog

		DROP TABLE #tempTBLCAD
	END

	DROP TABLE #tempTblBody

	SELECT @Sortsql = 'SELECT 	[ID] ,
	[BodyID],
	[StyleID],
	[Model_Code],
	[Model_Name],
	[Last_Updated],
	[Active],
    IsLinkedBF,
	[IsLinked],
	CUser,
	CDate,
    MDate,
    MUser,
	[Marker_Code],
	[Model_Description],
	[Model_CrOpId],
	[Model_Create],
	[Model_RevOp1],
	[Model_Rev1],
	[Model_RevOp2],
	[Model_Rev2],
	[Model_GRTable],
	[Model_MTMFile],
	[Model_SAName],
	[Model_SYNTable],
	[Model_HPTable],
	[Model_SampleSize],
	[Model_nMaterials],
	[Model_nPieces],
	[Model_nSizes],
	[Model_Image_SN],
	[Model_Image_Name],
	convert (nvarchar(300),Model_Comments) as Model_Comments,
	[PreferMetric],
	[UserDefined1],
	[UserDefined2],
	[UserDefined3],
	[UserDefined4],
	[UserDefined5],
	[Total_Area],
	[LastCADRefresh],
	[PlotFileLocation],
	[NotchFile],
	[AnnotationFile],
	[StorageType] FROM pBodyPatternSheetModel  WHERE (StyleID = ' + CHAR(39) + Convert(nVARCHAR(36), @StyleID) + CHAR(39) + ' AND StyleSet = ' + Convert(nVARCHAR(10), @StyleSet) + ' AND Active = 1)' + 
		' order by ' + @strSortOrder

	EXEC (@Sortsql)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09202', GetDate())
GO