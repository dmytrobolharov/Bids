IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Report_Change_Log]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Report_Change_Log]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Style_Report_Change_Log]

AS
BEGIN
SELECT sh.styleno, sh.Description, sh.SizeClass, 
(CASE sh.StyleSet
	WHEN 1 THEN ISNULL(sh.Pc1,CAST(sh.StyleSet AS VARCHAR(1)) + 'st Set')
	WHEN 2 THEN ISNULL(sh.Pc2,CAST(sh.StyleSet AS VARCHAR(1)) + 'nd Set')
	WHEN 3 THEN ISNULL(sh.Pc3,CAST(sh.StyleSet AS VARCHAR(1)) + 'rd Set')
	WHEN 4 THEN ISNULL(sh.Pc4,CAST(sh.StyleSet AS VARCHAR(1)) + 'th Set')
END) as StyleSet, 
change.Workflow,change.ChangeUserName,Change.ChangeDate,change.ChangeBeforetext,change.ChangeAftertext, change.WorkStatus,change.ChangeUserID, change.StyleID,change.WorkflowID, change.WorkflowItemID
FROM (SELECT *, '' as WorkStatus, '' as WorkflowItemID, ChangeTablePKID as StyleID FROM vwx_ChangeLogItem_SEL 
			WHERE (
					ChangeTableID IN (
						'036F8B4C-C1CC-DF11-AF06-005056C00008', 
						'00000003-C1CC-DF11-AF06-005056C00008', 
						'DD12FAAE-7ACD-DF11-AF06-005056C00008', 
						'00000002-C1CC-DF11-AF06-005056C00008',
						'00000006-C1CC-DF11-AF06-005056C00008'
					) OR ChangeTableID IN (
						SELECT c.ChangeTableID FROM pChangeTable c 
						INNER JOIN pStyleWorkflowToChangeTable sc ON sc.ChangeTableID = c.ChangeTableID 
						WHERE ChangeTableFieldName = 'StyleID'
					)
				)
			UNION ALL
			-- style workflows linked on WorkFlowItemID
			SELECT cli.*,(SELECT WorkflowStatus FROM pWorkflowStatus WHERE pWorkflowStatus.WorkflowStatusID=wi.WorkStatus) as WorkStatus,  isnull(cast(wi.WorkFlowItemID as varchar(255)),'') as WorkflowItemID,  wi.StyleID as StyleID FROM vwx_ChangeLogItem_SEL cli
			INNER JOIN pChangeTable c ON cli.ChangeTableID = c.ChangeTableID
			INNER JOIN pStyleWorkflowToChangeTable sc ON sc.ChangeTableID = c.ChangeTableID AND c.ChangeTableFieldName = 'WorkFlowItemID'
			LEFT JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = cli.ChangeTablePKID
    
			UNION ALL
			-- pStyleCare is linked on StyleCareId
			SELECT l.*, '' as WorkStatus, '' as WorkflowItemID ,c.StyleId as StyleID FROM vwx_ChangeLogItem_SEL l 
			INNER JOIN pStyleCare c ON c.StyleCareId = l.ChangeTablePKID    
			WHERE ChangeTableID = 'D616FAAE-7ACD-DF11-AF06-005056C00008'
		) Change
		RIGHT JOIN pStyleHeader sh ON sh.StyleID = Change.StyleID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04121', GetDate())
GO