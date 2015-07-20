IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeTransType_SEL]'))
DROP VIEW [dbo].[vwx_ChangeTransType_SEL]
GO

CREATE VIEW [dbo].[vwx_ChangeTransType_SEL]
AS
	SELECT 0 AS ChangeTransTypeID, 'Update' AS ActionType
	UNION
	SELECT 1 AS ChangeTransTypeID, 'Add' AS ActionType
	UNION
	SELECT 2 AS ChangeTransTypeID, 'Remove' AS ActionType
	UNION
	SELECT 3 AS ChangeTransTypeID, 'Copy' AS ActionType
	UNION
	SELECT 4 AS ChangeTransTypeID, 'Replace' AS ActionType

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08825', GetDate())
GO
