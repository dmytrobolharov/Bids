IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeader_DimType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeader_DimType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeader_DimType_SELECT]
	@SKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT * FROM (
        SELECT PlanningSKUHeaderID AS SKUHeaderID, DimTypeID, Position FROM pPlanningSKUHeaderDimType
        UNION
        SELECT LineFolderSKUHeaderID AS SKUHeaderID, DimTypeID, Position FROM pLineFolderSKUHeaderDimType) shdt
    INNER JOIN pStyleBOMDimType sbdt ON shdt.DimTypeID = sbdt.DimTypeID
    WHERE shdt.SKUHeaderID = @SKUHeaderID
    ORDER BY shdt.Position

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07439', GetDate())
GO
