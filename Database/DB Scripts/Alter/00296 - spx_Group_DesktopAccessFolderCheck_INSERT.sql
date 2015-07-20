IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessFolderCheck_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessFolderCheck_INSERT](
@GroupID uniqueidentifier ,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

	DECLARE @I as int
	DECLARE @Row_Count int
	DECLARE @DeskFolderId int 
	DECLARE @DeskAccessId int

	SET @DeskAccessId = 0
	SET @I = 1


	CREATE TABLE #TempGroupAccess (
		Id int IDENTITY (1, 1) NOT NULL , 
		DeskFolderId int NOT NULL 
	) 


	INSERT INTO #TempGroupAccess (DeskFolderId)
	SELECT DeskFolderId FROM cDesktopFolder WITH (NOLOCK) 

	SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)

	WHILE @I <= @Row_Count 
	BEGIN

		SELECT @DeskFolderId = DeskFolderId FROM #TempGroupAccess WHERE ID = @I

		IF (SELECT COUNT(*) FROM cDeskGroupFolderAccess WITH (NOLOCK) WHERE DeskFolderId = @DeskFolderId AND GroupID = @GroupID) = 0
		BEGIN
			INSERT INTO cDeskGroupFolderAccess
				(DeskFolderId, DeskAccessId, GroupID, CUser, CDate, MUser, MDate)
			SELECT DeskFolderId, @DeskAccessId, @GroupID,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
			FROM  cDesktopFolder WITH (NOLOCK) WHERE DeskFolderId = @DeskFolderId
		END

		SET @I = @I + 1
	END









GO