/****** Object:  StoredProcedure [dbo].[spx_User_AccessBatchQueue_SELECT]    Script Date: 06/08/2010 14:27:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_User_AccessBatchQueue_SELECT](
@teamId uniqueidentifier
)
AS 

SELECT a.BatchQueueTypeID, b.BatchQueueTypeDescription, a.AccessBatchQueueId, 
       a.AccessRoleId, a.AccessView, a.AccessCreate, 
       a.AccessModify, a.AccessDelete, a.AccessPrint, 
       a.TeamId, a.CUser, a.CDate, a.MUser, a.MDate 
FROM  bBatchQueueType b WITH (NOLOCK) INNER JOIN sAccessBatchQueue a WITH (NOLOCK) ON a.BatchQueueTypeID = b.BatchQueueTypeID
WHERE a.TeamId = @teamId
ORDER BY b.BatchQueueSort, b.BatchQueueTypeDescription
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '143', GetDate())
GO
