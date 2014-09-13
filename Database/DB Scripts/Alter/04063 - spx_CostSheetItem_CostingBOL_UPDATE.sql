IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOL_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOL_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOL_UPDATE]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@StyleNBOLItemID UNIQUEIDENTIFIER,
	@NewOperationCode NVARCHAR(200) = NULL,
	@NewOperationName NVARCHAR(200) = NULL,
	@NewFirstCost DECIMAL(18,3),
	@NewSecondCost DECIMAL(18,3),
	@NewThirdCost DECIMAL(18,3),
	@MUser NVARCHAR(200),
	@MDate DATETIME
	
AS
BEGIN

	SET NOCOUNT ON;
	-- Update three columns one by one
    UPDATE pStyleCostingBOL SET OperationCost = @NewFirstCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
	
	UPDATE pStyleCostingBOL SET OperationCost = @NewSecondCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
	
	UPDATE pStyleCostingBOL SET OperationCost = @NewThirdCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
	
	-- Updating code for custom operations
	IF @NewOperationCode IS NOT NULL
	BEGIN
		UPDATE pStyleCostingBOL SET OperationCode = @NewOperationCode
		WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
		
		UPDATE pStyleCostingBOL SET OperationCode = @NewOperationCode
		WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
		
		UPDATE pStyleCostingBOL SET OperationCode = @NewOperationCode
		WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
	
	END
	
	-- Updating name for custom operations
	IF @NewOperationName IS NOT NULL
	BEGIN
		UPDATE pStyleCostingBOL SET OperationName = @NewOperationName
		WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
		
		UPDATE pStyleCostingBOL SET OperationName = @NewOperationName
		WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
		
		UPDATE pStyleCostingBOL SET OperationName = @NewOperationName
		WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
	END
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04063', GetDate())

GO

