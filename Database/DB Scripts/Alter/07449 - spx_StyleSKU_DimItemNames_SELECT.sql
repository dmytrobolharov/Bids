IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSKU_DimItemNames_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSKU_DimItemNames_SELECT]
GO

-- this procedure is mostly used for change log
CREATE PROCEDURE [dbo].[spx_StyleSKU_DimItemNames_SELECT]
	@StyleSKUItemsID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT SUBSTRING(
          ISNULL('/' + COALESCE(sbdi1.ItemDim1Name, sbdi1.ItemDim2Name, sbdi1.ItemDim3Name), '')
        + ISNULL('/' + COALESCE(sbdi2.ItemDim1Name, sbdi2.ItemDim2Name, sbdi2.ItemDim3Name), '') 
        + ISNULL('/' + COALESCE(sbdi3.ItemDim1Name, sbdi3.ItemDim2Name, sbdi3.ItemDim3Name), ''), 2, 2000)
    FROM pStyleSKUItems ssis
    INNER JOIN pStyleSKUItem ssi ON ssis.StyleSKUItemID = ssi.StyleSKUItemID
    LEFT JOIN pStyleBOMDimensionItem sbdi1 ON ssis.ItemDim1ID IN (sbdi1.ItemDim1Id, sbdi1.ItemDim2Id, sbdi1.ItemDim3Id) 
		AND ssi.StyleBOMDimensionID = sbdi1.StyleBOMDimensionID
    LEFT JOIN pStyleBOMDimensionItem sbdi2 ON ssis.ItemDim2ID IN (sbdi2.ItemDim1Id, sbdi2.ItemDim2Id, sbdi2.ItemDim3Id) 
		AND ssi.StyleBOMDimensionID = sbdi2.StyleBOMDimensionID
    LEFT JOIN pStyleBOMDimensionItem sbdi3 ON ssis.ItemDim3ID IN (sbdi3.ItemDim1Id, sbdi3.ItemDim2Id, sbdi3.ItemDim3Id) 
		AND ssi.StyleBOMDimensionID = sbdi3.StyleBOMDimensionID
    WHERE ssis.StyleSKUItemsID = @StyleSKUItemsID
            
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07449', GetDate())
GO
