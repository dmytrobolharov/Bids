/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessBatchQueueCheck_INSERT]    Script Date: 06/08/2010 10:33:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQueueCheck_INSERT] (
@GroupID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @BatchQueueTypeID uniqueidentifier 

BEGIN
CREATE TABLE #TempGroupAccess (
	Id int IDENTITY (1, 1) NOT NULL , 
	BatchQueueTypeID uniqueidentifier NOT NULL
) 
END

BEGIN
	INSERT INTO #TempGroupAccess(BatchQueueTypeID) SELECT BatchQueueTypeID FROM bBatchQueueType

	SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)
	SET @I = 1

	WHILE @I <= @Row_Count 
	BEGIN
		SELECT @BatchQueueTypeID = BatchQueueTypeID FROM #TempGroupAccess WHERE ID = @I

		IF (SELECT COUNT(*) FROM sAccessGroupBatchQueue WITH (NOLOCK) WHERE BatchQueueTypeId = @BatchQueueTypeID AND GroupID = @GroupID) = 0
		BEGIN
			INSERT INTO sAccessGroupBatchQueue(BatchQueueTypeId, GroupID, CUser, CDate, MUser, MDate)
			SELECT BatchQueueTypeId, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
			FROM #TempGroupAccess WHERE Id = @I
		END

		SET @I = @I + 1
	END

	SELECT * FROM #tempGroupAccess
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '142', GetDate())
GO
