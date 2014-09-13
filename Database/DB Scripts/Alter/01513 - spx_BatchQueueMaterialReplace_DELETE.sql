IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_BatchQueueMaterialReplace_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_BatchQueueMaterialReplace_DELETE
GO

CREATE  PROCEDURE [dbo].[spx_BatchQueueMaterialReplace_DELETE]
(
	@BatchQueueMaterialReplaceID uniqueidentifier
)
AS 

DELETE FROM bBatchQueueMaterialReplace
WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01513', GetDate())
GO
