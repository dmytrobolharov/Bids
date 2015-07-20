IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_DELETE]
	@LineFolderId UNIQUEIDENTIFIER
AS 
BEGIN

	DECLARE @lfiCnt INT
	DECLARE @clfCnt INT
	DECLARE @lfhCnt INT
		
	SELECT @lfiCnt=COUNT(LineFolderID) FROM pLineFolderItem WHERE LineFolderID = @LineFolderID
	SELECT @clfCnt=COUNT(LineFolderID) FROM pCalendarLineFolder WHERE LineFolderID = @LineFolderID
	SELECT @lfhCnt=COUNT(LineFolderID) FROM pLineFolderHistorical WHERE LineFolderID = @LineFolderID

	IF @lfiCnt+@clfCnt+@lfhCnt = 0
	BEGIN
		DELETE FROM pLineFolder WHERE (LineFolderID = @LineFolderId)
		DELETE FROM pLineFolderItem WHERE (LineFolderID = @LineFolderId)
		DELETE FROM pLineFolderItemColor WHERE (LineFolderID = @LineFolderId)
		DELETE FROM pLineFolderItemMessage WHERE (LineFolderID = @LineFolderId)
		DELETE FROM pLineFolderStyleCategory WHERE LineFolderID = @LineFolderId
		DELETE FROM pLineFolderStyleType WHERE LineFolderID = @LineFolderId
	END
	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06112', GetDate())
GO
