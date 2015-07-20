IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplace_tempTransaction_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplace_tempTransaction_INSERT]
GO 


CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_tempTransaction_INSERT(
	@BachQTransactionID UNIQUEIDENTIFIER,
	@BatchQueueMaterialReplaceID UNIQUEIDENTIFIER,
	@CDate DATETIME,
	@CUser NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER
)
AS 

DELETE bBatchQueuMaterialColorReplaceTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialColorReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	

DELETE bBatchQueuMaterialSizeReplaceTmp 
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialSizeReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	


DELETE bBatchQueuMaterialReplaceTransactionTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
WHERE a.TeamID = @TeamID	


INSERT INTO bBatchQueuMaterialReplaceTransactionTmp(
	BachQTransactionID ,
	BatchQueueMaterialReplaceID ,
	CDate,
	CUser, 
	TeamID)
VALUES (
	@BachQTransactionID ,
	@BatchQueueMaterialReplaceID ,
	@CDate,
	@CUser, 
	@TeamID)
	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01443', GetDate())
GO




