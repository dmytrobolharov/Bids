-- Select Multiple Dimensional BOM Pages
IF NOT EXISTS(SELECT BatchQueuePageTypeID FROM pBatchQueuePageType WHERE BatchQueuePageTypeID='54E6E4E3-DD70-E011-9039-8EF3DCCB61B4')
BEGIN
	INSERT INTO pBatchQueuePageType (BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, 
	BatchQueuePageXmlSearch, BatchQueuePageXmlGrid, BatchQueuePageXmlSelected, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, 
	BatchQueuePageSPX)
	VALUES ('54E6E4E3-DD70-E011-9039-8EF3DCCB61B4', 'Select multiple Dimensional BOM pages', 'Please select multiple Dimensional BOM pages', 'StyleBOMDimensionID', 
	'BatchQ_BOMPage_MaterialAdd_Search.xml', 'BatchQ_BOMPage_MaterialAdd_Default.xml', 'BatchQ_BOMPage_MaterialAdd_Selected.xml', 'BatchQ_Grid.aspx', 'M', 50,
	'spx_BatchQGrid_BOMMaterialAdd_Select')
END

-- Add Material To Dimensional BOMs Review
IF NOT EXISTS(SELECT BatchQueuePageTypeID FROM pBatchQueuePageType WHERE BatchQueuePageTypeID='54E6E4E3-DD70-E011-9039-8EF3DCCB61C4')
BEGIN
	INSERT INTO pBatchQueuePageType (BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, 
	BatchQueuePageXmlForm, BatchQueuePageXmlGrid, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, 
	BatchQueuePageSPX, BatchQueueExecuteSPX, BatchQueuePageXmlColorGrid)
	VALUES ('54E6E4E3-DD70-E011-9039-8EF3DCCB61C4', 'Batch Queue DBOMs', 'Batch Queue Dimensional BOM Material Add', 'StyleMaterialID', 
	'BatchQ_Material_Default.xml', 'BatchQ_BOMMaterial_Default.xml', 'BatchQ_AddBOMMaterial_Review.aspx', 'M', 0,
	'spx_BatchQGrid_StyleBOMMaterials_Review_SELECT', 'spx_BatchQJob_AddBOMMaterial_EXECUTE', 'BatchQ_StyleMaterial_Color.xml')
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04658', GetDate())
GO
