DECLARE @AdminGroupID UNIQUEIDENTIFIER = 'CA39465E-0CBE-4D73-AFE2-9601660B6E0D'
DECLARE @DefaultLineTypeID UNIQUEIDENTIFIER
DECLARE @CurrentTime DATETIME = CURRENT_TIMESTAMP

SELECT @DefaultLineTypeID = LineListTypeID FROM pLineListType
WHERE LineListCode='Default' AND LineListType='Line Plan Default'

IF @DefaultLineTypeID IS NOT NULL
BEGIN
	IF NOT EXISTS(SELECT * FROM sAccessGroupLineFolder WHERE GroupID = @AdminGroupID AND LineTypeId = @DefaultLineTypeID)
	BEGIN
		INSERT INTO sAccessGroupLineFolder(LineTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID, CDate, MDate)
		VALUES (@DefaultLineTypeID, 3, 0, 0, 0, 0, 0, @AdminGroupID, @CurrentTime, @CurrentTime)
		
	END

	EXEC spx_Group_AccessFolderUserPermissions_UPDATE @GroupID=@AdminGroupID, @FullName='System', @CDate=@CurrentTime, @FolderName='LINE'
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05190', GetDate())

GO
