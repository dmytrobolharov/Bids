INSERT INTO pBatchQueuePageDep (
	BatchQueuePageDepID,
	BatchQueuePageID,
	BatchQueuePageRelationID
) VALUES (
	NEWID(),
	(
		SELECT BatchQueuePageID
		FROM pBatchQueuePage
		WHERE BatchQueuePageTypeID = 'D0C913C0-7D8C-E011-81E9-005056C00010'
			AND BatchQueueID = '90000000-0000-0000-0000-000000000015'
		),
	(
		SELECT BatchQueuePageID
		FROM pBatchQueuePage
		WHERE BatchQueuePageTypeID = '99A5E4E3-DD70-E011-9039-8EF3DCCB61B6'
			AND BatchQueueID = '90000000-0000-0000-0000-000000000015'
		)
	)
	
INSERT INTO pBatchQueuePageDep (
	BatchQueuePageDepID,
	BatchQueuePageID,
	BatchQueuePageRelationID
) VALUES (
	NEWID(),
	(
		SELECT BatchQueuePageID
		FROM pBatchQueuePage
		WHERE BatchQueuePageTypeID = 'D0C913C0-7D8C-E011-81E9-005056C00011'
			AND BatchQueueID = '90000000-0000-0000-0000-000000000015'
		),
	(
		SELECT BatchQueuePageID
		FROM pBatchQueuePage
		WHERE BatchQueuePageTypeID = '99A5E4E3-DD70-E011-9039-8EF3DCCB61B6'
			AND BatchQueueID = '90000000-0000-0000-0000-000000000015'
		)
	)

GO

	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07328', GetDate())
GO
