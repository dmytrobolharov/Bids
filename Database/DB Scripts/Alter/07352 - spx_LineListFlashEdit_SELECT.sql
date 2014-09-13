IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListFlashEdit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListFlashEdit_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineListFlashEdit_SELECT]
	@LineListFlashEditID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	SELECT * FROM pLineListFlashEdit
	WHERE LineListFlashEditActive = 1
		AND LineListFlashEditID = @LineListFlashEditID OR @LineListFlashEditID IS NULL
	ORDER BY LineListFlashEditSort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07352', GetDate())
GO
