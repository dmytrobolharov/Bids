/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingAdditional_AddItem_INSERT]    Script Date: 12/04/2012 17:08:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingAdditional_AddItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditional_AddItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingAdditional_AddItem_INSERT]    Script Date: 12/04/2012 17:08:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditional_AddItem_INSERT]
	@StyleCostingID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Cursor variables, cause we need to select all the scenarios
	-- for given costing and add the new operation to all of them	
	DECLARE @CurrentScenarioItemID UNIQUEIDENTIFIER
    DECLARE @ScenarioCursor AS CURSOR
    
    -- Variables for inserting into pStyleBOL
    DECLARE @NewItemID UNIQUEIDENTIFIER
    DECLARE @StyleID UNIQUEIDENTIFIER
    
	-- Creating all the needed data for new operation
	SELECT @NewItemID = NEWID()
	
	SELECT @StyleID = StyleID FROM pStyleCosting 
	WHERE StyleCostingID = @StyleCostingID
	
	-- Selecting all the scenarios for current 
    SET @ScenarioCursor = CURSOR SCROLL
    FOR SELECT StytleCostingScenarioItemsID from pStyleCostingScenarioItems WHERE StyleCostingID=@StyleCostingID
	
	OPEN @ScenarioCursor
	FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioItemID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Inserting operation with new ID into all the scenarios
		INSERT INTO pstyleCostingAdditionalItems (StytleCostingScenarioItemsID, StyleID, StyleAdditionalItemID,
										AdditionalItemName, AdditionalItemNo, AdditionalItemCost,
										CDate, CUser, MDate, MUser)
		VALUES (@CurrentScenarioItemID, @StyleID, @NewItemID, '', '',
				'0.00', @CDate, @CUser, @CDate, @CUser)
		
		FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioItemID
	END

	CLOSE @ScenarioCursor
	DEALLOCATE @ScenarioCursor
	
	-- Inserting operation with new ID into default system scenario
	INSERT INTO pstyleCostingAdditionalItems (StytleCostingScenarioItemsID, StyleID, StyleAdditionalItemID,
									AdditionalItemName, AdditionalItemNo, AdditionalItemCost,
									CDate, CUser, MDate, MUser)
	VALUES (@StyleCostingID, @StyleID, @NewItemID, '', '',
			'0.00', @CDate, @CUser, @CDate, @CUser)
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04528', GetDate())
GO
