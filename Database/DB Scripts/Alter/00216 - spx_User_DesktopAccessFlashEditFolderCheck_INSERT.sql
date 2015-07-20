CREATE PROCEDURE [dbo].[spx_User_DesktopAccessFlashEditFolderCheck_INSERT]
(
@TeamId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @FlashEditFolderItemID uniqueidentifier
DECLARE @DeskAccessId int
DECLARE @DeskTableName varchar(100)
DECLARE @DeskTableKey varchar(50)


	BEGIN
	CREATE TABLE #TempUserAccess (
		Id int IDENTITY (1, 1) NOT NULL , 
		FlashEditFolderItemID uniqueidentifier,
		TeamId uniqueidentifier
	) 
	END

	BEGIN
	
	INSERT INTO #TempUserAccess(FlashEditFolderItemID) SELECT FlashEditFolderItemID FROM pFlashEditFolderItem WITH (NOLOCK)
	
	
	SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)
	
	SET @I = 1

	WHILE @I <= @Row_Count 
		BEGIN

			SELECT @FlashEditFolderItemID = FlashEditFolderItemID FROM #TempUserAccess WHERE ID = @I
			IF (SELECT COUNT(*) FROM sAccessFlashEditFolder WITH (NOLOCK) WHERE FlashEditFolderItemID = @FlashEditFolderItemID AND TeamId = @TeamId) = 0
			BEGIN
				INSERT INTO sAccessFlashEditFolder
					(FlashEditFolderItemID, TeamId, CUser, CDate, MUser, MDate)
				SELECT FlashEditFolderItemID, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
				FROM  #TempUserAccess WHERE Id = @I
			END
				
			SET @I = @I + 1
		END

		SELECT * FROM #tempUserAccess

	END
	

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '216', GetDate())
GO	