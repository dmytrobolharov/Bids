/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_UPDATE]    Script Date: 12/04/2012 17:25:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingBOM_UPDATE]    Script Date: 12/04/2012 17:25:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_UPDATE]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@StyleMaterialID UNIQUEIDENTIFIER,
	@NewMaterialNo NVARCHAR(200) = NULL,
	@NewMaterialName NVARCHAR(200) = NULL,
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
	
	-- Update the three columns one by one
    UPDATE pstyleCostingBOM SET MaterialCost = @NewFirstCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleMaterialId = @StyleMaterialID
	
	UPDATE pstyleCostingBOM SET MaterialCost = @NewSecondCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleMaterialId = @StyleMaterialID
	
	UPDATE pstyleCostingBOM SET MaterialCost = @NewThirdCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleMaterialId = @StyleMaterialID
	
	-- Update material name and material no for custom items
	IF @NewMaterialName IS NOT NULL
	BEGIN
		UPDATE pstyleCostingBOM SET MaterialName = @NewMaterialName
		WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleMaterialId = @StyleMaterialID
		
		UPDATE pstyleCostingBOM SET MaterialName = @NewMaterialName
		WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleMaterialId = @StyleMaterialID
		
		UPDATE pstyleCostingBOM SET MaterialName = @NewMaterialName
		WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleMaterialId = @StyleMaterialID
		
		UPDATE pstyleCostingBOM SET MaterialName = @NewMaterialName
		WHERE StytleCostingScenarioItemsID = @StyleCostingID AND StyleMaterialId = @StyleMaterialID
	END
	
	IF @NewMaterialNo IS NOT NULL
	BEGIN
		UPDATE pstyleCostingBOM SET MaterialNo = @NewMaterialNo
		WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleMaterialId = @StyleMaterialID
		
		UPDATE pstyleCostingBOM SET MaterialNo = @NewMaterialNo
		WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleMaterialId = @StyleMaterialID
		
		UPDATE pstyleCostingBOM SET MaterialNo = @NewMaterialNo
		WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleMaterialId = @StyleMaterialID
		
		UPDATE pstyleCostingBOM SET MaterialNo = @NewMaterialNo
		WHERE StytleCostingScenarioItemsID = @StyleCostingID AND StyleMaterialId = @StyleMaterialID
	END
	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04535', GetDate())
GO
