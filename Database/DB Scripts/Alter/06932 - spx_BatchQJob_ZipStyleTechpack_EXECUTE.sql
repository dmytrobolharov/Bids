IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS

	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06932', GetDate())
GO
