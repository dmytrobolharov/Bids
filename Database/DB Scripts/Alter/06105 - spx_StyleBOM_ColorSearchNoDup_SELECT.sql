IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_ColorSearchNoDup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_ColorSearchNoDup_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_ColorSearchNoDup_SELECT]
	@SearchCondition NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	SET @SearchCondition = '%' + @SearchCondition + '%'
	
	DECLARE @DimLevel INT = (SELECT V.DimLevel 
							 FROM pStyleBOMDimension
							 CROSS APPLY (VALUES(ItemDim1TypeName, 1),
												(ItemDim2TypeName, 2),
												(ItemDim3TypeName, 3))
											   V(ItemDimTypeName, DimLevel)
							 WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND V.ItemDimTypeName = 'Color')
							 
	;WITH Colors AS (
		SELECT ColorCode, ColorName, ColorSource, ColorPaletteID, ColorFolderID,
		ROW_NUMBER() OVER (PARTITION BY ColorCode, ColorName ORDER BY ColorPaletteID) AS RowNumber
		FROM pColorPalette
		WHERE ColorCode LIKE @SearchCondition OR ColorName LIKE @SearchCondition
	)
	SELECT * FROM Colors WHERE RowNumber = 1
		AND ColorPaletteID NOT IN (
			SELECT ISNULL(CASE @DimLevel WHEN 1 THEN ItemDim1Id WHEN 2 THEN ItemDim2Id ELSE ItemDim3Id END, '00000000-0000-0000-0000-000000000000')
			FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID)
	ORDER BY ColorCode, ColorName
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06105', GetDate())
GO
