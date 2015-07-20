IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Option3D_Material_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Option3D_Material_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_Option3D_Material_SELECT]
	@StyleBOMDimensionId NVARCHAR(40),
	@StyleMaterialId NVARCHAR(40)
AS
BEGIN

IF EXISTS (SELECT * FROM pStyleBOMDimensionComboItems WHERE StyleBOMDimensionID = @StyleBOMDimensionId)
BEGIN

	DECLARE @IDList nVARCHAR(MAX)

	SELECT @IDList = COALESCE(@IDList + ',', '') + 
			'[' + CAST(StyleBOMDimensionComboItemID AS nVARCHAR(50)) + ']'
			FROM pStyleBOMDimensionComboItems c
			INNER JOIN pStyleBOMDimensionItem d2 ON c.StyleBOMDimensionID = d2.StyleBOMDimensionID AND c.ItemDim2Id = d2.ItemDim2Id 
			INNER JOIN pStyleBOMDimensionItem d3 ON c.StyleBOMDimensionID = d3.StyleBOMDimensionID AND c.ItemDim3Id = d3.ItemDim3Id
			WHERE c.StyleBOMDimensionID = @StyleBOMDimensionId 
				AND Active = 1 
				AND d2.ItemDim2Active = 1 AND d3.ItemDim3Active = 1
			
	DECLARE @sql NVARCHAR(MAX) = 
		'SELECT ''' + @StyleMaterialId + ''' as StyleBOMMaterialId, ItemDim1Id as DimRowId, ItemDim1Name as DimRowName, ItemDim1Sort, ' + @IDList + ' FROM (
			SELECT d23.ItemDim1Id, d23.ItemDim1Name, d23.ItemDim1Sort, c.StyleBOMDimensionComboItemID, d23.ComboActive FROM pStyleBOMDimensionComboItems c 
			INNER JOIN pStyleBOMDimensionItems d23 ON c.StyleBOMDimensionID = d23.StyleBOMDimensionID AND c.ItemDim2Id = d23.ItemDim2Id AND c.ItemDim3Id = d23.ItemDim3Id
			WHERE c.StyleBOMDimensionID = ''' + @StyleBOMDimensionId + ''' AND c.Active = 1 AND d23.ItemDim1Active = 1 AND d23.ItemDim2Active = 1 AND d23.ItemDim3Active = 1) pvt
		PIVOT
		(
			MAX(ComboActive)
			FOR StyleBOMDimensionComboItemID IN (' + @IDList + ')
		) AS PivotTable
		ORDER BY ItemDim1Sort'

	EXEC(@sql)

END
ELSE
BEGIN
	SELECT NULL as StyleBOMMaterialId, NULL as ItemDim1Id, NULL as ItemDim1Name, NULL as ItemDim1Sort
	WHERE 1=2
END

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06512', GetDate())
GO
