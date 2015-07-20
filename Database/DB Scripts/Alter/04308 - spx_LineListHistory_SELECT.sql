IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListHistory_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineListHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.LineFolderID,b.LineFolderDescription,c.LineFolderTypeDescription FROM pLineListHistory a
				INNER JOIN pLineFolder b on a.LineFolderID = b.LineFolderID
				LEFT OUTER JOIN pLineFolderType c ON b.LineFolderTypeID = c.LineFolderTypeID
	WHERE a.TeamID = @TeamId
	ORDER BY a.CDate DESC
	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04308', GetDate())
GO
