IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Dimensions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Dimensions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_Dimensions_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT sbd.StyleBOMDimensionID, V.*, sbdt.DimTypeName 
	FROM pStyleBOMDimension sbd
	CROSS APPLY (VALUES (sbd.ItemDim1TypeId, 1),
						(sbd.ItemDim2TypeId, 2),
						(sbd.ItemDim3TypeId, 3))
					  V (DimTypeID, DimNo)
	INNER JOIN pStyleBOMDimType sbdt ON v.DimTypeID = sbdt.DimTypeID
	WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
	ORDER BY V.DimNo
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07557', GetDate())
GO
