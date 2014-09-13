
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplace_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE spx_BatchQueueMaterialFindReplace_SELECT
END
GO

CREATE PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplace_SELECT]
( 
	@BatchQueueMaterialReplaceID uniqueidentifier
) 
AS

SELECT * FROM bBatchQueueMaterialReplace WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01010', GetDate())
GO
