
/****** Object:  StoredProcedure [dbo].[spx_User_DesktopAccessQuickBRFolderCheck_INSERT]    Script Date: 06/07/2010 17:13:59 ******/


CREATE PROCEDURE [dbo].[spx_User_DesktopAccessQuickBRFolderCheck_INSERT]
(
@TeamId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @QuickBRTypeID int
DECLARE @DeskAccessId int
DECLARE @DeskTableName varchar(100)
DECLARE @DeskTableKey varchar(50)


	BEGIN
	CREATE TABLE #TempUserAccess (
		Id int IDENTITY (1, 1) NOT NULL , 
		QuickBRTypeID int NOT NULL,
		TeamId uniqueidentifier
	) 
	END

	BEGIN
	
	INSERT INTO #TempUserAccess(QuickBRTypeID) SELECT QuickBRTypeID FROM pQuickBatchReplaceType WITH (NOLOCK)
	
	
	SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)
	
	SET @I = 1

	WHILE @I <= @Row_Count 
		BEGIN

			SELECT @QuickBRTypeID = QuickBRTypeID FROM #TempUserAccess WHERE ID = @I
			IF (SELECT COUNT(*) FROM sAccessQuickBatchReplaceFolder WITH (NOLOCK) WHERE QuickBRTypeID = @QuickBRTypeID AND TeamId = @TeamId) = 0
			BEGIN
				INSERT INTO sAccessQuickBatchReplaceFolder
					(QuickBRTypeID, TeamId, CUser, CDate, MUser, MDate)
				SELECT QuickBRTypeID, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
				FROM  #TempUserAccess WHERE Id = @I
			END
				
			SET @I = @I + 1
		END

		SELECT * FROM #tempUserAccess

	END
	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '132', GetDate())
GO



