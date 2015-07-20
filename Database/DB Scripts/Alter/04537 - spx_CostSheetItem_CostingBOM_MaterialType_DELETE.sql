/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_DELETE]    Script Date: 12/04/2012 17:32:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_MaterialType_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_DELETE]    Script Date: 12/04/2012 17:32:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Check, if the selected material type is custom, and 
-- delete it, if it is
CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_DELETE]
	@StyleCostingID UNIQUEIDENTIFIER,
	@MaterialTypeID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- If material type is custom
    IF NOT EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = @MaterialTypeID)
    BEGIN
		
		DELETE pstyleCostingBOM
		FROM pstyleCostingBOM RIGHT JOIN pStyleCostingScenarioItems
		ON pStyleCostingScenarioItems.StytleCostingScenarioItemsID = pstyleCostingBOM.StytleCostingScenarioItemsID
		WHERE pStyleCostingBOM.MaterialType = @MaterialTypeID
		AND pStyleCostingScenarioItems.StyleCostingID = @StyleCostingID
		
		DELETE FROM pstyleCostingBOM
		WHERE StytleCostingScenarioItemsID = @StyleCostingID
		AND MaterialType = @MaterialTypeID
		
	END
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04537', GetDate())
GO
