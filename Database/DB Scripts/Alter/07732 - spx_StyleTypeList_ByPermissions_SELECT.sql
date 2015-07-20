IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTypeList_ByPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTypeList_ByPermissions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleTypeList_ByPermissions_SELECT] (
	@TeamId UNIQUEIDENTIFIER
	) AS 
BEGIN

	SELECT StyleTypeID, StyleTypeDescription FROM pStyleType
	WHERE StyleTypeID IN (  SELECT StyleTypeID FROM sAccessStyleFolder WHERE TeamId = @TeamId AND (AccessRoleId = 3 OR AccessCreate = 1 ) )
	ORDER BY StyleTypeOrder

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07732', GetDate())
GO