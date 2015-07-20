IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingEmptyRows_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingEmptyRows_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingEmptyRows_DELETE]
	@StyleCostingID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @OperationCursor CURSOR
	DECLARE @CurrentOperationID UNIQUEIDENTIFIER
	DECLARE @ItemCursor CURSOR
	DECLARE @CurrentCode NVARCHAR(200)
	DECLARE @CurrentDescription NVARCHAR(200)
	DECLARE @CurrentItemCost NUMERIC(18,3)
	DECLARE @NotEmptyRows INTEGER
	SET @NotEmptyRows = 0
	
	-- Selecting all the operations for current costing
	SET @OperationCursor = CURSOR SCROLL
	FOR SELECT DISTINCT costingBOL.StyleNBOLItemId FROM pStyleCostingBOL costingBOL
		RIGHT JOIN pStyleCostingScenarioItems scenario ON scenario.StytleCostingScenarioItemsID = costingBOL.StytleCostingScenarioItemsID
		RIGHT JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
		WHERE costing.StyleCostingID = @StyleCostingID
	OPEN @OperationCursor
	FETCH NEXT FROM @OperationCursor INTO @CurrentOperationID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		SET @ItemCursor = CURSOR SCROLL
		FOR SELECT OperationCode, OperationName, OperationCost 
		FROM pStyleCostingBOL WHERE StyleNBOLItemId = @CurrentOperationID
		OPEN @ItemCursor
		-- Getting all the records for current operation
		FETCH NEXT FROM @ItemCursor INTO @CurrentCode, @CurrentDescription, @CurrentItemCost
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Checking, if the current record has code, OR name OR cost
			IF (RTRIM(LTRIM(@CurrentCode)) <> '' AND @CurrentCode IS NOT NULL)
				OR (LTRIM(RTRIM(@CurrentDescription)) <> '' AND @CurrentDescription IS NOT NULL)
				OR @CurrentItemCost <> 0
			BEGIN
				SET @NotEmptyRows = @NotEmptyRows + 1
			END
			FETCH NEXT FROM @ItemCursor INTO @CurrentCode, @CurrentDescription, @CurrentItemCost
		END
		CLOSE @ItemCursor
		DEALLOCATE @ItemCursor
		-- Deleting the items, which have no code, description and zero cost
		IF @NotEmptyRows = 0
		BEGIN
			DELETE FROM pStyleCostingBOL WHERE StyleNBOLItemId = @CurrentOperationID
		END
		SET @NotEmptyRows = 0
		
	FETCH NEXT FROM @OperationCursor INTO @CurrentOperationID
	END
	CLOSE @OperationCursor
	DEALLOCATE @OperationCursor
	
	-- Selecting all the materials for current costing
	DECLARE @MaterialCursor CURSOR
	DECLARE @CurrentMaterialID UNIQUEIDENTIFIER
	
	SET @MaterialCursor = CURSOR SCROLL
	FOR SELECT DISTINCT costingBOM.StyleMaterialID FROM pStyleCostingBOM costingBOM
		RIGHT JOIN pStyleCostingScenarioItems scenario ON scenario.StytleCostingScenarioItemsID = costingBOM.StytleCostingScenarioItemsID
		RIGHT JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
		WHERE costing.StyleCostingID = @StyleCostingID
	OPEN @MaterialCursor
	FETCH NEXT FROM @MaterialCursor INTO @CurrentMaterialID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		SET @ItemCursor = CURSOR SCROLL
		FOR SELECT MaterialNo, MaterialName, MaterialCost 
		FROM pStyleCostingBOM WHERE StyleMaterialID = @CurrentMaterialID
		OPEN @ItemCursor
		-- Getting all the records for current material
		FETCH NEXT FROM @ItemCursor INTO @CurrentCode, @CurrentDescription, @CurrentItemCost
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Checking, if the current record has code, OR name OR cost
			IF (RTRIM(LTRIM(@CurrentCode)) <> '' AND @CurrentCode IS NOT NULL)
				OR (LTRIM(RTRIM(@CurrentDescription)) <> '' AND @CurrentDescription IS NOT NULL)
				OR @CurrentItemCost <> 0
			BEGIN
				SET @NotEmptyRows = @NotEmptyRows + 1
			END
			FETCH NEXT FROM @ItemCursor INTO @CurrentCode, @CurrentDescription, @CurrentItemCost
		END
		CLOSE @ItemCursor
		DEALLOCATE @ItemCursor
		-- Deleting the items, which have no code, description and zero cost
		IF @NotEmptyRows = 0
		BEGIN
			DELETE FROM pStyleCostingBOM WHERE StyleMaterialID = @CurrentMaterialID
		END
		SET @NotEmptyRows = 0
		
	FETCH NEXT FROM @MaterialCursor INTO @CurrentMaterialID
	END
	CLOSE @MaterialCursor
	DEALLOCATE @MaterialCursor
	
	-- Selecting all the additional items for current costing
	DECLARE @AdditionalItemsCursor CURSOR
	DECLARE @CurrentAdditionalItemID UNIQUEIDENTIFIER
	
	SET @AdditionalItemsCursor = CURSOR SCROLL
	FOR SELECT DISTINCT additionals.StyleAdditionalItemID FROM pstyleCostingAdditionalItems additionals
		RIGHT JOIN pStyleCostingScenarioItems scenario ON scenario.StytleCostingScenarioItemsID = additionals.StytleCostingScenarioItemsID
		RIGHT JOIN pStyleCosting costing ON scenario.StyleCostingID = costing.StyleCostingID
		WHERE costing.StyleCostingID = @StyleCostingID
	OPEN @AdditionalItemsCursor
	FETCH NEXT FROM @AdditionalItemsCursor INTO @CurrentAdditionalItemID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		SET @ItemCursor = CURSOR SCROLL
		FOR SELECT AdditionalItemNo, AdditionalItemName, AdditionalItemCost 
		FROM pStyleCostingAdditionalItems WHERE StyleAdditionalItemID = @CurrentAdditionalItemID
		OPEN @ItemCursor
		-- Getting all the records for current material
		FETCH NEXT FROM @ItemCursor INTO @CurrentCode, @CurrentDescription, @CurrentItemCost
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Checking, if the current record has code, OR name OR cost
			IF (RTRIM(LTRIM(@CurrentCode)) <> '' AND @CurrentCode IS NOT NULL)
				OR (LTRIM(RTRIM(@CurrentDescription)) <> '' AND @CurrentDescription IS NOT NULL)
				OR @CurrentItemCost <> 0
			BEGIN
				SET @NotEmptyRows = @NotEmptyRows + 1
			END
			FETCH NEXT FROM @ItemCursor INTO @CurrentCode, @CurrentDescription, @CurrentItemCost
		END
		CLOSE @ItemCursor
		DEALLOCATE @ItemCursor
		-- Deleting the items, which have no code, description and zero cost
		IF @NotEmptyRows = 0
		BEGIN
			DELETE FROM pstyleCostingAdditionalItems WHERE StyleAdditionalItemID = @CurrentAdditionalItemID
		END
		SET @NotEmptyRows = 0
		
	FETCH NEXT FROM @AdditionalItemsCursor INTO @CurrentAdditionalItemID
	END
	CLOSE @AdditionalItemsCursor
	DEALLOCATE @AdditionalItemsCursor
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04045', GetDate())
GO
