IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessSourcingFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessSourcingFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_User_AccessSourcingFolder_SELECT]
(@teamId uniqueidentifier)
AS 


SELECT SourcingTypeId, 'Sourcing Folder' AS SourcingFolder,  AccessSourcingID,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  TeamId,  CUser,  CDate, MUser,  MDate  
FROM  sAccessSourcingFolder WITH (NOLOCK) 
WHERE TeamId = @teamId


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06261', GetDate())
GO
