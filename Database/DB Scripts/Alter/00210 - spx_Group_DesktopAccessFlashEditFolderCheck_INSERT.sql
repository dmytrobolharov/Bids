CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessFlashEditFolderCheck_INSERT]
(
@GroupId uniqueidentifier,
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
		FlashEditFolderItemID uniqueidentifier NOT NULL,
		GroupId uniqueidentifier
	) 
	END

	BEGIN
	
	INSERT INTO #TempUserAccess(FlashEditFolderItemID) SELECT FlashEditFolderItemID FROM pFlashEditFolderItem WITH (NOLOCK)
	
	
	SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)
	
	SET @I = 1

	WHILE @I <= @Row_Count 
		BEGIN

			SELECT @FlashEditFolderItemID = FlashEditFolderItemID FROM #TempUserAccess WHERE ID = @I
			IF (SELECT COUNT(*) FROM sAccessGroupFlashEditFolder WITH (NOLOCK) WHERE FlashEditFolderItemID = @FlashEditFolderItemID AND GroupID  = @GroupID) = 0
			BEGIN
				INSERT INTO sAccessGroupFlashEditFolder 
					(FlashEditFolderItemID, GroupID,   CUser, CDate, MUser, MDate)
				SELECT FlashEditFolderItemID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
				FROM  #TempUserAccess WHERE Id = @I
			END
				
			SET @I = @I + 1
		END

		SELECT * FROM #tempUserAccess

	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '210', GetDate())
GO	