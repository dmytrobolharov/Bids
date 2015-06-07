IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]
(
	@StyleBOMDimensionId NVARCHAR(50)
	, @StyleID UNIQUEIDENTIFIER
	, @Styleset INT
	, @WorkFlowID UNIQUEIDENTIFIER
	, @WorkFlowItemID UNIQUEIDENTIFIER
	, @ItemDim1 UNIQUEIDENTIFIER
	, @ItemDim1Name NVARCHAR(200)
	, @ItemDim2 UNIQUEIDENTIFIER
	, @ItemDim2Name NVARCHAR(200)
	, @ItemDim3 UNIQUEIDENTIFIER
	, @ItemDim3Name NVARCHAR(200)
	, @Dimlevel NVARCHAR(2)
	, @MUser NVARCHAR(200)
	, @MDate DATETIME
)
AS
BEGIN
	CREATE TABLE #tmpDimItem (
		Table_ID INT IDENTITY(1, 1)  -- Primary Key of temp table
		, Mat_ID INT  -- Index number of the element of temp table. Used for ordering materials.
		, Mat_Group_ID INT -- ID of Material, which is shared with all Miscs Materials
		, stylematerialPKId NVARCHAR(50)
		, stylematerialId NVARCHAR(50)
		, materialId NVARCHAR(50)
		, materialno NVARCHAR(50)
		, Materialname NVARCHAR(100)
		, StyleMaterialMiscID NVARCHAR(50)
		, MiscMaterialno NVARCHAR(50)
		, MiscMaterialname NVARCHAR(100)
		, SubMaterial INT
		, Placement NVARCHAR(4000)
		, Colorway INT
		, AutoColor INT
		, StyleBOMDimensionId nVARCHAR(50)
		, WorkflowId NVARCHAR(50)
		, WorkflowItemId NVARCHAR(50)
		, ComponentOrder NVARCHAR(5)
		, MaterialSort NVARCHAR(5)
		, MainMaterial INT
		, MaterialImageID UNIQUEIDENTIFIER
		, MaterialImageVersion INT
		, Main INT
		, TradePartner UNIQUEIDENTIFIER
		, Qty DECIMAL(18,5)
		, MaterialSizeID UNIQUEIDENTIFIER
		, DimBOM INT
		)

	CREATE TABLE #tmpDtlItem (
		Dtl_ID INT IDENTITY(1, 1)
		, DimId NVARCHAR(50)
		, DimName NVARCHAR(200)
		, DimSort INT
		)

	CREATE TABLE #tmpskuItem (
		SKUID INT IDENTITY(1, 1)
		, MatID INT
		, DtlID INT
		, stylematerialId NVARCHAR(50)
		, materialId NVARCHAR(50)
		, materialname NVARCHAR(100)
		, materialno NVARCHAR(50)
		, Placement NVARCHAR(4000)
		, DimID NVARCHAR(50)
		, DimName NVARCHAR(200)
		, DimSort INT
		, MaterialQuantity FLOAT
		, MaterialDimension NVARCHAR(50)
		, MaterialColorId NVARCHAR(50)
		)

	DECLARE @Matcnt INT
	DECLARE @Rowcnt INT
	DECLARE @Skucnt INT
	DECLARE @Skuloop INT
	DECLARE @smaterailid NVARCHAR(50)
	DECLARE @materialid NVARCHAR(50)
	DECLARE @materialno NVARCHAR(50)
	DECLARE @materialname NVARCHAR(100)
	DECLARE @stylematerialId NVARCHAR(50)
	DECLARE @Placement NVARCHAR(4000)

	SET @Rowcnt = 1
	SET @Skuloop = 1

	/* Inserting all the Materials into the temp table */
	INSERT INTO #tmpDimItem (
		styleMaterialPKId
		, stylematerialId
		, materialId
		, materialno
		, materialname
		, StyleMaterialMiscID
		, MiscMaterialno
		, MiscMaterialname
		, SubMaterial
		, Placement
		, Colorway
		, AutoColor
		, StyleBOMDimensionId
		, WorkflowId
		, WorkflowItemId
		, ComponentOrder
		, MaterialSort
		, MainMaterial
		, MaterialImageID
		, MaterialImageVersion
		, Main
		, TradePartner
		, Qty
		, MaterialSizeID
		, DimBOM
		)
	SELECT stylematerialId AS styleMaterialPKId
		, stylematerialId
		, materialId
		, materialno
		, materialname
		, '00000000-0000-0000-0000-000000000000' AS StyleMaterialMiscID
		, '' AS MiscMaterialno
		, '' AS MiscMaterialname
		, 0 AS SubMaterial
		, Placement
		, Colorway
		, AUTOCOLOR
		, pStyleBOM.StyleBOMDimensionId
		, WorkflowId
		, WorkflowItemId
		, ComponentOrder
		, MaterialSort
		, MainMaterial
		, MaterialImageID
		, MaterialImageVersion
		, MainMaterial
		, TradePartnerRelationshipLevelID
		, Qty
		, MaterialSizeID
		, DimBOM
	FROM pStyleBOM
	INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
	INNER JOIN pStyleBOMConfig ON pStyleBOM.StyleBOMDimensionId = pStyleBOMConfig.StyleBOMDimensionID
	WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
	ORDER BY pStyleBOM.MainMaterial DESC
		, pComponentType.ComponentOrder
		, pStyleBOM.MaterialSort
		, pStyleBOM.MaterialNo
		, pStyleBOM.MaterialName
		, pStyleBOM.CDate

	/* Inserting Misc Materials for each material */
	UPDATE #tmpDimItem
	SET Mat_Group_ID = Table_ID

	DECLARE @MaterialCnt INT = 1
	DECLARE @MaterialTotal INT
	DECLARE @CurStyleMaterialID UNIQUEIDENTIFIER

	SELECT @MaterialTotal = COUNT(*)
	FROM #tmpDimItem

	WHILE @MaterialCnt <= @MaterialTotal
	BEGIN
		SELECT @CurStyleMaterialID = StyleMaterialID
		FROM #tmpDimItem
		WHERE Table_ID = @MaterialCnt

		INSERT INTO #tmpDimItem (
			Mat_Group_ID
			, styleMaterialPKId
			, stylematerialId
			, materialId
			, materialno
			, materialname
			, StyleMaterialMiscID
			, MiscMaterialno
			, MiscMaterialname
			, SubMaterial
			, Placement
			, Colorway
			, AutoColor
			, StyleBOMDimensionId
			, WorkflowId
			, WorkflowItemId
			, ComponentOrder
			, MaterialSort
			, MainMaterial
			, MaterialImageID
			, MaterialImageVersion
			, Main
			, TradePartner
			, Qty
			, MaterialSizeID
			, DimBOM
			)
		SELECT DISTINCT @MaterialCnt
			, p.StyleMaterialMiscID AS styleMaterialPKId
			, b.stylematerialId
			, b.materialId
			, b.materialno
			, b.materialname
			, p.StyleMaterialMiscID
			, p.MaterialNo AS MiscMaterialno
			, p.Materialname AS MiscMaterialname
			, 1 AS SubMaterial
			, b.Placement
			, b.Colorway
			, b.AutoColor
			, b.StyleBOMDimensionId
			, b.WorkflowId
			, b.WorkflowItemId
			, ComponentOrder
			, MaterialSort
			, MainMaterial
			, NULL
			, 0
			, MainMaterial
			, TradePartnerRelationshipLevelID
			, Qty
			, MaterialSizeID
			, DimBOM
		FROM pStyleBOM b
		INNER JOIN pStyleBOMMiscItem p ON b.stylematerialId = p.stylematerialId
			AND b.StyleBOMDimensionId = p.StyleBOMDimensionId
		INNER JOIN pComponentType ON b.MaterialType = pComponentType.ComponentTypeID
		INNER JOIN pStyleBOMConfig ON b.StyleBOMDimensionId = pStyleBOMConfig.StyleBOMDimensionID
		WHERE b.StyleBOMDimensionId = @StyleBOMDimensionId
			AND p.StyleMaterialID = @CurStyleMaterialID

		SET @MaterialCnt = @MaterialCnt + 1
	END

	/* Rearranging the table so Misc Materials will be placed right under Material */
	UPDATE #tmpDimItem
	SET Mat_ID = tmp.RowNum
	FROM #tmpDimItem
	INNER JOIN (
		SELECT *
			, ROW_NUMBER() OVER (
				ORDER BY Mat_Group_ID
					, SubMaterial
				) AS RowNum
		FROM #tmpDimItem
		) AS tmp ON tmp.Table_ID = #tmpDimItem.Table_ID

	UPDATE #tmpDimItem
	SET materialno = MiscMaterialno
		, Materialname = MiscMaterialname
	FROM pStyleBOMMiscItem p
	INNER JOIN #tmpDimItem t ON p.stylematerialId = t.stylematerialId
		AND p.StyleMaterialMiscID = t.StyleMaterialMiscID
		AND p.StyleBOMDimensionId = @StyleBOMDimensionId

	IF @Dimlevel = '1'
	BEGIN
		INSERT INTO #tmpDtlItem (
			DimId
			, DimName
			, DimSort
			)
		SELECT DISTINCT (ItemDim1Id) AS DimId
			, ItemDim1Name AS DimName
			, ItemDim1sort AS DimSort
		FROM pStyleBOMDimensionitem
		WHERE StyleBOMDimensionId = @StyleBOMDimensionId
			AND ItemDim1Id IS NOT NULL
			AND ItemDim1Active = 1
		ORDER BY ItemDim1sort
			, ItemDim1Name
	END
	ELSE
		IF @Dimlevel = '2'
		BEGIN
			INSERT INTO #tmpDtlItem (
				DimId
				, DimName
				, DimSort
				)
			SELECT DISTINCT (ItemDim2Id) AS DimId
				, ItemDim2Name AS DimName
				, ItemDim2sort AS DimSort
			FROM pStyleBOMDimensionitem
			WHERE StyleBOMDimensionId = @StyleBOMDimensionId
				AND ItemDim2Id IS NOT NULL
				AND ItemDim2Active = 1
			ORDER BY ItemDim2sort
				, ItemDim2Name
		END
		ELSE
			IF @Dimlevel = '3'
			BEGIN
				INSERT INTO #tmpDtlItem (
					DimId
					, DimName
					, DimSort
					)
				SELECT DISTINCT (ItemDim3Id) AS DimId
					, ItemDim3Name AS DimName
					, ItemDim3sort AS DimSort
				FROM pStyleBOMDimensionitem
				WHERE StyleBOMDimensionId = @StyleBOMDimensionId
					AND ItemDim3Id IS NOT NULL
					AND ItemDim3Active = 1
				ORDER BY ItemDim3sort
					, ItemDim3Name
			END
			ELSE
				IF @Dimlevel = ''
				BEGIN
					INSERT INTO #tmpDtlItem (
						DimId
						, DimName
						, DimSort
						)
					SELECT TOP 1 '00000000-0000-0000-0000-000000000000' AS DimId
						, '' AS DimName
						, '0' AS DimSort
					FROM pStyleBOMDimensionitem
					WHERE StyleBOMDimensionId = @StyleBOMDimensionId
				END

	SELECT @Matcnt = COUNT(*)
	FROM #tmpDimItem

	SELECT @Skucnt = COUNT(*)
	FROM #tmpDtlItem

	--where StyleBOMDimensionId='7CA1620C-F506-455F-8E05-F1EA8FBF7913'
	WHILE @Rowcnt <= @Matcnt
	BEGIN
		SELECT @stylematerialId = stylematerialId
			, @materialId = materialId
			, @materialno = materialno
			, @materialname = materialname
			, @Placement = Placement
		FROM #tmpDimItem
		WHERE Mat_ID = @Rowcnt

		IF @Skucnt > 0
		BEGIN
			INSERT INTO #tmpskuItem (
				MatID
				, DtlID
				, stylematerialId
				, materialId
				, materialno
				, materialname
				, Placement
				, DimID
				, DimName
				, DimSort
				)
			SELECT @Rowcnt
				, Dtl_ID
				, @stylematerialId
				, @materialId
				, @materialno
				, @materialname
				, @Placement
				, DimID
				, DimName
				, DimSort
			FROM #tmpdtlItem
				--where StyleBOMDimensionId='7CA1620C-F506-455F-8E05-F1EA8FBF7913'			    			
		END

		SET @Rowcnt = @Rowcnt + 1
	END

	IF @Dimlevel = '1'
	BEGIN
		UPDATE #tmpskuItem
		SET MaterialQuantity = p.MaterialQuantity
			, MaterialDimension = p.MaterialDimension
			, MaterialColorId = p.MaterialColorId
		FROM pstylebomitem p
		INNER JOIN #tmpskuItem t ON p.Itemdim1Id = t.dimId
			AND p.stylematerialId = t.stylematerialId
			AND p.StyleBOMDimensionId = @StyleBOMDimensionId
	END
	ELSE
		IF @Dimlevel = '2'
		BEGIN
			UPDATE #tmpskuItem
			SET MaterialQuantity = p.MaterialQuantity
				, MaterialDimension = p.MaterialDimension
				, MaterialColorId = p.MaterialColorId
			FROM pstylebomitem p
			INNER JOIN #tmpskuItem t ON p.Itemdim2Id = t.dimId
				AND p.stylematerialId = t.stylematerialId
				AND p.StyleBOMDimensionId = @StyleBOMDimensionId
		END
		ELSE
			IF @Dimlevel = '3'
			BEGIN
				UPDATE #tmpskuItem
				SET MaterialQuantity = p.MaterialQuantity
					, MaterialDimension = p.MaterialDimension
					, MaterialColorId = p.MaterialColorId
				FROM pStyleBOMItem p
				INNER JOIN #tmpskuItem t ON p.Itemdim3Id = t.dimId
					AND p.StyleMaterialID = t.stylematerialId
					AND p.StyleBOMDimensionId = @StyleBOMDimensionId
			END

	DECLARE @query NVARCHAR(max)
	DECLARE @cols NVARCHAR(2000)
	DECLARE @AmlMeasHdrID NVARCHAR(50)
	DECLARE @IncrCol NVARCHAR(200)
	DECLARE @IncrCols NVARCHAR(2000)
	DECLARE @IncrNullCols NVARCHAR(2000)

	SET @IncrCols = ''

	IF @Skuloop >= @Skucnt
		SET @Skucnt = @Skuloop + 1

	WHILE @Skuloop <= @Skucnt
	BEGIN
		SET @IncrCols = @IncrCols + '[' + convert(NVARCHAR(3), @Skuloop) + ']' + ','
		SET @Skuloop = @Skuloop + 1
			--set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @Skuloop) + ','				
			--set @Skuloop = @Skuloop + 1
	END

	IF right(@IncrCols, 1) = ','
		SET @IncrCols = substring(@IncrCols, 1, len(@IncrCols) - 1)
	SET @query = N'SELECT mat_id, styleMaterialPKId, stylematerialId, materialId, materialno, materialname, 
		StyleMaterialMiscID, SubMaterial, Placement, AutoColor, 
		StyleBOMDimensionId, WorkflowId, WorkflowItemId, MaterialImageID, MaterialImageVersion, Main AS MainMaterial, TradePartner AS TradePartnerRelationshipLevelID, Qty, MaterialSizeID, MaterialSize, DimBOM,  ' + @IncrCols + '
		FROM
			(SELECT  t2.mat_id, t2.styleMaterialPKId, t2.stylematerialId, t2.materialId, t2.materialno, t2.materialname, 
			t2.StyleMaterialMiscID,  t2.SubMaterial,
			t2.Placement, t2.AutoColor,	t2.StyleBOMDimensionId, t2.WorkflowId, t2.WorkflowItemId,  
			t1.dtl_id, t3.MaterialColorId, t2.MaterialImageID, t2.MaterialImageVersion, t2.Main, t2.TradePartner, t2.Qty, t2.MaterialSizeID, ms.MaterialSize, t2.DimBOM   
			FROM    #tmpDtlItem AS t1
			inner join #tmpskuItem as t3 on t3.dtlid=t1.dtl_id and t3.dimid=t1.dimid
					INNER JOIN #tmpdimItem AS t2 ON t2.stylematerialId = t3.stylematerialId and
					t2.materialId = t3.materialId and t2.mat_id=t3.matid and t2.colorway=1 
					LEFT JOIN pMaterialSize ms ON t2.MaterialSizeID = ms.MaterialSizeID) p
					 PIVOT(MAX([MaterialColorId])
			FOR dtl_id IN  (' + @IncrCols + ') ) AS pvt ORDER BY mat_id ;'

	EXEC (@query)

	DROP TABLE #tmpDimItem

	DROP TABLE #tmpDtlItem

	DROP TABLE #tmpskuItem
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10274', GetUTCDate())
GO
