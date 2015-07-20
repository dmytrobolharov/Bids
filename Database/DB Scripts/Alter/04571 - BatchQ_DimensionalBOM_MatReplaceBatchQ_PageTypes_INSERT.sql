-- Select Multiple Dimensional BOM Pages
IF NOT EXISTS (SELECT BatchQueuePageTypeID FROM pBatchQueuePageType WHERE BatchQueuePageTypeID='54E5E4E3-DD70-E011-9039-8EF3DCCB61B4')
BEGIN
	INSERT INTO pBatchQueuePageType (BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, BatchQueuePageXmlSearch,
				BatchQueuePageXmlGrid, BatchQueuePageXmlSelected, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, BatchQueuePageSPX,
				BatchQueuepageXMLGridAlternating, BatchQueueGridAlternatingName, BatchQueueGridXMLThumbnail)
	VALUES ('54E5E4E3-DD70-E011-9039-8EF3DCCB61B4', 'Select multiple Dimensional BOM pages', 'Please select multiple Dimensional BOM pages', 'StyleBOMDimensionID', 'BatchQ_BOMPage_MaterialReplace_Search.xml',
			'BatchQ_BOMPage_MaterialReplace_Default.xml', 'BatchQ_BOMPage_MaterialReplace_Selected.xml', 'BatchQ_Grid.aspx', 'M', 50, 'spx_BatchQGrid_MaterialReplace_BOM_SELECT',
			NULL, NULL, NULL)
END

-- Batch Queue DBOMs 
IF NOT EXISTS (SELECT BatchQueuePageTypeID FROM pBatchQueuePageType WHERE BatchQueuePageTypeID='D0C913C0-7D8C-E011-81E9-005056C00013')
BEGIN
	INSERT INTO pBatchQueuePageType (BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, BatchQueuePageXmlForm,
				BatchQueuePageXmlGrid, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, BatchQueuePageSPX, BatchQueueExecuteSPX)
	VALUES ('D0C913C0-7D8C-E011-81E9-005056C00013', 'Batch Queue DBOMs', 'Batch Queue Dimensional BOM Material Replace', 'StyleMaterialID', 'BatchQ_MaterialReplace_Default.xml',
			'BatchQ_BOMMaterialReplace_Default.xml', 'BatchQ_DimBOM_MaterialReplace_Final.aspx', 'M', 0, 'spx_BatchQGrid_MaterialReplace_BOM_Review_SELECT', 'spx_BatchQJob_MaterialReplace_BOM_EXECUTE')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04571', GetDate())
GO
