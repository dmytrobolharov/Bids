/****** Object:  StoredProcedure [dbo].[spx_FillTablesNewPermissions]    Script Date: 05/19/2014 19:48:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_FillTablesNewPermissions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_FillTablesNewPermissions]
GO

/****** Object:  StoredProcedure [dbo].[spx_FillTablesNewPermissions]    Script Date: 05/19/2014 19:48:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_FillTablesNewPermissions]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF NOT EXISTS(SELECT * FROM sPermissionFolderType)
BEGIN
INSERT INTO sPermissionFolderType (PermissionFolderTypeId, PermissionFolderTypeName, Active) SELECT df.DeskFolderId,df.DeskFolderName,1 FROM cDesktopFolder AS df
END

-- Generating PermissionFolders for each group and each folder type in the system
INSERT INTO sPermissionFolder (PermissionFolderTypeId, GroupID, CDate,CUser,MDate,MUser, PermissionFolderNotLocked) 
SELECT folderType.PermissionFolderTypeId, gr.GroupID, ISNULL(dgfa.CDate, CURRENT_TIMESTAMP), ISNULL(dgfa.CUser, 'Administrator'), 
ISNULL(dgfa.MDate, CURRENT_TIMESTAMP), ISNULL(dgfa.MUser, 'Administrator'), ISNULL(dgfa.DeskAccessId, 0)
FROM sPermissionFolderType AS folderType
CROSS JOIN uGroup AS gr
LEFT JOIN cDeskGroupFolderAccess AS dgfa ON gr.GroupID = dgfa.GroupID AND dgfa.DeskFolderId = folderType.PermissionFolderTypeId
WHERE NOT EXISTS (SELECT * FROM sPermissionFolder AS f WHERE f.GroupId = gr.GroupID AND f.PermissionFolderTypeId = folderType.PermissionFolderTypeId)


IF NOT EXISTS(SELECT * FROM sPermissionRole)
BEGIN
INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(3,NULL,NULL)
INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(2,NULL,NULL)
INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(1,NULL,NULL)
INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(0,NULL,NULL)
END

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07680', GetDate())
GO
