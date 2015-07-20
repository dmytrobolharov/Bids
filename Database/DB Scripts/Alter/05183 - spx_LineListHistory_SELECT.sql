/****** Object:  StoredProcedure [dbo].[spx_LineListHistory_SELECT]    Script Date: 02/27/2013 18:04:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineListHistory_SELECT]    Script Date: 02/27/2013 18:04:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LineListHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.LineFolderID,b.LineFolderDescription,c.LineFolderTypeDescription FROM pLineListHistory a
				INNER JOIN pLineFolder b on a.LineFolderID = b.LineFolderID
				LEFT OUTER JOIN pLineFolderType c ON b.LineFolderTypeID = c.LineFolderTypeID
				INNER JOIN sAccessLineFolder d ON d.LineTypeID = b.LineListTypeID AND d.TeamId = a.TeamID
	WHERE a.TeamID = @TeamId
			AND (d.AccessView = 1 OR d.AccessRoleId = 3)
	ORDER BY a.CDate DESC
	


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05183', GetDate())
GO
