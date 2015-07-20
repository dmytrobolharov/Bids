/****** Object:  StoredProcedure [dbo].[spx_User_DesktopAccessBatchQueueCheck_INSERT]    Script Date: 06/08/2010 14:12:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_User_DesktopAccessBatchQueueCheck_INSERT]
(
@TeamId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @BatchQueueTypeId uniqueidentifier
DECLARE @DeskAccessId int
DECLARE @DeskTableName varchar(100)
DECLARE @DeskTableKey varchar(50)

BEGIN
	CREATE TABLE #TempUserAccess (
		Id int IDENTITY (1, 1) NOT NULL , 
		BatchQueueTypeId uniqueidentifier NOT NULL,
		TeamId uniqueidentifier
	) 
END

BEGIN
	INSERT INTO #TempUserAccess(BatchQueueTypeId) SELECT BatchQueueTypeId FROM bBatchQueueType WITH (NOLOCK)

	SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)

	SET @I = 1

	WHILE @I <= @Row_Count 
	BEGIN
		SELECT @BatchQueueTypeId = BatchQueueTypeId FROM #TempUserAccess WHERE ID = @I
		IF (SELECT COUNT(*) FROM sAccessBatchQueue WITH (NOLOCK) WHERE BatchQueueTypeId = @BatchQueueTypeId AND TeamId = @TeamId) = 0
		BEGIN
			INSERT INTO sAccessBatchQueue (BatchQueueTypeId, TeamId, CUser, CDate, MUser, MDate)
			SELECT BatchQueueTypeId, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
			FROM #TempUserAccess WHERE Id = @I
		END

		SET @I = @I + 1
	END

	SELECT * FROM #tempUserAccess
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '144', GetDate())
GO
