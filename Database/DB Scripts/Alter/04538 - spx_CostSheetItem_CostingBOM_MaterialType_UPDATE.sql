/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_UPDATE]    Script Date: 12/04/2012 17:30:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_MaterialType_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_UPDATE]    Script Date: 12/04/2012 17:30:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_UPDATE]
	@StyleCostingID UNIQUEIDENTIFIER,
	@MaterialType INTEGER,
	@NewMaterialTypeDescription NVARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @ScenarioCursor CURSOR
	DECLARE @CurrentScenarioID UNIQUEIDENTIFIER
	-- Selecting all the scenarios for current costing	
	SET @ScenarioCursor = CURSOR SCROLL
	FOR SELECT StytleCostingScenarioItemsID 
	FROM pStyleCostingScenarioItems WHERE StyleCostingID = @StyleCostingID

	OPEN @ScenarioCursor
	FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Updating material type description for every material with given material ID 
		-- in current costing scenario
		UPDATE pstyleCostingBOM SET MaterialTypeDesc = @NewMaterialTypeDescription
		WHERE StytleCostingScenarioItemsID = @CurrentScenarioID
		AND MaterialType = @MaterialType
		
		FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioID
	END
	
	CLOSE @ScenarioCursor
	DEALLOCATE @ScenarioCursor
	
	UPDATE pstyleCostingBOM SET MaterialTypeDesc = @NewMaterialTypeDescription
	WHERE StytleCostingScenarioItemsID = @StyleCostingID
	AND MaterialType = @MaterialType
    
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04538', GetDate())
GO
