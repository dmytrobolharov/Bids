IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_DashMaterial_List_SELECT]'))
DROP VIEW [dbo].[vwx_DashMaterial_List_SELECT]
GO

CREATE VIEW [dbo].[vwx_DashMaterial_List_SELECT]
AS
	SELECT
		m.MaterialNo
		, m.MaterialName
		, ms.Custom AS Status
		, m.MaterialType
		, msy.SeasonYearID
		, 'javascript: void(window.open(''' + AppSettingValue + '/Material/Material_Frame.aspx?MTID=' + CAST(m.MaterialID AS NVARCHAR(50))+ '''))' AS MaterialLink
	FROM pMaterial m
		INNER JOIN pMaterialSeasonYear msy ON m.MaterialID = msy.MaterialID
		LEFT JOIN xCustom8 ms ON m.S = ms.CustomKey
		, sAppSetting
	WHERE AppSettingKey = 'plmOnApplicationServerUrl'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08946', GetDate())
GO
