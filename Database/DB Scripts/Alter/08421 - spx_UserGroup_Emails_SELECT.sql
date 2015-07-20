IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserGroup_Emails_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserGroup_Emails_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_UserGroup_Emails_SELECT]
	@GroupID UNIQUEIDENTIFIER
AS

SELECT DISTINCT Users.Email
FROM uGroup
INNER JOIN uUserGroup ON uGroup.GroupID = uUserGroup.GroupID
INNER JOIN Users ON uUserGroup.TeamID = Users.TeamID
WHERE uUserGroup.GroupID = @GroupID 
	AND Users.Email <> '' AND Users.Email IS NOT NULL
 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08421', GetDate())
GO
