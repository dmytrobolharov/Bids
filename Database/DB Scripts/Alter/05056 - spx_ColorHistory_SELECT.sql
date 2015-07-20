/****** Object:  StoredProcedure [dbo].[spx_ColorHistory_SELECT]    Script Date: 02/18/2013 14:45:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorHistory_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_ColorHistory_SELECT]    Script Date: 02/18/2013 14:45:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_ColorHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.ColorFolderID,b.ColorFolderDescription,b.ColorTypeID,c.ColorTypeDescription FROM pColorHistory a WITH (NOLOCK)
				INNER JOIN pColorFolder b WITH (NOLOCK) ON a.ColorFolderID = b.ColorFolderID
				LEFT OUTER JOIN pColorType c ON b.ColorTypeID = c.ColorTypeID
	WHERE a.TeamID = @TeamId and b.ColorTypeID IN  ( SELECT ColorTypeID FROM sAccessColorFolder WHERE (AccessRoleId = 3 OR (AccessRoleId > 0 AND AccessView = 1)) AND TeamId = @TeamID)
	ORDER BY a.CDate DESC


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05056', GetDate())
GO


