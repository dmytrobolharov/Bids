IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOM_UPDATE]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@StyleMaterialID UNIQUEIDENTIFIER,
	@NewMaterialNo NVARCHAR(200),
	@NewMaterialName NVARCHAR(200),
	@NewFirstCost DECIMAL(18,3),
	@NewSecondCost DECIMAL(18,3),
	@NewThirdCost DECIMAL(18,3),
	@MUser NVARCHAR(200),
	@MDate DATETIME
	
AS
BEGIN

	SET NOCOUNT ON;
	-- Update the three columns one by one
    UPDATE pstyleCostingBOM SET MaterialNo = @NewMaterialNo, MaterialName = @NewMaterialName,
								MaterialCost = @NewFirstCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleMaterialId = @StyleMaterialID
	
	UPDATE pstyleCostingBOM SET MaterialNo = @NewMaterialNo, MaterialName = @NewMaterialName,
								MaterialCost = @NewSecondCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleMaterialId = @StyleMaterialID
	
	UPDATE pstyleCostingBOM SET MaterialNo = @NewMaterialNo, MaterialName = @NewMaterialName,
								MaterialCost = @NewThirdCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleMaterialId = @StyleMaterialID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03931', GetDate())
GO
