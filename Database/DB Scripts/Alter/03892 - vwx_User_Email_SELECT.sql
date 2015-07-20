IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_User_Email_SELECT]'))
DROP VIEW [dbo].[vwx_User_Email_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_User_Email_SELECT]
AS
SELECT     CAST(ISNULL(FirstName, '') AS NVARCHAR(100)) + ' ' + CAST(ISNULL(LastName, '') AS NVARCHAR(100)) AS FullName, Title, TeamID, Email
FROM         dbo.Users
WHERE     (Email IS NOT NULL) AND (Email <> '')

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03892', GetDate())
GO
