/****** Object:  StoredProcedure [dbo].[spx_BatchQueue_SELECT]    Script Date: 06/07/2010 14:58:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_BatchQueue_SELECT](
@BatchQueueTypeID UNIQUEIDENTIFIER,
@TeamID UNIQUEIDENTIFIER 
)
AS 

IF @BatchQueueTypeID IS NULL AND @TeamID IS NULL
BEGIN

	SELECT bBatchQueue.BatchQueueID, bBatchQueue.TeamID, Users.UserName, bBatchQueue.BatchQueueTypeID, bBatchQueueType.BatchQueueTypeDescription, 
	       bBatchQueue.ItemID, bBatchQueue.ItemDescription, bBatchQueue.BatchQueueXMLData, 
	       bBatchQueue.BatchQueueStatusID, bBatchQueueStatus.BatchQueueStatusDescription,
	       bBatchQueue.BatchQueueComments, bBatchQueue.CUser, bBatchQueue.CDate, 
	       bBatchQueue.MUser, bBatchQueue.MDate

	FROM bBatchQueue 
	INNER JOIN Users ON bBatchQueue.TeamID = Users.TeamID
	INNER JOIN bBatchQueueType ON bBatchQueue.BatchQueueTypeID = bBatchQueueType.BatchQueueTypeID
	INNER JOIN bBatchQueueStatus ON bBatchQueue.BatchQueueStatusID = bBatchQueueStatus.BatchQueueStatusID

	ORDER BY bBatchQueueType.BatchQueueSort, bBatchQueueType.BatchQueueTypeDescription, Users.UserName, bBatchQueue.CDate

END 
ELSE IF @BatchQueueTypeID IS NULL 
BEGIN 

	SELECT bBatchQueue.BatchQueueID, bBatchQueue.TeamID, Users.UserName, bBatchQueue.BatchQueueTypeID, bBatchQueueType.BatchQueueTypeDescription, 
	       bBatchQueue.ItemID, bBatchQueue.ItemDescription, bBatchQueue.BatchQueueXMLData, 
	       bBatchQueue.BatchQueueStatusID, bBatchQueueStatus.BatchQueueStatusDescription,
	       bBatchQueue.BatchQueueComments, bBatchQueue.CUser, bBatchQueue.CDate, 
	       bBatchQueue.MUser, bBatchQueue.MDate

	FROM bBatchQueue 
	INNER JOIN Users ON bBatchQueue.TeamID = Users.TeamID
	INNER JOIN bBatchQueueType ON bBatchQueue.BatchQueueTypeID = bBatchQueueType.BatchQueueTypeID
	INNER JOIN bBatchQueueStatus ON bBatchQueue.BatchQueueStatusID = bBatchQueueStatus.BatchQueueStatusID

	WHERE bBatchQueue.TeamID = @TeamID

	ORDER BY bBatchQueueType.BatchQueueSort, bBatchQueueType.BatchQueueTypeDescription, Users.UserName, bBatchQueue.CDate

END 
ELSE IF @TeamID IS NULL
BEGIN 

	SELECT bBatchQueue.BatchQueueID, bBatchQueue.TeamID, Users.UserName, bBatchQueue.BatchQueueTypeID, bBatchQueueType.BatchQueueTypeDescription, 
	       bBatchQueue.ItemID, bBatchQueue.ItemDescription, bBatchQueue.BatchQueueXMLData, 
	       bBatchQueue.BatchQueueStatusID, bBatchQueueStatus.BatchQueueStatusDescription,
	       bBatchQueue.BatchQueueComments, bBatchQueue.CUser, bBatchQueue.CDate, 
	       bBatchQueue.MUser, bBatchQueue.MDate

	FROM bBatchQueue 
	INNER JOIN Users ON bBatchQueue.TeamID = Users.TeamID
	INNER JOIN bBatchQueueType ON bBatchQueue.BatchQueueTypeID = bBatchQueueType.BatchQueueTypeID
	INNER JOIN bBatchQueueStatus ON bBatchQueue.BatchQueueStatusID = bBatchQueueStatus.BatchQueueStatusID

	WHERE bBatchQueue.BatchQueueTypeID = @BatchQueueTypeID

	ORDER BY bBatchQueueType.BatchQueueSort, bBatchQueueType.BatchQueueTypeDescription, Users.UserName, bBatchQueue.CDate

END 
ELSE 
BEGIN 

	SELECT bBatchQueue.BatchQueueID, bBatchQueue.TeamID, Users.UserName, bBatchQueue.BatchQueueTypeID, bBatchQueueType.BatchQueueTypeDescription, 
	       bBatchQueue.ItemID, bBatchQueue.ItemDescription, bBatchQueue.BatchQueueXMLData, 
	       bBatchQueue.BatchQueueStatusID, bBatchQueueStatus.BatchQueueStatusDescription,
	       bBatchQueue.BatchQueueComments, bBatchQueue.CUser, bBatchQueue.CDate, 
	       bBatchQueue.MUser, bBatchQueue.MDate

	FROM bBatchQueue 
	INNER JOIN Users ON bBatchQueue.TeamID = Users.TeamID
	INNER JOIN bBatchQueueType ON bBatchQueue.BatchQueueTypeID = bBatchQueueType.BatchQueueTypeID
	INNER JOIN bBatchQueueStatus ON bBatchQueue.BatchQueueStatusID = bBatchQueueStatus.BatchQueueStatusID

	WHERE bBatchQueue.BatchQueueTypeID = @BatchQueueTypeID
	AND bBatchQueue.TeamID = @TeamID

	ORDER BY bBatchQueueType.BatchQueueSort, bBatchQueueType.BatchQueueTypeDescription, Users.UserName, bBatchQueue.CDate

END 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '146', GetDate())
GO
