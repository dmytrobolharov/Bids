IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItem_StyleMaterial_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_ChangeLogItem_StyleMaterial_SEL]
GO

CREATE VIEW [dbo].[vwx_ChangeLogItem_StyleMaterial_SEL]
AS

SELECT 
	CASE ChangeTransTypeID
		WHEN 0 THEN 'Update'
		WHEN 1 THEN 'Add'
		WHEN 2 THEN 'Remove'

		WHEN 3 THEN 'Copy'
		WHEN 4 THEN 'Replace'
	END AS ActionType,


	CASE ChangeTransTypeID
		WHEN 1 THEN ''
		WHEN 2 THEN ''
		WHEN 3 THEN ''
		WHEN 4 THEN  ''
		ELSE a.ChangeFieldName
	END AS ChangeFieldName,

	CASE ChangeTransTypeID
		WHEN 1 THEN ''
		WHEN 2 THEN ''
		WHEN 3 THEN ''
		WHEN 4 THEN ''
		ELSE a.ChangeFieldAlias
	END AS ChangeFieldAlias,

	CASE ChangeTransTypeID
		WHEN 1 THEN ''
		WHEN 2 THEN ''
		WHEN 3 THEN ''
		ELSE a.ChangeBeforeValue
	END AS ChangeBeforeValue,

	CASE ChangeTransTypeID
		WHEN 1 THEN ''
		WHEN 2 THEN ''
		WHEN 3 THEN ''
		ELSE a.ChangeAfterValue
	END AS ChangeAfterValue,	

	CASE ChangeTransTypeID
		WHEN 1 THEN ''
		WHEN 2 THEN ''
		WHEN 3 THEN ''
		ELSE a.ChangeBeforeText
	END AS ChangeBeforeText,	

	CASE ChangeTransTypeID
		WHEN 1 THEN ''
		WHEN 2 THEN ''
		WHEN 3 THEN ''
		ELSE a.ChangeAfterText
	END AS ChangeAfterText,	

	b.ChangeTableID, e.ChangeTransTablePKID, e.ChangeSessionID, e.ChangeTransNo, e.ChangeSessionNo,
	b.ChangeUserID,  b.ChangeUserName, b.ChangeDate,
	a.ChangeLogItemID, a.ChangeTransID, a.ChangeLogID, 

	CASE ChangeTransTypeID
		WHEN 4 THEN ''
		ELSE a.Custom_SMat_Name 
	END AS MaterialName, 

	CASE ChangeTransTypeID
		WHEN 4 THEN ''
		ELSE a.Custom_SMat_No 
	END AS MaterialNo,

	CASE ChangeTransTypeID
		WHEN 4 THEN ''
		ELSE a.Custom_SMat_Type 
	END AS ComponentDescription, f.Styleno, f.Description as StyleName
FROM pChangeLogItem a WITH (NOLOCK)
	INNER JOIN dbo.pChangeLog b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID
	INNER JOIN dbo.pChangeTransaction  e WITH (NOLOCK) ON e.ChangeTransID = a.ChangeTransID 
	INNER JOIN dbo.pStyleHeader f WITH (NOLOCK) ON f.StyleID =  e.ChangeTransTablePKID
WHERE b.ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' 



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03716', GetDate())
GO
