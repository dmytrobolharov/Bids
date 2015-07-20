IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ApplicationConnectionSetting_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ApplicationConnectionSetting_SELECT]
GO
CREATE PROCEDURE [dbo].[spx_ApplicationConnectionSetting_SELECT]
    
AS
BEGIN
    SELECT ApplicationConnectionSettingID, ApplicationConnectionName
    FROM pApplicationConnectionSetting
    ORDER BY ApplicationConnectionSort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08678', GetDate())
GO

