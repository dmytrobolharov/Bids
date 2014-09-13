/****** Object:  StoredProcedure [dbo].[spx_LineFolder_DELETE]    Script Date: 03/18/2013 10:54:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_DELETE]    Script Date: 03/18/2013 10:54:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_DELETE]
(@LineFolderId uniqueidentifier)
AS 


DELETE FROM pLineFolder WHERE (LineFolderID = @LineFolderId)
DELETE FROM pLineFolderItem WHERE (LineFolderID = @LineFolderId)
DELETE FROM pLineFolderItemColor WHERE (LineFolderID = @LineFolderId)
DELETE FROM pLineFolderItemMessage WHERE (LineFolderID = @LineFolderId)
DELETE FROM pLineFolderStyleCategory WHERE LineFolderID = @LineFolderId
DELETE FROM pLineFolderStyleType WHERE LineFolderID = @LineFolderId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05329', GetDate())
GO
