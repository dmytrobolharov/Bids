/****** Object:  StoredProcedure [dbo].[spx_Group_AccessLineFolder_SELECT]    Script Date: 02/26/2013 17:43:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessLineFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessLineFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_AccessLineFolder_SELECT]    Script Date: 02/26/2013 17:43:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessLineFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 


SELECT LineTypeID, LineListType,  AccessLineId,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  GroupID, 
    sAccessGroupLineFolder.CUser, sAccessGroupLineFolder.CDate, sAccessGroupLineFolder.MUser, sAccessGroupLineFolder.MDate  
FROM  sAccessGroupLineFolder INNER JOIN pLineListType
ON sAccessGroupLineFolder.LineTypeId = pLineListType.LineListTypeID
WHERE GroupID = @GroupID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05173', GetDate())
GO
