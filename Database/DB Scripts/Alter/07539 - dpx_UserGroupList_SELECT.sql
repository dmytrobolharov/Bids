IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_UserGroupList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_UserGroupList_SELECT]
GO


CREATE PROCEDURE [dbo].[dpx_UserGroupList_SELECT]
	@TeamID UNIQUEIDENTIFIER = NULL
AS

SELECT GroupID, GroupName, 0 AS Sort FROM uGroup
WHERE Active = 1
AND (GroupID IN (SELECT GroupID FROM uUserGroup WHERE TeamID = @TeamID) OR (SELECT [Admin] FROM Users WHERE TeamID = @TeamID) = 1 OR @TeamID IS NULL)
UNION
SELECT '00000000-0000-0000-0000-000000000000', '--------------', 1
UNION
SELECT TeamID AS GroupID, ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') AS GroupName, 2 AS Sort FROM Users
WHERE Active = 1
AND ((SELECT [Admin] FROM Users WHERE TeamID = @TeamID) = 1) 
	OR TeamID IN (
		SELECT TeamID FROM uUserGroup WHERE GroupID IN 
			(SELECT GroupID FROM uGroup WHERE Active = 1 AND GroupID IN (SELECT GroupID FROM uUserGroup WHERE TeamID = @TeamID)
		)
	OR @TeamID IS NULL
	)
ORDER BY Sort, GroupName

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07539', GetDate())
GO
