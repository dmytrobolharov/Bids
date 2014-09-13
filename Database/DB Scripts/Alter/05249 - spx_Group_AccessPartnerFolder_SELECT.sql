
/****** Object:  StoredProcedure [dbo].[spx_Group_AccessPartnerFolder_SELECT]    Script Date: 03/05/2013 17:17:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessPartnerFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessPartnerFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_AccessPartnerFolder_SELECT]    Script Date: 03/05/2013 17:17:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[spx_Group_AccessPartnerFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 
SELECT 1 AS PartnerTypeId, 'Partner Folder' AS PartnerFolder, AccessPartnerID,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  GroupID, 
    CUser, CDate, MUser, MDate  
FROM  sAccessGroupPartnerFolder 
WHERE GroupID = @GroupID

GO









INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05249', GetDate())
GO
