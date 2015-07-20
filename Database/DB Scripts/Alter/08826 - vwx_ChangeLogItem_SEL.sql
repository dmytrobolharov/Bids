IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItem_SEL]'))
DROP VIEW [dbo].[vwx_ChangeLogItem_SEL]
GO

CREATE VIEW [dbo].[vwx_ChangeLogItem_SEL]
AS
SELECT     b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate, a.ChangeLogItemID, a.ChangeTransID, a.ChangeLogID, a.ChangeFieldName, 
                      a.ChangeFieldAlias, a.ChangeBeforeValue, a.ChangeAfterValue, a.ChangeBeforeText, a.ChangeAfterText, a.ChangeSort, a.Custom_SMat_Name, a.Custom_SMat_Type, 
                      a.Custom_SMat_No, c.ChangeTransTablePKID, ISNULL(b.ChangeTransTypeID, c.ChangeTransTypeID) AS ChangeTransTypeID,
                      ctt.ActionType, c.ChangeSessionID, 
                      c.ChangeSessionNo, c.ChangeTransNo, 
                      CASE WHEN b.ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00024' THEN '10000000-0000-0000-0000-000000000010' ELSE e.WorkflowID END AS WorkflowID,
                      CASE WHEN b.ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00024' THEN 'Costing' ELSE e.Workflow END AS Workflow, b.ChangeUserID
FROM dbo.pChangeLogItem AS a WITH (NOLOCK)
	INNER JOIN dbo.pChangeLog AS b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID
	INNER JOIN dbo.pChangeTransaction AS c WITH (NOLOCK) ON c.ChangeTransID = a.ChangeTransID
	LEFT JOIN dbo.pStyleWorkflowToChangeTable AS d WITH (NOLOCK) ON d.ChangeTableID = b.ChangeTableID
	LEFT JOIN dbo.pWorkflow AS e ON e.WorkflowID = d.WorkflowID
	INNER JOIN vwx_ChangeTransType_SEL ctt ON ISNULL(b.ChangeTransTypeID, c.ChangeTransTypeID) = ctt.ChangeTransTypeID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08826', GetDate())
GO
