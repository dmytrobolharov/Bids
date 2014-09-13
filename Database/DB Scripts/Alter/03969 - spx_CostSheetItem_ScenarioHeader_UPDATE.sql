IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_ScenarioHeader_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_ScenarioHeader_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_ScenarioHeader_UPDATE]
	@StyleCostingID UNIQUEIDENTIFIER,
	@NewSystemScenarioName NVARCHAR(200),
	@FirstScenarioID UNIQUEIDENTIFIER,
	@NewFirstScenarioName NVARCHAR(200),
	@SecondScenarioID UNIQUEIDENTIFIER,
	@NewSecondScenarioName NVARCHAR(200),
	@ThirdScenarioID UNIQUEIDENTIFIER,
	@NewThirdScenarioName NVARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE pStyleCostingScenarioItems SET StyleCostingName = @NewFirstScenarioName
    WHERE StytleCostingScenarioItemsID = @FirstScenarioID
    
    UPDATE pStyleCostingScenarioItems SET StyleCostingName = @NewSecondScenarioName
    WHERE StytleCostingScenarioItemsID = @SecondScenarioID
    
    UPDATE pStyleCostingScenarioItems SET StyleCostingName = @NewThirdScenarioName
    WHERE StytleCostingScenarioItemsID = @ThirdScenarioID
    
    UPDATE pStyleCosting SET StyleCostingName = @NewSystemScenarioName
    WHERE StyleCostingID = @StyleCostingID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03969', GetDate())
GO

