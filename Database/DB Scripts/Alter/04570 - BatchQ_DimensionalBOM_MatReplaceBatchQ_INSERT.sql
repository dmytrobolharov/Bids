IF NOT EXISTS(SELECT BatchQueueID FROM pBatchQueue WHERE BatchQueueID = '90000000-0000-0000-0000-000000000015')
BEGIN
	INSERT INTO pBatchQueue (BatchQueueID, BatchQueueTypeID, BatchQueueName, BatchQueueDesc, BatchQueueUrl, BatchQueueIcon, CUser, CDate, MUser, MDate, BatchQueuePageHistoryUrl)
	VALUES ('90000000-0000-0000-0000-000000000015', 'F459C2F2-657A-E011-9848-005056C00008', 'DBOM Material Find & Replace', 'Batch Queue: Replace Material on Multiple Dimensional BOMs', 
	'BatchQ_Page.aspx', 'icon_tables_stacks.gif', NULL, NULL, NULL, NULL, 'BatchQ_DimBOM_MaterialReplace_Final.aspx')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04570', GetDate())
GO
