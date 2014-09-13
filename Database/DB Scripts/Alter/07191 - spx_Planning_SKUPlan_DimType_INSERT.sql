IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUPlan_DimType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUPlan_DimType_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUPlan_DimType_INSERT]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER,	
	@DimTypeID UNIQUEIDENTIFIER,
	@Position INT
AS
BEGIN
	
	IF NOT EXISTS(SELECT * FROM pPlanningSKUHeaderDimType WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID AND DimTypeID = @DimTypeID)
	BEGIN
		INSERT INTO pPlanningSKUHeaderDimType(PlanningSKUHeaderID, DimTypeID, Position)
		VALUES (@PlanningSKUHeaderID, @DimTypeID, @Position)
	END
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07191', GetDate())
GO
