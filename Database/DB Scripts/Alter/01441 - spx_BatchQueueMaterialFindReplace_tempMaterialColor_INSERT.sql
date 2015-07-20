IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplace_tempMaterialColor_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplace_tempMaterialColor_INSERT]
GO 

CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_tempMaterialColor_INSERT(
	@BachQTransactionID UNIQUEIDENTIFIER,
	@MaterialColorFindID UNIQUEIDENTIFIER,
	@MaterialColorReplaceID UNIQUEIDENTIFIER
)
AS 


INSERT INTO bBatchQueuMaterialColorReplaceTmp(
	BachQTransactionID,
	MaterialColorFindID, 
	MaterialColorReplaceID
)
VALUES(
	@BachQTransactionID,
	@MaterialColorFindID, 
	@MaterialColorReplaceID
)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01441', GetDate())
GO




