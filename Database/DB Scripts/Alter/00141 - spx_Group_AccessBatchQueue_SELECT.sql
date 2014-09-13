/****** Object:  StoredProcedure [dbo].[spx_Group_AccessBatchQueue_SELECT]    Script Date: 06/08/2010 11:21:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessBatchQueue_SELECT] (
@GroupID uniqueidentifier
)
AS 

SELECT a.BatchQueueTypeID, b.BatchQueueTypeDescription, a.AccessBatchQueueId, 
       a.AccessRoleId, a.AccessView, a.AccessCreate, 
       a.AccessModify, a.AccessDelete, a.AccessPrint, 
       a.GroupID, a.CUser, a.CDate, a.MUser, a.MDate, b.BatchQueueSort 
FROM  bBatchQueueType b WITH (NOLOCK) INNER JOIN sAccessGroupBatchQueue a WITH (NOLOCK) ON a.BatchQueueTypeID = b.BatchQueueTypeID
WHERE a.GroupID = @GroupID 
ORDER BY b.BatchQueueSort, b.BatchQueueTypeDescription
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '141', GetDate())
GO
