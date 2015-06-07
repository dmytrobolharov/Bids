DECLARE @TableName NVARCHAR(500)
DECLARE @PrimaryKey NVARCHAR(500)
DECLARE @MigrateSQL NVARCHAR(MAX)

DECLARE BatchQueueJobItem CURSOR FAST_FORWARD
FOR
SELECT job.BatchQueueJobTable, pgt.BatchQueuePagePkID FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON job.BatchQueuePageID = pg.BatchQueuePageID
INNER JOIN pBatchQueuePageType pgt ON pgt.BatchQueuePageTypeID = pg.BatchQueuePageTypeID
OPEN BatchQueueJobItem

FETCH NEXT FROM BatchQueueJobItem INTO @TableName, @PrimaryKey
WHILE @@FETCH_STATUS = 0
BEGIN
	
	SET @MigrateSQL = 
	'
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[' + @TableName  + ']'') AND type in (N''U''))
	BEGIN
		INSERT INTO pBatchQueueJobItemRecord (BatchQueueJobItemRecordID, BatchQueueJobItemID, BatchQueueJobID, BatchQueuePageID, BatchQueuePagePki, BatchQueueID, CUser, CDate)
		SELECT NEWID(), BatchQueueJobItemID, BatchQueueJobID, BatchQueuePageID, ' + @PrimaryKey + ', BatchQueueID, CUser, CDate
		FROM ' + @TableName + ' src
		WHERE NOT EXISTS (SELECT * FROM pBatchQueueJobItemRecord r WHERE r.BatchQueueJobItemID = src.BatchQueueJobItemID AND r.BatchQueuePagePki = src.' + @PrimaryKey + ')
	END
	'
	EXEC sp_executesql @MigrateSQL

	FETCH NEXT FROM BatchQueueJobItem INTO @TableName, @PrimaryKey
END

CLOSE BatchQueueJobItem
DEALLOCATE BatchQueueJobItem

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09774', GetDate())
GO

