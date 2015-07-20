IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUHeader_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUHeader_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUHeader_DELETE]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pStyleSKUItems
	WHERE StyleSKUItemID IN (
		SELECT StyleSKUItemID FROM pStyleSKUItem WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID)
	
	DELETE FROM pWorkFlowItem
	WHERE WorkflowItemID IN (
		SELECT WorkFlowItemID FROM pStyleSKUItem WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID)
	
	DELETE FROM pStyleSKUItem
	WHERE StyleSKUItemID IN (
		SELECT StyleSKUItemID FROM pStyleSKUItem WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID)
	
	EXEC spx_Planning_SKUHeader_REMOVE @PlanningSKUHeaderID = @PlanningSKUHeaderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07366', GetDate())
GO
