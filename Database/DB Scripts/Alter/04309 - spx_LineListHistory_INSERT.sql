IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListHistory_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LineListHistory_INSERT]
(@LineFolderId uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM pLineListHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND LineFolderId = @LineFolderId) = 0
	BEGIN
		INSERT INTO pLineListHistory  (LineFolderId, TeamID, CDate) VALUES ( @LineFolderId, @TeamID, @CreatedDate)
	END
Else
	BEGIN
		UPDATE pLineListHistory SET  CDate = @CreatedDate WHERE LineFolderId = @LineFolderId AND TeamID = @TeamID
	END

BEGIN
	DELETE FROM pLineListHistory WHERE TeamID = @TeamID AND  LineFolderId NOT IN (SELECT TOP 9 LineFolderId From pLineListHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04309', GetDate())
GO

