UPDATE pBatchQueuePageType SET BatchQueuePageXmlSelected = 'BatchQ_TechPackPredefined_Selected_Default.xml' 
WHERE BatchQueuePageTypeID = N'90000000-0000-A000-0003-000000000030'

IF NOT EXISTS(SELECT * FROM pBatchQueuePageType WHERE BatchQueuePageTypeID = N'90000000-0000-A000-0000-100000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) 
	VALUES (N'90000000-0000-A000-0000-100000000030', N'Select Division', N'Select Division', N'CustomID', N'Division_Search.xml', NULL, N'BatchQ_Division_Default.xml', N'BatchQ_Division_Default.xml', N'BatchQ_Grid.aspx', N'S', 1, N'spx_BatchQGrid_Division_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
END


IF NOT EXISTS(SELECT * FROM pBatchQueuePageType WHERE BatchQueuePageTypeID = N'90000000-0000-A000-0000-200000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) 
	VALUES (N'90000000-0000-A000-0000-200000000030', N'Select Style Type', N'Select Style Type', N'StyleTypeRepID', N'BatchQ_StyleType_Search.xml', NULL, N'BatchQ_StyleType_Default.xml', N'BatchQ_StyleType_Default.xml', N'BatchQ_Grid.aspx', N'S', 1, N'spx_BatchQGrid_StyleType_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
END
GO

IF NOT EXISTS(SELECT * FROM pBatchQueuePage WHERE BatchQueuePageID = N'90000000-0000-0000-0000-100000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePage] (
		[BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], 
		[CUser], [CDate], [MUser], [MDate]) 
	VALUES (
		N'90000000-0000-0000-0000-100000000030', N'90000000-0000-A000-0000-100000000030', N'90000000-0000-0000-0000-000000000030', N'0000', 
		NULL, NULL, NULL, NULL)
END
	
IF NOT EXISTS(SELECT * FROM pBatchQueuePage WHERE BatchQueuePageID = N'90000000-0000-0000-0001-100000000030')
BEGIN
INSERT [dbo].[pBatchQueuePage] (
	[BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], 
	[CUser], [CDate], [MUser], [MDate]) 
VALUES (
	N'90000000-0000-0000-0001-100000000030', N'90000000-0000-A000-0000-200000000030', N'90000000-0000-0000-0000-000000000030', N'0001', 
	NULL, NULL, NULL, NULL)
END
	
UPDATE pBatchQueuePage 
SET BatchQueuePageOrder = 
	CASE BatchQueuePageID 
		WHEN '90000000-0000-0000-0000-000000000030' THEN '0000'
		WHEN '90000000-0000-0000-0000-000000000030' THEN '0001'
		WHEN '90000000-0000-0000-0000-100000000030' THEN '0002'
		WHEN '90000000-0000-0000-0001-100000000030' THEN '0003'
		WHEN '90000000-0000-0000-0001-000000000030' THEN '0004'
		WHEN '90000000-0000-0000-0003-000000000030' THEN '0005'
		WHEN '90000000-0000-0000-0002-000000000030' THEN '0006'
		WHEN '90000000-0000-0000-0005-000000000030' THEN '0007'
		ELSE BatchQueuePageOrder
	END
WHERE BatchQueueID = '90000000-0000-0000-0000-000000000030'


IF NOT EXISTS(SELECT * FROM pBatchQueuePageDep WHERE BatchQueuePageDepID = N'90000000-0000-C000-0000-000000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePageDep] (
		[BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) 
	VALUES (
		N'90000000-0000-C000-0000-000000000030', N'90000000-0000-0000-0001-100000000030', N'90000000-0000-0000-0000-100000000030')
END	

IF NOT EXISTS(SELECT * FROM pBatchQueuePageDep WHERE BatchQueuePageDepID = N'90000000-0000-D000-0000-000000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePageDep] (
		[BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) 
	VALUES (
		N'90000000-0000-D000-0000-000000000030', N'90000000-0000-0000-0001-000000000030', N'90000000-0000-0000-0000-100000000030')
END


IF NOT EXISTS(SELECT * FROM pBatchQueuePageDep WHERE BatchQueuePageDepID = N'90000000-0000-E000-0000-000000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePageDep] (
		[BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) 
	VALUES (
		N'90000000-0000-E000-0000-000000000030', N'90000000-0000-0000-0001-000000000030', N'90000000-0000-0000-0001-100000000030')
END

IF NOT EXISTS(SELECT * FROM pBatchQueuePageDep WHERE BatchQueuePageDepID = N'90000000-0000-F000-0000-000000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePageDep] (
		[BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) 
	VALUES (
		N'90000000-0000-F000-0000-000000000030', N'90000000-0000-0000-0003-000000000030', N'90000000-0000-0000-0001-100000000030')
END

IF NOT EXISTS(SELECT * FROM pBatchQueuePageDep WHERE BatchQueuePageDepID = N'90000000-0000-0100-0000-000000000030')
BEGIN
	INSERT [dbo].[pBatchQueuePageDep] (
		[BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) 
	VALUES (
		N'90000000-0000-0100-0000-000000000030', N'90000000-0000-0000-0003-000000000030', N'90000000-0000-0000-0000-100000000030')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09080', GetDate())
GO