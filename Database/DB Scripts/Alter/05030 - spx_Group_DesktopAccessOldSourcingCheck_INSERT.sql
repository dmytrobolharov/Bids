/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessOldSourcingCheck_INSERT]    Script Date: 02/11/2013 15:50:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessOldSourcingCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessOldSourcingCheck_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessOldSourcingCheck_INSERT]    Script Date: 02/11/2013 15:50:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessOldSourcingCheck_INSERT] (
@GroupID uniqueidentifier, 
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @StyleTypeID int 
DECLARE @DeskAccessId int
DECLARE @DeskTableName varchar(100)
DECLARE @DeskTableKey varchar(50)


	BEGIN
	CREATE TABLE #TempGroupAccess (
		Id int IDENTITY (1, 1) NOT NULL , 
		StyleTypeID int NOT NULL,
		GroupID uniqueidentifier 
	) 
	END

	BEGIN
	
	INSERT INTO #TempGroupAccess( StyleTypeID) SELECT StyleTypeID FROM pStyleType
	
	
	SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)
	
	SET @I = 1

	WHILE @I <= @Row_Count 
		BEGIN

			SELECT @StyleTypeID = StyleTypeID FROM #TempGroupAccess WHERE ID = @I
			IF (SELECT COUNT(*) FROM sAccessGroupOldSourcing WITH (NOLOCK)  WHERE StyleTypeId = @StyleTypeID  AND GroupID = @GroupID ) = 0
			BEGIN
				INSERT INTO sAccessGroupOldSourcing
					( StyleTypeId, GroupID, CUser, CDate, MUser, MDate)
				SELECT StyleTypeId, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
				FROM  #TempGroupAccess WHERE Id = @I
			END
				
			SET @I = @I + 1
		END

		SELECT * FROM #tempGroupAccess

	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05030', GetDate())
GO
