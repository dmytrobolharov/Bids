IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQType_SELECT](
	@TeamID UNIQUEIDENTIFIER = NULL,
	@srmOn INT = 0
)
AS 

IF @srmOn = 0 
	SELECT DISTINCT a.* 
	FROM pBatchQueueType a WITH(NOLOCK)
		INNER JOIN sAccessBatchQFolderItems b WITH(NOLOCK) ON a.BatchQueueTypeID = b.BatchQTypeID
	WHERE b.TeamID = @TeamID
	 AND b.AccessRoleId = 3
ELSE 
	SELECT * FROM dbo.pBatchQueueType WITH(NOLOCK) WHERE srmOn = 1

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06935', GetDate())
GO
