IF NOT EXISTS (SELECT * from pLineListFlashEdit WHERE LineListFlashEditName = 'Style Header')
	INSERT INTO pLineListFlashEdit (LineListFlashEditName, LineListFlashEditDescription, LineListFlashEditSort, LineListFlashEditActive, LineListFlashEditGridXML, LineListFlashEditBatchXML, LineListFlashEditSearchXML)
	VALUES ('Style Header', 'Style Header', 0, 1, 'LineListFlashEdit_StyleHeader_Grid.xml', 'LineListFlashEdit_StyleHeader_Batch.xml', 'LineListFlashEdit_StyleHeader_Search.xml')
GO

IF NOT EXISTS (SELECT * from pLineListFlashEdit WHERE LineListFlashEditName = 'Style Costing Property')
	INSERT INTO pLineListFlashEdit (LineListFlashEditName, LineListFlashEditDescription, LineListFlashEditSort, LineListFlashEditActive, LineListFlashEditGridXML, LineListFlashEditBatchXML, LineListFlashEditSearchXML, LineListFlashEditUpdateLogicSPX)
	VALUES ('Style Costing Property', 'Style Costing Property', 1, 1, 'LineListFlashEdit_StyleCostingProperty_Grid.xml', 'LineListFlashEdit_StyleCostingProperty_Batch.xml', 'LineListFlashEdit_StyleCostingProperty_Search.xml', 'spx_LineListFlashEdit_CostingProperty_Logic_UPDATE')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07350', GetDate())
GO
