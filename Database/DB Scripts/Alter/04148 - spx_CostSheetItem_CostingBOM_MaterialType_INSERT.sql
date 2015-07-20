/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_AddMaterialType_INSERT]    Script Date: 10/11/2012 11:02:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_AddMaterialType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_AddMaterialType_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_INSERT]    Script Date: 10/11/2012 11:02:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_MaterialType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_INSERT]    Script Date: 10/11/2012 11:02:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_MaterialType_INSERT]
	@StyleCostingID UNIQUEIDENTIFIER,
	@CDate DATETIME,
	@CUser NVARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @MaxMaterialType INTEGER
    DECLARE @MaxCustomType INTEGER
    DECLARE @NewCustomType INTEGER
    DECLARE @NewCustomTypeDesc NVARCHAR(200)
    
    SELECT @MaxMaterialType = ISNULL(MAX(ComponentTypeID), 0) FROM pComponentType
    
    SELECT @MaxCustomType = ISNULL(MAX(costbom.MaterialType), 0) 
	FROM pstyleCostingBOM costbom 
	RIGHT JOIN pStyleCostingScenarioItems scenario ON costbom.StytleCostingScenarioItemsID = scenario.StytleCostingScenarioItemsID
    WHERE scenario.StyleCostingID = @StyleCostingID
    
    -- If component type table contains more types, than costing, then new type ID
    -- is taken as more-than-max component type. Else it's more-than-max types from
    -- costing. It's done to guarantee uniqueness of custom types, in other cases
    -- custom types could intersect with others.
    IF @MaxMaterialType >= @MaxCustomType
    BEGIN
		SET @NewCustomType = @MaxMaterialType + 1
    END
    ELSE
    BEGIN
		SET @NewCustomType = @MaxCustomType + 1
    END
    
    SET @NewCustomTypeDesc = 'Material Type ' + CAST(@NewCustomType AS NVARCHAR(10))

	-- Inserting the new custom type into all the scenarios of current costing
	DECLARE @ColumnCursor CURSOR
	DECLARE @CurrentScenarioID UNIQUEIDENTIFIER

	SET @ColumnCursor = CURSOR SCROLL
	FOR SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems 
	WHERE StyleCostingID = @StyleCostingID
	OPEN @ColumnCursor
	FETCH NEXT FROM @ColumnCursor INTO @CurrentScenarioID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Insert a new record with no data except for custom type name and custom type description
		INSERT INTO pstyleCostingBOM (StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID,
										StyleMaterialId, MaterialName, MaterialNo, MaterialType,
										MaterialTypeDesc, MaterialCost, CUser, CDate, MUser, MDate)
		SELECT DISTINCT StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID,
						NULL, NULL, NULL, @NewCustomType, @NewCustomTypeDesc, '0.00',
						@CUser, @CDate, @CUser, @CDate FROM pStyleCostingScenarioItems
		WHERE StytleCostingScenarioItemsID = @CurrentScenarioID
		
		FETCH NEXT FROM @ColumnCursor INTO @CurrentScenarioID
	END
	
	CLOSE @ColumnCursor
	DEALLOCATE @ColumnCursor
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04148', GetDate())
GO
