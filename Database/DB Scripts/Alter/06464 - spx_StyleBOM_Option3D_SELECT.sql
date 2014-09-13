IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Option3D_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Option3D_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_Option3D_SELECT]
	@StyleBOMDimensionId NVARCHAR(40)
AS
BEGIN

DECLARE @IDList NVARCHAR(MAX)

SELECT @IDList = COALESCE(@IDList + ',', '') + 
		'[' + CAST(StyleBOMDimensionComboItemID AS NVARCHAR(50)) + ']'
		FROM pStyleBOMDimensionComboItems c
		WHERE Active = 1 AND c.StyleBOMDimensionID = @StyleBOMDimensionId
		
DECLARE @sql NVARCHAR(MAX) = 
	'SELECT ItemDim1Id, ItemDim1Name, ItemDim1Sort, ' + @IDList + ' FROM (
		SELECT d23.ItemDim1Id, d23.ItemDim1Name, d23.ItemDim1Sort, c.StyleBOMDimensionComboItemID, d23.ComboActive FROM pStyleBOMDimensionComboItems c 
		INNER JOIN pStyleBOMDimensionItems d23 ON c.StyleBOMDimensionID = d23.StyleBOMDimensionID AND c.ItemDim2Id = d23.ItemDim2Id AND c.ItemDim3Id = d23.ItemDim3Id
		WHERE c.StyleBOMDimensionID = ''' + @StyleBOMDimensionId + ''' AND c.Active = 1) pvt
		 PIVOT
	(
	MAX(ComboActive)
	FOR StyleBOMDimensionComboItemID IN (' + @IDList + ')
	) AS PivotTable
	ORDER BY ItemDim1Sort'

EXEC(@sql)

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06464', GetDate())
GO
