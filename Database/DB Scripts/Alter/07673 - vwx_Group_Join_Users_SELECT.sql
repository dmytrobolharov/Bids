/****** Object:  View [dbo].[vwx_Group_Join_Users_SELECT]    Script Date: 05/19/2014 13:09:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Group_Join_Users_SELECT]'))
DROP VIEW [dbo].[vwx_Group_Join_Users_SELECT]
GO

/****** Object:  View [dbo].[vwx_Group_Join_Users_SELECT]    Script Date: 05/19/2014 13:09:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_Group_Join_Users_SELECT]
AS
SELECT u.TeamID,u.FirstName,u.LastName, u.CUser,u.CDate,u.MUser,u.MDate,g.GroupID,g.GroupName,g.Active,g.GroupDescription FROM Users as u 
INNER JOIN uUserGroup as ug ON u.TeamID =  ug.TeamID
INNER JOIN uGroup as g ON g.GroupID = ug.GroupID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07673', GetDate())
GO
