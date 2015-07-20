
/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessQuickBRFolderCheck_INSERT]    Script Date: 06/07/2010 17:08:40 ******/

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessQuickBRFolderCheck_INSERT]
(
@GroupId uniqueidentifier,
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
		GroupId uniqueidentifier
	) 
	END

	BEGIN
	
	INSERT INTO #TempUserAccess(QuickBRTypeID) SELECT QuickBRTypeID FROM pQuickBatchReplaceType WITH (NOLOCK)
	
	
	SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)
	
	SET @I = 1

	WHILE @I <= @Row_Count 
		BEGIN

			SELECT @QuickBRTypeID = QuickBRTypeID FROM #TempUserAccess WHERE ID = @I
			IF (SELECT COUNT(*) FROM sAccessGroupQuickBatchReplaceFolder WITH (NOLOCK) WHERE QuickBRTypeID = @QuickBRTypeID AND GroupID  = @GroupID) = 0
			BEGIN
				INSERT INTO sAccessGroupQuickBatchReplaceFolder 
					(QuickBRTypeID, GroupID,   CUser, CDate, MUser, MDate)
				SELECT QuickBRTypeID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
				FROM  #TempUserAccess WHERE Id = @I
			END
				
			SET @I = @I + 1
		END

		SELECT * FROM #tempUserAccess

	END
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '128', GetDate())
GO




