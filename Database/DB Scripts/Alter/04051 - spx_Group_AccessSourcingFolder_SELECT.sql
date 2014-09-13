IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessSourcingFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessSourcingFolder_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessSourcingFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 


SELECT 1 AS SourcingTypeId, 'Sourcing Folder' AS SourcingFolder,  AccessSourcingID,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  GroupID, CUser,  CDate, MUser,  MDate  
FROM  sAccessGroupSourcingFolder WITH (NOLOCK) 
WHERE GroupID = @GroupID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04051', GetDate())

GO

