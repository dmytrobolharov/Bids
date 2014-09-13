IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplace_tempMaterialSize_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplace_tempMaterialSize_INSERT]
GO 

CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_tempMaterialSize_INSERT(
	@BachQTransactionID UNIQUEIDENTIFIER,
	@MaterialSizeFindID UNIQUEIDENTIFIER,
	@MaterialSizeReplaceID UNIQUEIDENTIFIER
)
AS 


INSERT INTO bBatchQueuMaterialSizeReplaceTmp(
	BachQTransactionID,
	MaterialSizeFindID, 
	MaterialSizeReplaceID
)
VALUES(
	@BachQTransactionID,
	@MaterialSizeFindID, 
	@MaterialSizeReplaceID
)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01442', GetDate())

GO
