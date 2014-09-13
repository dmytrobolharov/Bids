

/****** Object:  StoredProcedure [dbo].[spx_User_AccessPartnerFolder_SELECT]    Script Date: 03/05/2013 17:15:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessPartnerFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessPartnerFolder_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_User_AccessPartnerFolder_SELECT]    Script Date: 03/05/2013 17:15:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_User_AccessPartnerFolder_SELECT]
(@teamId uniqueidentifier)
AS 


SELECT 1 AS PartnerTypeId, 'Partner Folder' AS PartnerFolder,  AccessPartnerID,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  TeamId,  CUser,  CDate, MUser,  MDate  
FROM  sAccessPartnerFolder WITH (NOLOCK) 
WHERE TeamId = @teamId
GO






INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05247', GetDate())
GO
