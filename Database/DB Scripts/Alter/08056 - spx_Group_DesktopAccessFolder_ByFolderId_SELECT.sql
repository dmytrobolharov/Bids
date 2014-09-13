/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessFolder_ByFolderId_SELECT]    Script Date: 06/23/2014 16:51:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessFolder_ByFolderId_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessFolder_ByFolderId_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessFolder_ByFolderId_SELECT]    Script Date: 06/23/2014 16:51:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessFolder_ByFolderId_SELECT](
	@GroupID uniqueidentifier,
	@FolderId INT
)
AS 


	SELECT a.DeskGroupAccessId,  a.GroupID, a.DeskAccessId, 
		b.DeskFolderUrl , b.DeskGroupFolderUrl ,  b.DeskFolderId,  b.DeskFolderName,  b.DeskSubFolder
	FROM  cDeskGroupFolderAccess  a WITH (NOLOCK)  INNER JOIN  cDesktopFolder  b WITH (NOLOCK) ON  a.DeskFolderId =  b.DeskFolderId
	WHERE a.GroupID = @GroupID AND b.DeskGroupFolderUrl IS NOT NULL AND b.DeskFolderId = @FolderId
	ORDER BY b.DeskFolderId





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08056', GetDate())
GO
