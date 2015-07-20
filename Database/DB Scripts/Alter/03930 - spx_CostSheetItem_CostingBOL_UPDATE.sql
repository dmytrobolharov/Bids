IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingBOL_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingBOL_UPDATE]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingBOL_UPDATE]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@StyleNBOLItemID UNIQUEIDENTIFIER,
	@NewOperationCode NVARCHAR(200),
	@NewOperationName NVARCHAR(200),
	@NewFirstCost DECIMAL(18,3),
	@NewSecondCost DECIMAL(18,3),
	@NewThirdCost DECIMAL(18,3),
	@MUser NVARCHAR(200),
	@MDate DATETIME
	
AS
BEGIN

	SET NOCOUNT ON;
	-- Update the three columns one by one
    UPDATE pStyleCostingBOL SET OperationCode = @NewOperationCode, OperationName = @NewOperationName,
								OperationCost = @NewFirstCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @FirstColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
	
	UPDATE pStyleCostingBOL SET OperationCode = @NewOperationCode, OperationName = @NewOperationName,
								OperationCost = @NewSecondCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @SecondColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID
	
	UPDATE pStyleCostingBOL SET OperationCode = @NewOperationCode, OperationName = @NewOperationName,
								OperationCost = @NewThirdCost, MDate = @MDate, MUser = @MUser
	WHERE StytleCostingScenarioItemsID = @ThirdColumnScenarioID AND StyleNBOLItemId = @StyleNBOLItemID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03930', GetDate())
GO

