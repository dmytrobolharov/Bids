IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserGroup_WithEmails_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserGroup_WithEmails_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_UserGroup_WithEmails_SELECT]
AS

SELECT uGroup.GroupID
	, uGroup.GroupName
FROM uGroup
INNER JOIN uUserGroup ON uGroup.GroupID = uUserGroup.GroupID
INNER JOIN Users ON uUserGroup.TeamID = Users.TeamID
WHERE (Users.Email <> '' AND Users.Active = 1 AND uGroup.Active = 1)
GROUP BY uGroup.GroupID
	, uGroup.GroupName
	, uGroup.Active
HAVING COUNT(Users.UserId) > 0


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08422', GetDate())
GO
