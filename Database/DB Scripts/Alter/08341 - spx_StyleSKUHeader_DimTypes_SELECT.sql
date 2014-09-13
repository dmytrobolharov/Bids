IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSKUHeader_DimTypes_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSKUHeader_DimTypes_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSKUHeader_DimTypes_SELECT]
	@StyleSKUItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT V.*, sbdt.DimTypeName
    FROM pStyleSKUItem ski
    CROSS APPLY (VALUES (ski.ItemDim1TypeID, 1),
		                (ski.ItemDim2TypeID, 2),
		                (ski.ItemDim3TypeID, 3)) 
	                   V(ItemDimTypeID,      DimNo)
    INNER JOIN pStyleBOMDimType sbdt ON v.ItemDimTypeID = sbdt.DimTypeID
    WHERE ski.StyleSKUItemID = @StyleSKUItemID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08341', GetDate())
GO