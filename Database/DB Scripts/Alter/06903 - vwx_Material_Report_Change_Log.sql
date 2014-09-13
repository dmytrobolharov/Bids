IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Material_Report_Change_Log]'))
DROP VIEW [dbo].[vwx_Material_Report_Change_Log]
GO

CREATE VIEW [dbo].[vwx_Material_Report_Change_Log]

AS
	SELECT
		m.MaterialID
		, m.MaterialNo
		, m.MaterialName
		, m.MaterialType
		, ct.ComponentDescription
		, cli.ChangeFieldAlias
		, cli.ActionType
		, cli.ChangeUserID
		, cli.ChangeUserName
		, cli.ChangeDate
		, cli.ChangeBeforeText
		, cli.ChangeAfterText
		, ms.Custom AS Status
		, dbo.fnx_GetStreamingImagePathChangeLogReport(m.MaterialImageID, m.MaterialImageVersion, N'200') AS Image
	FROM vwx_ChangeLogItem_SEL cli
		INNER JOIN pMaterial m ON cli.ChangeTablePKID = m.MaterialID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
		LEFT JOIN xCustom8 ms ON m.S = ms.CustomKey
	WHERE ChangeTableID = '00000010-C1CC-DF11-AF06-005056C00008'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06903', GetDate())
GO
