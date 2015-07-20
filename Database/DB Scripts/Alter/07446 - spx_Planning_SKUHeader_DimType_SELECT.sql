IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUHeader_DimType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUHeader_DimType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUHeader_DimType_SELECT]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT * FROM pPlanningSKUHeaderDimType pshdt
    INNER JOIN pStyleBOMDimType sbdt ON pshdt.DimTypeID = sbdt.DimTypeID
    WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
    ORDER BY pshdt.Position

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07446', GetDate())
GO
