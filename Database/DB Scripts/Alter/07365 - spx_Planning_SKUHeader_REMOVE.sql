IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUHeader_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUHeader_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUHeader_REMOVE]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pPlanningSKUHeaderDimType WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
	DELETE FROM pPlanningSKUHeader WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07365', GetDate())
GO
