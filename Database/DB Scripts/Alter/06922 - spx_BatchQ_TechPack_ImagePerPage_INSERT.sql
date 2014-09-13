IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_TechPack_ImagePerPage_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQ_TechPack_ImagePerPage_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQ_TechPack_ImagePerPage_INSERT](
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@NumberOfImages INT 
)
AS


IF EXISTS ( SELECT * FROM pBatchQTechPackImagePerPage WITH(NOLOCK) WHERE BatchQueueJobID = @BatchQueueJobId)
	UPDATE pBatchQTechPackImagePerPage SET NumberOfImages = @NumberOfImages WHERE BatchQueueJobID = @BatchQueueJobId
ELSE
	INSERT INTO pBatchQTechPackImagePerPage ( BatchQueueJobID , NumberOfImages)
	VALUES (@BatchQueueJobID, @NumberOfImages)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06922', GetDate())
GO
