IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_UserGroupList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_UserGroupList_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_UserGroupList_SELECT]

AS

SELECT GroupID, GroupName, 0 AS Sort FROM uGroup
WHERE Active = 1
UNION
SELECT '00000000-0000-0000-0000-000000000000', '--------------', 1
UNION
SELECT TeamID AS GroupID, FirstName + ' ' + LastName AS GroupName, 2 AS Sort FROM Users
WHERE Active = 1
ORDER BY Sort, GroupName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05215', GetDate())
GO
