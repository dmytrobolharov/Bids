IF NOT EXISTS(SELECT BatchQueueID FROM pBatchQueue WHERE BatchQueueID = '90000000-0000-0000-0000-000000000016')
BEGIN
	INSERT INTO pBatchQueue (BatchQueueID, BatchQueueTypeID, BatchQueueName, BatchQueueDesc, BatchQueueUrl, BatchQueueIcon, BatchQueuePageHistoryUrl)
	VALUES('90000000-0000-0000-0000-000000000016', 'F459C2F2-657A-E011-9848-005056C00008', 'Mass Add Material to Dimensional BOMs', 
	'Batch Queue Mass Add Material to Dimensional BOMs', 'BatchQ_Page.aspx', 'icon_tables_stacks.gif', 'BatchQ_AddBOMMaterial_Review.aspx')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04656', GetDate())
GO
