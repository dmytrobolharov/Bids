/****** Object:  StoredProcedure [dbo].[spx_FillTablesNewPermissions]    Script Date: 05/06/2014 12:06:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_FillTablesNewPermissions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_FillTablesNewPermissions]
GO

/****** Object:  StoredProcedure [dbo].[spx_FillTablesNewPermissions]    Script Date: 05/06/2014 12:06:04 ******/
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

IF NOT EXISTS(SELECT * FROM sPermissionFolder)
BEGIN
INSERT INTO sPermissionFolder(PermissionFolderTypeId, GroupID, CDate,CUser,MDate,MUser, PermissionFolderNotLocked) SELECT folderType.PermissionFolderTypeId,dgfa.GroupID,dgfa.CDate, dgfa.CUser,dgfa.MDate,dgfa.MUser, dgfa.DeskAccessId from cDeskGroupFolderAccess AS dgfa INNER JOIN sPermissionFolderType AS folderType ON dgfa.DeskFolderId = folderType.PermissionFolderTypeId
INNER JOIN uGroup AS gr ON gr.GroupID = dgfa.GroupID
END

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
VALUES ('DB_Version', '0.5.0000', '07672', GetDate())
GO
