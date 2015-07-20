IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingHeader_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingHeader_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingHeader_UPDATE]
	@StyleCostingID UNIQUEIDENTIFIER,
	@NewSystemScenarioItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE pStyleCosting SET StyleCostingScenarioItemsId = @NewSystemScenarioItemID 
	WHERE StyleCostingID = @StyleCostingID
	
	UPDATE costing
	SET costing.StyleCostingDate = item.StyleCostingDate,
		costing.StyleCostingComments = item.StyleCostingComments,
		costing.StyleCostingHTS = item.StyleCostingHTS,
		costing.StyleCostingCustomField1 = item.StyleCostingCustomField1,
		costing.StyleCostingCustomField2 = item.StyleCostingCustomField2,
		costing.StyleCostingCustomField3 = item.StyleCostingCustomField3,
		costing.StyleCostingCustomField4 = item.StyleCostingCustomField4,
		costing.StyleCostingCustomField5 = item.StyleCostingCustomField5,
		costing.StyleCostingCustomField6 = item.StyleCostingCustomField6,
		costing.StyleCostingCustomField7 = item.StyleCostingCustomField7,
		costing.StyleCostingCustomField8 = item.StyleCostingCustomField8,
		costing.StyleCostingCustomField9 = item.StyleCostingCustomField9,
		costing.StyleCostingCustomField10 = item.StyleCostingCustomField10,
		costing.StyleCostingCustomField11 = item.StyleCostingCustomField11,
		costing.StyleCostingCustomField12 = item.StyleCostingCustomField12,
		costing.StyleCostingCustomField13 = item.StyleCostingCustomField13,
		costing.StyleCostingCustomField14 = item.StyleCostingCustomField14,
		costing.StyleCostingCustomField15 = item.StyleCostingCustomField15,
		costing.StyleCostingCustomField16 = item.StyleCostingCustomField16,
		costing.StyleCostingCustomField17 = item.StyleCostingCustomField17,
		costing.StyleCostingCustomField18 = item.StyleCostingCustomField18,
		costing.StyleCostingCustomField19 = item.StyleCostingCustomField19,
		costing.StyleCostingCustomField20 = item.StyleCostingCustomField20,
		costing.StyleCostingCustomField21 = item.StyleCostingCustomField21,
		costing.StyleCostingCustomField22 = item.StyleCostingCustomField22,
		costing.StyleCostingCustomField23 = item.StyleCostingCustomField23,
		costing.StyleCostingCustomField24 = item.StyleCostingCustomField24,
		costing.StyleCostingCustomField25 = item.StyleCostingCustomField25,
		costing.StyleCostingCustomField26 = item.StyleCostingCustomField26,
		costing.StyleCostingCustomField27 = item.StyleCostingCustomField27,
		costing.StyleCostingCustomField28 = item.StyleCostingCustomField28,
		costing.StyleCostingCustomField29 = item.StyleCostingCustomField29,
		costing.StyleCostingCustomField30 = item.StyleCostingCustomField30,
		costing.StyleCostingCustomField31 = item.StyleCostingCustomField31,
		costing.StyleCostingCustomField32 = item.StyleCostingCustomField32,
		costing.StyleCostingCustomField33 = item.StyleCostingCustomField33,
		costing.StyleCostingCustomField34 = item.StyleCostingCustomField34,
		costing.StyleCostingCustomField35 = item.StyleCostingCustomField35,
		costing.StyleCostingCustomField36 = item.StyleCostingCustomField36,
		costing.StyleCostingCustomField37 = item.StyleCostingCustomField37,
		costing.StyleCostingCustomField38 = item.StyleCostingCustomField38,
		costing.StyleCostingCustomField39 = item.StyleCostingCustomField39,
		costing.StyleCostingCustomField40 = item.StyleCostingCustomField40,
		costing.StyleCostingCustomField41 = item.StyleCostingCustomField41,
		costing.StyleCostingCustomField42 = item.StyleCostingCustomField42,
		costing.StyleCostingCustomField43 = item.StyleCostingCustomField43,
		costing.StyleCostingCustomField44 = item.StyleCostingCustomField44,
		costing.StyleCostingCustomField45 = item.StyleCostingCustomField45
	FROM pStyleCosting costing
	LEFT JOIN pStyleCostingScenarioItems item
	ON costing.StyleCostingScenarioItemsId = item.StytleCostingScenarioItemsID
	WHERE costing.StyleCostingID = @StyleCostingID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03964', GetDate())
GO

