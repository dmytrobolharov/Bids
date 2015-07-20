/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessFolder_SELECT]    Script Date: 05/22/2013 11:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessFolder_SELECT]    Script Date: 05/22/2013 11:53:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessFolder_SELECT](
	@GroupID uniqueidentifier
)
AS 


	SELECT a.DeskGroupAccessId,  a.GroupID, a.DeskAccessId, 
		b.DeskFolderUrl , b.DeskGroupFolderUrl ,  b.DeskFolderId,  b.DeskFolderName,  b.DeskSubFolder
	FROM  cDeskGroupFolderAccess  a WITH (NOLOCK)  INNER JOIN  cDesktopFolder  b WITH (NOLOCK) ON  a.DeskFolderId =  b.DeskFolderId
	WHERE a.GroupID = @GroupID AND b.DeskGroupFolderUrl IS NOT NULL
	ORDER BY b.DeskFolderId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05735', GetDate())
GO
