
--pBatchQueue
insert into pBatchQueue(BatchQueueID,BatchQueueTypeID,BatchQueueName,BatchQueueDesc,BatchQueueUrl,BatchQueueIcon,BatchQueuePageHistoryUrl) 
values('90000000-0000-0000-0000-000000000017','F459C2F2-657A-E011-9848-005056C00008','Mass Add Material Group to Dimensional BOM','Mass Add Material Group to Dimensional BOM','BatchQ_Page.aspx','icon_tables_stacks.gif','BatchQ_AddBOMMaterialGroup_Review.aspx')


--pBatchQueuePageType
IF NOT EXISTS(SELECT BatchQueuePageTypeID FROM pBatchQueuePageType WHERE BatchQueuePageTypeID='54E6E4E3-DD70-E011-9039-8EF3DCCB61B4')
BEGIN
	INSERT INTO pBatchQueuePageType (BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, 
	BatchQueuePageXmlSearch, BatchQueuePageXmlGrid, BatchQueuePageXmlSelected, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, 
	BatchQueuePageSPX)
	VALUES ('54E6E4E3-DD70-E011-9039-8EF3DCCB61B4', 'Select multiple Dimensional BOM pages', 'Please select multiple Dimensional BOM pages', 'StyleBOMDimensionID', 
	'BatchQ_BOMPage_MaterialAdd_Search.xml', 'BatchQ_BOMPage_MaterialAdd_Default.xml', 'BatchQ_BOMPage_MaterialAdd_Selected.xml', 'BatchQ_Grid.aspx', 'M', 50,
	'spx_BatchQGrid_BOMMaterialAdd_Select')
END


IF NOT EXISTS(SELECT BatchQueuePageTypeID FROM pBatchQueuePageType WHERE BatchQueuePageTypeID='C1C913C0-7D8C-E011-81E9-005056C00018')
BEGIN
	INSERT INTO pBatchQueuePageType (BatchQueuePageTypeID, BatchQueuePageTypeName, BatchQueuePageTypeDesc, BatchQueuePagePkID, 
	BatchQueuePageXmlForm, BatchQueuePageXmlGrid, BatchQueuePageUrl, BatchQueuePageRecType, BatchQueuePageRecMax, 
	BatchQueuePageSPX, BatchQueueExecuteSPX)
	VALUES ('C1C913C0-7D8C-E011-81E9-005056C00018', 'Batch Queue DBOMs', 'Batch Queue Dimensional BOM Material Group Add', 'StyleMaterialID', 
	'BatchQ_BOMMaterialReplace_Default.xml', 'BatchQ_BOMMaterialReplace_Default.xml', 'BatchQ_AddBOMMaterialGroup_Review.aspx', 'M', 0,
	'spx_BatchQGrid_MaterialGroupReplace_BOM_Review_SELECT', 'spx_BatchQJob_AddBOMMaterialGroup_EXECUTE')
END

insert into pBatchQueuePage(BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder) 
values('99A5E4E3-DD70-E011-9039-8EF3DCCB61B6','90000000-0000-0000-0000-000000000017','0000')
insert into pBatchQueuePage(BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder) 
values('74495F03-D78B-E011-81E9-005056C00008','90000000-0000-0000-0000-000000000017','0001')
insert into pBatchQueuePage(BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder) 
values('74495F03-D78B-E011-81E9-005056C00009','90000000-0000-0000-0000-000000000017','0002')
insert into pBatchQueuePage(BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder) 
values('44E5E4E3-DD70-E011-9039-8EF3DCCB61B2','90000000-0000-0000-0000-000000000017','0003')
insert into pBatchQueuePage(BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder) 
values('C1C913C0-7D8C-E011-81E9-005056C00018','90000000-0000-0000-0000-000000000017','0004')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04645', GetDate())
GO
