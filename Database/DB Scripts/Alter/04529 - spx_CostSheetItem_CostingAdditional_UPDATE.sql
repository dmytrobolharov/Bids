/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingAdditional_UPDATE]    Script Date: 12/04/2012 17:22:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingAdditional_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditional_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingAdditional_UPDATE]    Script Date: 12/04/2012 17:22:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditional_UPDATE]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@AdditionalItemId UNIQUEIDENTIFIER,
	@NewItemNo NVARCHAR(200),
	@NewItemName NVARCHAR(200),
	@NewFirstCost DECIMAL(18,3),
	@NewSecondCost DECIMAL(18,3),
	@NewThirdCost DECIMAL(18,3),
	@MUser NVARCHAR(200),
	@MDate DATETIME
	
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @StyleCostingID UNIQUEIDENTIFIER
	SELECT @StyleCostingID = StyleCostingID FROM pStyleCostingScenarioItems
	WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID
	
	-- Update columns one by one
    UPDATE pstyleCostingAdditionalItems SET AdditionalItemName = @NewItemName, AdditionalItemNo = @NewItemNo,
								AdditionalItemCost = @NewFirstCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleAdditionalItemId = @AdditionalItemId
	
	UPDATE pstyleCostingAdditionalItems SET AdditionalItemName = @NewItemName, AdditionalItemNo = @NewItemNo,
								AdditionalItemCost = @NewSecondCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleAdditionalItemId = @AdditionalItemId
	
	UPDATE pstyleCostingAdditionalItems SET AdditionalItemName = @NewItemName, AdditionalItemNo = @NewItemNo,
								AdditionalItemCost = @NewThirdCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleAdditionalItemId = @AdditionalItemId
	
	UPDATE pstyleCostingAdditionalItems SET AdditionalItemName = @NewItemName, AdditionalItemNo = @NewItemNo, 
										AdditionalItemCost = @NewThirdCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @StyleCostingID AND StyleAdditionalItemId = @AdditionalItemId

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04529', GetDate())
GO
