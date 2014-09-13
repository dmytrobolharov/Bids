IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleCosting_SEL]'))
DROP VIEW [dbo].[vwx_StyleCosting_SEL]
GO


CREATE VIEW [dbo].[vwx_StyleCosting_SEL]
AS

SELECT     dbo.pStyleCosting.StyleCostingID as ScenarioID, dbo.pStyleCosting.StyleCostingID, dbo.pStyleCosting.StyleCostingTypeID, dbo.pStyleCosting.StyleID, dbo.pStyleCosting.StyleCostingFreightTypeID, 
                      dbo.pStyleCosting.StyleQuotaDutyID, dbo.pStyleCosting.StyleCostingDate, dbo.pStyleCosting.StyleCostingStatus, dbo.pStyleCosting.StyleCostingCustomField1, 
                      dbo.pStyleCosting.StyleCostingCustomField2, dbo.pStyleCosting.StyleCostingCustomField3, dbo.pStyleCosting.StyleCostingCustomField4, 
                      dbo.pStyleCosting.StyleCostingCustomField5, dbo.pStyleCosting.StyleCostingCustomField6, dbo.pStyleCosting.StyleCostingCustomField7, 
                      dbo.pStyleCosting.StyleCostingCustomField8, dbo.pStyleCosting.StyleCostingCustomField9, dbo.pStyleCosting.StyleCostingCustomField10, 
                      dbo.pStyleCosting.StyleCostingCustomField11, dbo.pStyleCosting.StyleCostingCustomField12, dbo.pStyleCosting.StyleCostingCustomField13, 
                      dbo.pStyleCosting.StyleCostingCustomField14, dbo.pStyleCosting.StyleCostingCustomField15, dbo.pStyleCosting.StyleCostingCustomField16, 
                      dbo.pStyleCosting.StyleCostingCustomField17, dbo.pStyleCosting.StyleCostingCustomField18, dbo.pStyleCosting.StyleCostingCustomField19, 
                      dbo.pStyleCosting.StyleCostingCustomField20, dbo.pStyleCosting.StyleCostingCustomField21, dbo.pStyleCosting.StyleCostingCustomField22, 
                      dbo.pStyleCosting.StyleCostingCustomField23, dbo.pStyleCosting.StyleCostingCustomField24, dbo.pStyleCosting.StyleCostingCustomField25, 
                      dbo.pStyleCosting.StyleCostingCustomField26, dbo.pStyleCosting.StyleCostingCustomField27, dbo.pStyleCosting.StyleCostingCustomField28, 
                      dbo.pStyleCosting.StyleCostingCustomField29, dbo.pStyleCosting.StyleCostingCustomField31, dbo.pStyleCosting.StyleCostingCustomField30, 
                      dbo.pStyleCosting.StyleCostingCustomField32, dbo.pStyleCosting.StyleCostingCustomField33, dbo.pStyleCosting.StyleCostingCustomField34, 
                      dbo.pStyleCosting.StyleCostingCustomField35, 
                      dbo.pStyleCosting.CUser, dbo.pStyleCosting.CDate, dbo.pStyleCosting.MUser, dbo.pStyleCosting.MDate, 
                      dbo.pStyleCosting.Active, dbo.pStyleCosting.StyleSeasonYearID, dbo.pStyleCosting.StyleColorwayID, 
                      dbo.pStyleCosting.BOMCost, dbo.pStyleCosting.BOLCurr, dbo.pStyleCosting.BOLCost, dbo.pStyleCosting.StyleBOMDimensionID, dbo.pStyleCosting.StyleSourcingID, dbo.pStyleCosting.StyleNBOLHeaderID, 
                      dbo.pStyleCosting.StyleCostingHeaderId, dbo.pStyleCosting.StyleCostingName, dbo.pStyleCosting.StyleCostingCurrency, 
                      dbo.pStyleCosting.StyleCostingConvertedCurr, dbo.pStyleCosting.AdditionalCost, dbo.pStyleCosting.StyleCostingHTS, dbo.pStyleCosting.StyleCostingComments, 
                      NULL as StyleCostingScenarioNo, dbo.pStyleCosting.StyleCostingCustomField36, dbo.pStyleCosting.StyleCostingScenarioItemsId, 
                      dbo.pStyleCosting.StyleCostingCustomField37, dbo.pStyleCosting.StyleCostingCustomField38, dbo.pStyleCosting.StyleCostingCustomField39, 
                      dbo.pStyleCosting.StyleCostingCustomField40, dbo.pStyleCosting.StyleCostingCustomField41, dbo.pStyleCosting.StyleCostingCustomField42, 
                      dbo.pStyleCosting.StyleCostingCustomField43, dbo.pStyleCosting.StyleCostingCustomField44, dbo.pStyleCosting.StyleCostingCustomField45,
                      BOL_wi.WorkFlowItemID as BOL_WorkflowItemID, BOL_wi.WorkFlowItemName as BOLname, BOM_wi.WorkFlowItemID as BOM_WorkflowItemID, BOM_wi.WorkFlowItemName as BOMname,
                      pStyleCostingType.StyleCostingType,
                      (SELECT ISNULL(SUM(MaterialCost),0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = pStyleCosting.StyleCostingScenarioItemsId) as BOMTotal,
                      (SELECT ISNULL(SUM(OperationCost),0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = pStyleCosting.StyleCostingScenarioItemsId) as BOLTotal,
                      (SELECT ISNULL(SUM(AdditionalItemCost),0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = pStyleCosting.StyleCostingScenarioItemsId) as AdditionalTotal,
                      dbo.pStyleCosting.StyleCostingCustomField14 as Cost,
                      0 as Sort
FROM         dbo.pStyleCosting INNER JOIN
                      dbo.pStyleHeader ON dbo.pStyleCosting.StyleID = dbo.pStyleHeader.StyleID LEFT JOIN
                      dbo.pStyleNBOLHeader ON dbo.pStyleCosting.StyleNBOLHeaderID = dbo.pStyleNBOLHeader.StyleNBOLHeaderID LEFT JOIN
                      dbo.pWorkFlowItem BOL_wi ON dbo.pStyleNBOLHeader.WorkFlowItemID = BOL_wi.WorkFlowItemID LEFT JOIN
                      dbo.pStyleBOMDimension ON dbo.pStyleCosting.StyleBOMDimensionID = dbo.pStyleBOMDimension.StyleBOMDimensionID LEFT JOIN
                      dbo.pWorkFlowItem BOM_wi ON dbo.pStyleBOMDimension.WorkFlowItemID = BOM_wi.WorkFlowItemID LEFT JOIN
                      dbo.pStyleCostingType ON dbo.pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID 
WHERE StyleCostingHeaderId IS NOT NULL -- in order to show only costings added in new costing workflow
			
UNION

SELECT     dbo.pStyleCostingScenarioItems.StytleCostingScenarioItemsID as ScenarioID, dbo.pStyleCostingScenarioItems.StyleCostingID, dbo.pStyleCostingScenarioItems.StyleCostingTypeID, dbo.pStyleCostingScenarioItems.StyleID, dbo.pStyleCostingScenarioItems.StyleCostingFreightTypeID, 
                      dbo.pStyleCostingScenarioItems.StyleQuotaDutyID, dbo.pStyleCostingScenarioItems.StyleCostingDate, dbo.pStyleCostingScenarioItems.StyleCostingStatus, dbo.pStyleCostingScenarioItems.StyleCostingCustomField1, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField2, dbo.pStyleCostingScenarioItems.StyleCostingCustomField3, dbo.pStyleCostingScenarioItems.StyleCostingCustomField4, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField5, dbo.pStyleCostingScenarioItems.StyleCostingCustomField6, dbo.pStyleCostingScenarioItems.StyleCostingCustomField7, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField8, dbo.pStyleCostingScenarioItems.StyleCostingCustomField9, dbo.pStyleCostingScenarioItems.StyleCostingCustomField10, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField11, dbo.pStyleCostingScenarioItems.StyleCostingCustomField12, dbo.pStyleCostingScenarioItems.StyleCostingCustomField13, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField14, dbo.pStyleCostingScenarioItems.StyleCostingCustomField15, dbo.pStyleCostingScenarioItems.StyleCostingCustomField16, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField17, dbo.pStyleCostingScenarioItems.StyleCostingCustomField18, dbo.pStyleCostingScenarioItems.StyleCostingCustomField19, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField20, dbo.pStyleCostingScenarioItems.StyleCostingCustomField21, dbo.pStyleCostingScenarioItems.StyleCostingCustomField22, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField23, dbo.pStyleCostingScenarioItems.StyleCostingCustomField24, dbo.pStyleCostingScenarioItems.StyleCostingCustomField25, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField26, dbo.pStyleCostingScenarioItems.StyleCostingCustomField27, dbo.pStyleCostingScenarioItems.StyleCostingCustomField28, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField29, dbo.pStyleCostingScenarioItems.StyleCostingCustomField31, dbo.pStyleCostingScenarioItems.StyleCostingCustomField30, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField32, dbo.pStyleCostingScenarioItems.StyleCostingCustomField33, dbo.pStyleCostingScenarioItems.StyleCostingCustomField34, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField35, 
                      dbo.pStyleCostingScenarioItems.CUser, dbo.pStyleCostingScenarioItems.CDate, dbo.pStyleCostingScenarioItems.MUser, dbo.pStyleCostingScenarioItems.MDate, 
                      dbo.pStyleCostingScenarioItems.Active, dbo.pStyleCostingScenarioItems.StyleSeasonYearID, dbo.pStyleCostingScenarioItems.StyleColorwayID, 
                      dbo.pStyleCostingScenarioItems.BOMCost, dbo.pStyleCostingScenarioItems.BOLCurr, dbo.pStyleCostingScenarioItems.BOLCost, dbo.pStyleCostingScenarioItems.StyleBOMDimensionID, dbo.pStyleCostingScenarioItems.StyleSourcingID, dbo.pStyleCostingScenarioItems.StyleNBOLHeaderID, 
                      dbo.pStyleCostingScenarioItems.StyleCostingHeaderId, dbo.pStyleCostingScenarioItems.StyleCostingName, dbo.pStyleCostingScenarioItems.StyleCostingCurrency, 
                      dbo.pStyleCostingScenarioItems.StyleCostingConvertedCurr, dbo.pStyleCostingScenarioItems.AdditionalCost, dbo.pStyleCostingScenarioItems.StyleCostingHTS, dbo.pStyleCostingScenarioItems.StyleCostingComments, 
                      dbo.pStyleCostingScenarioItems.StyleCostingScenarioNo, dbo.pStyleCostingScenarioItems.StyleCostingCustomField36, NULL, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField37, dbo.pStyleCostingScenarioItems.StyleCostingCustomField38, dbo.pStyleCostingScenarioItems.StyleCostingCustomField39, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField40, dbo.pStyleCostingScenarioItems.StyleCostingCustomField41, dbo.pStyleCostingScenarioItems.StyleCostingCustomField42, 
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField43, dbo.pStyleCostingScenarioItems.StyleCostingCustomField44, dbo.pStyleCostingScenarioItems.StyleCostingCustomField45,
                      BOL_wi.WorkFlowItemID as BOL_WorkflowItemID, BOL_wi.WorkFlowItemName as BOLname, BOM_wi.WorkFlowItemID as BOM_WorkflowItemID, BOM_wi.WorkFlowItemName as BOMname,
                      pStyleCostingType.StyleCostingType,
                      (SELECT ISNULL(SUM(MaterialCost),0) FROM pstyleCostingBOM WHERE pstyleCostingBOM.StytleCostingScenarioItemsId = pStyleCostingScenarioItems.StytleCostingScenarioItemsId) as BOMTotal,
                      (SELECT ISNULL(SUM(OperationCost),0) FROM pStyleCostingBOL WHERE pStyleCostingBOL.StytleCostingScenarioItemsId = pStyleCostingScenarioItems.StytleCostingScenarioItemsId) as BOLTotal,
                      (SELECT ISNULL(SUM(AdditionalItemCost),0) FROM pstyleCostingAdditionalItems WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsId = pStyleCostingScenarioItems.StytleCostingScenarioItemsId) as AdditionalTotal,
                      dbo.pStyleCostingScenarioItems.StyleCostingCustomField14 as Cost,
                      1 as Sort
FROM         dbo.pStyleCostingScenarioItems INNER JOIN
                      dbo.pStyleHeader ON dbo.pStyleCostingScenarioItems.StyleID = dbo.pStyleHeader.StyleID LEFT JOIN
                      dbo.pStyleNBOLHeader ON dbo.pStyleCostingScenarioItems.StyleNBOLHeaderID = dbo.pStyleNBOLHeader.StyleNBOLHeaderID LEFT JOIN
                      dbo.pWorkFlowItem BOL_wi ON dbo.pStyleNBOLHeader.WorkFlowItemID = BOL_wi.WorkFlowItemID LEFT JOIN
                      dbo.pStyleBOMDimension ON dbo.pStyleCostingScenarioItems.StyleBOMDimensionID = dbo.pStyleBOMDimension.StyleBOMDimensionID LEFT JOIN
                      dbo.pWorkFlowItem BOM_wi ON dbo.pStyleBOMDimension.WorkFlowItemID = BOM_wi.WorkFlowItemID LEFT JOIN
                      dbo.pStyleCostingType ON dbo.pStyleCostingScenarioItems.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID 
                      
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05340', GetDate())
GO
