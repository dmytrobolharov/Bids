IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_Removable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_Removable_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_Removable_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @lfiCnt INT
	DECLARE @clfCnt INT
	DECLARE @lfhCnt INT
		
	SELECT @lfiCnt=COUNT(LineFolderID) FROM pLineFolderItem WHERE LineFolderID = @LineFolderID
	SELECT @clfCnt=COUNT(LineFolderID) FROM pCalendarLineFolder WHERE LineFolderID = @LineFolderID
	SELECT @lfhCnt=COUNT(LineFolderID) FROM pLineFolderHistorical WHERE LineFolderID = @LineFolderID

	IF @lfiCnt+@clfCnt+@lfhCnt = 0 SELECT 1 AS isRemovable ELSE SELECT 0 AS isRemovable

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06111', GetDate())
GO
