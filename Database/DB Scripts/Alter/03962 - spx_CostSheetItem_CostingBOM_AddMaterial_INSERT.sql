IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_AddMaterial_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_AddMaterial_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_AddMaterial_INSERT]
	@StyleCostingID UNIQUEIDENTIFIER,
	@MaterialTypeID INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Cursor variables, cause we need to select all the scenarios
	-- for given costing and add the new material to all of them	
	DECLARE @CurrentScenarioItemID UNIQUEIDENTIFIER
    DECLARE @ScenarioCursor AS CURSOR
    
    -- Variables for inserting into pStyleBOM
    DECLARE @NewMaterialID UNIQUEIDENTIFIER
    DECLARE @StyleID UNIQUEIDENTIFIER
    DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
    DECLARE @MaterialTypeDesc NVARCHAR(200)
    
	-- Creating all the needed data for new material
	SELECT @NewMaterialID = NEWID()
	
	SELECT @StyleID = StyleID, @StyleBOMDimensionID = StyleBOMDimensionID FROM pStyleCosting 
	WHERE StyleCostingID = @StyleCostingID
	
	SELECT @MaterialTypeDesc = ComponentDescription FROM pComponentType
	WHERE ComponentTypeID = @MaterialTypeID
	-- Selecting all the scenarios for current 
    SET @ScenarioCursor = CURSOR SCROLL
    FOR SELECT StytleCostingScenarioItemsID from pStyleCostingScenarioItems WHERE StyleCostingID=@StyleCostingID
	
	OPEN @ScenarioCursor
	FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioItemID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Inserting material with new ID and given material type into all the scenarios
		INSERT INTO pstyleCostingBOM (StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID, StyleMaterialId,
										MaterialName, MaterialNo, MaterialType, MaterialCost, MaterialTypeDesc,
										CDate, CUser, MDate, MUser)
		VALUES (@CurrentScenarioItemID, @StyleID, @StyleBOMDimensionID, @NewMaterialID, '', '', @MaterialTypeID,
				'0.00', @MaterialTypeDesc, @CDate, @CUser, @CDate, @CUser)
		
		FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioItemID
	END
	
	CLOSE @ScenarioCursor
	DEALLOCATE @ScenarioCursor

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03962', GetDate())
GO

