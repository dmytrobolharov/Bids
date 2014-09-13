IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessQuickBRFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessQuickBRFolder_SELECT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessQuickBRFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessQuickBRFolderCheck_INSERT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessQuickBRFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessQuickBRFolder_SELECT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopAccessQuickBRFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_DesktopAccessQuickBRFolderCheck_INSERT]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '199', GetDate())
GO
