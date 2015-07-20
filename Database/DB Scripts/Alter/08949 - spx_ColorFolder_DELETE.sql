IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_ColorFolder_DELETE]
(@ColorFolderId  uniqueidentifier
)
AS 

IF NOT EXISTS (SELECT * FROM pPlanningColor WHERE ColorFolderID = @ColorFolderId) -- ColorFolderID is a foreign key of pPlanningColor table
BEGIN

	DELETE FROM pColorFolder WHERE ColorFolderID  = @ColorFolderId

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08949', GetDate())
GO
