/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]    Script Date: 06/17/2014 17:54:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08036', GetDate())
GO
