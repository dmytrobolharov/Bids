IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItem_SEL]'))
DROP VIEW [dbo].[vwx_ChangeLogItem_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_ChangeLogItem_SEL]
AS
SELECT     b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate, a.ChangeLogItemID, a.ChangeTransID, a.ChangeLogID, a.ChangeFieldName, 
                      a.ChangeFieldAlias, a.ChangeBeforeValue, a.ChangeAfterValue, a.ChangeBeforeText, a.ChangeAfterText, a.ChangeSort, a.Custom_SMat_Name, a.Custom_SMat_Type, 
                      a.Custom_SMat_No, c.ChangeTransTablePKID, 
                      CASE c.ChangeTransTypeID WHEN 0 THEN 'Update' WHEN 1 THEN 'Add' WHEN 2 THEN 'Remove' WHEN 3 THEN 'Copy' WHEN 4 THEN 'Replace' END AS ActionType
FROM         dbo.pChangeLogItem AS a WITH (NOLOCK) INNER JOIN
                      dbo.pChangeLog AS b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID INNER JOIN
                      dbo.pChangeTransaction AS c WITH (NOLOCK) ON c.ChangeTransID = a.ChangeTransID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02217'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02217', GetDate())
END	
GO