IF NOT EXISTS (SELECT * from pPlanningFlashEdit WHERE PlanningFlashEditName = 'Style Header')
	INSERT INTO pPlanningFlashEdit (PlanningFlashEditName, PlanningFlashEditDescription, PlanningFlashEditSort, PlanningFlashEditActive, PlanningFlashEditGridXML, PlanningFlashEditBatchXML, PlanningFlashEditSearchXML)
	VALUES ('Style Header', 'Style Header', 0, 1, 'PlanningFlashEdit_StyleHeader_Grid.xml', 'PlanningFlashEdit_StyleHeader_Batch.xml', 'PlanningFlashEdit_StyleHeader_Search.xml')
GO

IF NOT EXISTS (SELECT * from pPlanningFlashEdit WHERE PlanningFlashEditName = 'Style Costing Property')
	INSERT INTO pPlanningFlashEdit (PlanningFlashEditName, PlanningFlashEditDescription, PlanningFlashEditSort, PlanningFlashEditActive, PlanningFlashEditGridXML, PlanningFlashEditBatchXML, PlanningFlashEditSearchXML, PlanningFlashEditUpdateLogicSPX)
	VALUES ('Style Costing Property', 'Style Costing Property', 1, 1, 'PlanningFlashEdit_StyleCostingProperty_Grid.xml', 'PlanningFlashEdit_StyleCostingProperty_Batch.xml', 'PlanningFlashEdit_StyleCostingProperty_Search.xml', 'spx_PlanningFlashEdit_CostingProperty_Logic_UPDATE')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07334', GetDate())
GO
