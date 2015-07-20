IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Permission_Summary_Main_SELECT]'))
DROP VIEW [dbo].[vwx_Permission_Summary_Main_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Permission_Summary_Main_SELECT]
AS
SELECT     TOP (100) PERCENT g.GroupID, u.TeamID, g.GroupName, ISNULL(u.FirstName + ' ','') + ISNULL(u.MiddleName + ' ', '') + ISNULL(u.LastName,'') AS UFullName
FROM         dbo.uGroup AS g INNER JOIN
                      dbo.uUserGroup AS ug ON g.GroupID = ug.GroupID INNER JOIN
                      dbo.Users AS u ON ug.TeamID = u.TeamID
WHERE     (g.Active = 1) AND (u.Active = 1)
ORDER BY g.GroupName, UFullName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04722', GetDate())
GO
