IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Option2D_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Option2D_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_Option2D_SELECT]
	@StyleBOMDimensionId NVARCHAR(40)
AS
BEGIN

DECLARE @strSQL nVARCHAR(max)
SET @strSQL = 'SELECT c.ItemDim3Id, d3.ItemDim3Name, d3.ItemDim3Sort, d2.ItemDim2ID, Active FROM pStyleBOMDimensionComboItems c 
	INNER JOIN pStyleBOMDimensionItem d2 ON c.StyleBOMDimensionID = d2.StyleBOMDimensionID AND c.ItemDim2Id = d2.ItemDim2Id 
	INNER JOIN pStyleBOMDimensionItem d3 ON c.StyleBOMDimensionID = d3.StyleBOMDimensionID AND c.ItemDim3Id = d3.ItemDim3Id
	WHERE c.StyleBOMDimensionID = ''' + @StyleBOMDimensionId  + ''' AND d2.ItemDim2Active = 1 AND d3.ItemDim3Active = 1'


EXECUTE spx_Crosstab 
@strSQL,
NULL,
NULL,
'ItemDim2ID',
'Active',
'MAX',
NULL,
0,
NULL,
NULL,
0,
'ItemDim3Sort'	

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06510', GetDate())
GO
