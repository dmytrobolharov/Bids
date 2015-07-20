INSERT INTO pBatchQueuePageDep (
	BatchQueuePageDepID,
	BatchQueuePageID,
	BatchQueuePageRelationID
) VALUES (
	NEWID(),
	(
		SELECT BatchQueuePageID
		FROM pBatchQueuePage
		WHERE BatchQueuePageTypeID = '74495F03-D78B-E011-81E9-005056C00009'
			AND BatchQueueID = '90000000-0000-0000-0000-000000000017'
		),
	(
		SELECT BatchQueuePageID
		FROM pBatchQueuePage
		WHERE BatchQueuePageTypeID = '74495F03-D78B-E011-81E9-005056C00008'
			AND BatchQueueID = '90000000-0000-0000-0000-000000000017'
		)
	)
	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07455', GetDate())
GO