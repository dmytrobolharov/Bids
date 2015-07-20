IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorType_AllByPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorType_AllByPermissions_SELECT]
GO

CREATE PROCEDURE  [dbo].[spx_ColorType_AllByPermissions_SELECT]
(
@TeamID UNIQUEIDENTIFIER 
)
AS
 
BEGIN
	SELECT * FROM pColorType
	WHERE ColorTypeID IN (
		SELECT ColorTypeID FROM sAccessColorFolder WHERE AccessRoleId <> 0 AND (TeamId = @TeamID)
	) 
	ORDER BY Sort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07517', GetDate())
GO
