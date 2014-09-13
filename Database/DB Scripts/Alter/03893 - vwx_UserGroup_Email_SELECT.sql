IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_UserGroup_Email_SELECT]'))
DROP VIEW [dbo].[vwx_UserGroup_Email_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_UserGroup_Email_SELECT]
AS
SELECT     CAST(ISNULL(dbo.Users.FirstName, '') AS NVARCHAR(100)) + ' ' + CAST(ISNULL(dbo.Users.LastName, '') AS NVARCHAR(100)) AS FullName, dbo.Users.Title, 
                      dbo.Users.TeamID, dbo.uUserGroup.GroupID, dbo.Users.Email
FROM         dbo.Users INNER JOIN
                      dbo.uUserGroup ON dbo.Users.TeamID = dbo.uUserGroup.TeamID
WHERE dbo.Users.Email IS NOT NULL AND dbo.Users.Email <> ''

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03893', GetDate())
GO
