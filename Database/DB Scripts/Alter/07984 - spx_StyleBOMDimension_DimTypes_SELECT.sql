IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimension_DimTypes_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimension_DimTypes_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimension_DimTypes_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT V.*
    FROM pStyleBOMDimension
    CROSS APPLY (VALUES (ItemDim1TypeId, ItemDim1TypeName),
	                    (ItemDim2TypeId, ItemDim2TypeName),
	                    (ItemDim3TypeId, ItemDim3TypeName)) 
                       V(DimID, DimName)
    WHERE StyleBOMDimensionID = @StyleBOMDimensionID
        AND DimID <> '00000000-0000-0000-0000-000000000000'
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07984', GetDate())
GO
