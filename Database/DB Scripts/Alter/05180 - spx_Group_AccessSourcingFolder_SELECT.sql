/****** Object:  StoredProcedure [dbo].[spx_Group_AccessSourcingFolder_SELECT]    Script Date: 02/27/2013 17:18:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessSourcingFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessSourcingFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_AccessSourcingFolder_SELECT]    Script Date: 02/27/2013 17:18:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Group_AccessSourcingFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 


SELECT st.SourcingTypeId as sourcingtypeid, st.SourcingTypeName AS SourcingFolder,  AccessSourcingID,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  GroupID, sAccessGroupSourcingFolder.CUser,  sAccessGroupSourcingFolder.CDate, sAccessGroupSourcingFolder.MUser,  sAccessGroupSourcingFolder.MDate  
FROM  sAccessGroupSourcingFolder WITH (NOLOCK) right join
pSourcingType st on st.SourcingTypeId = sAccessGroupSourcingFolder.SourcingTypeId
WHERE GroupID = @GroupID and Active = 1


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05180', GetDate())
GO
