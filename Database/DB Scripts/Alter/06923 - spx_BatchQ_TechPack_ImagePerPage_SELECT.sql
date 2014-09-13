IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_TechPack_ImagePerPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQ_TechPack_ImagePerPage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQ_TechPack_ImagePerPage_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS

SELECT NumberOfImages FROM pBatchQTechPackImagePerPage WITH(NOLOCK) WHERE BatchQueueJobID = @BatchQueueJobId



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06923', GetDate())
GO
