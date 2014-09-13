IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessCalendarFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessCalendarFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessCalendarFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 
SELECT 1 AS CalendarTypeId, 'Calendar Folder' AS CalendarFolder, AccessCalendarID,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  GroupID, 
    CUser, CDate, MUser, MDate  
FROM  sAccessGroupCalendarFolder 
WHERE GroupID = @GroupID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06453', GetDate())
GO
