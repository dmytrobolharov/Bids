IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Style_Report_Change_Log]'))
DROP VIEW [dbo].[vwx_Style_Report_Change_Log]
GO

CREATE VIEW [dbo].[vwx_Style_Report_Change_Log]
AS
SELECT     sh.StyleNo, ISNULL(sh.Description, '') AS Description, sh.SizeClass, sh.StyleCategory, (CASE sh.StyleSet WHEN 1 THEN ISNULL(sh.Pc1, 
                      CAST(sh.StyleSet AS VARCHAR(1)) + 'st Set') WHEN 2 THEN ISNULL(sh.Pc2, CAST(sh.StyleSet AS VARCHAR(1)) + 'nd Set') WHEN 3 THEN ISNULL(sh.Pc3, 
                      CAST(sh.StyleSet AS VARCHAR(1)) + 'rd Set') WHEN 4 THEN ISNULL(sh.Pc4, CAST(sh.StyleSet AS VARCHAR(1)) + 'th Set') END) AS StyleSet, Change.Workflow, 
                      Change.ChangeUserName, Change.ChangeDate, Change.ChangeBeforeText, Change.ChangeAfterText, Change.WorkStatus, Change.ChangeUserID, Change.StyleID, 
                      Change.WorkflowID, Change.WorkflowItemID, Change.ActionType, ISNULL(dbo.pStyleDevelopmentItem.StyleDevelopmentName, 
                      'Variation ' + CAST(dbo.pStyleDevelopmentItem.Variation AS VARCHAR(5))) AS StyleDevelopmentName,
                          (SELECT     TOP (1) dbo.fnx_GetStreamingImagePathChangeLogReport(dbo.hImage.ImageID, dbo.hImage.Version, N'200') AS Expr1) AS FilePath, 
                      Change.ChangeFieldAlias, Change.ChangeFieldName
FROM         (SELECT     ChangeTableID, ChangeTablePKID, ChangeUserName, ChangeDate, ChangeLogItemID, ChangeTransID, ChangeLogID, ChangeFieldName, 
                                              ChangeFieldAlias, ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSort, Custom_SMat_Name, Custom_SMat_Type, 
                                              Custom_SMat_No, ChangeTransTablePKID, ActionType, ChangeSessionID, ChangeSessionNo, ChangeTransNo, WorkflowID, Workflow, ChangeUserID, 
                                              '' AS WorkStatus, '' AS WorkflowItemID, ChangeTablePKID AS StyleID
                       FROM          dbo.vwx_ChangeLogItem_SEL
                       WHERE      (ChangeTableID IN ('036F8B4C-C1CC-DF11-AF06-005056C00008', '00000003-C1CC-DF11-AF06-005056C00008', 
                                              'DD12FAAE-7ACD-DF11-AF06-005056C00008', '00000002-C1CC-DF11-AF06-005056C00008', '00000006-C1CC-DF11-AF06-005056C00008')) OR
                                              (ChangeTableID IN
                                                  (SELECT     c.ChangeTableID
                                                    FROM          dbo.pChangeTable AS c INNER JOIN
                                                                           dbo.pStyleWorkflowToChangeTable AS sc ON sc.ChangeTableID = c.ChangeTableID
                                                    WHERE      (c.ChangeTableFieldName = 'StyleID')))
                       UNION ALL
                       SELECT     cli.ChangeTableID, cli.ChangeTablePKID, cli.ChangeUserName, cli.ChangeDate, cli.ChangeLogItemID, cli.ChangeTransID, cli.ChangeLogID, 
                                             cli.ChangeFieldName, cli.ChangeFieldAlias, cli.ChangeBeforeValue, cli.ChangeAfterValue, cli.ChangeBeforeText, cli.ChangeAfterText, cli.ChangeSort, 
                                             cli.Custom_SMat_Name, cli.Custom_SMat_Type, cli.Custom_SMat_No, cli.ChangeTransTablePKID, cli.ActionType, cli.ChangeSessionID, 
                                             cli.ChangeSessionNo, cli.ChangeTransNo, cli.WorkflowID, cli.Workflow, cli.ChangeUserID,
                                                 (SELECT     WorkflowStatus
                                                   FROM          dbo.pWorkflowStatus
                                                   WHERE      (WorkflowStatusID = wi.WorkStatus)) AS WorkStatus, ISNULL(CAST(wi.WorkFlowItemID AS varchar(255)), '') AS WorkflowItemID, 
                                             wi.StyleID
                       FROM         dbo.vwx_ChangeLogItem_SEL AS cli INNER JOIN
                                             dbo.pChangeTable AS c ON cli.ChangeTableID = c.ChangeTableID INNER JOIN
                                             dbo.pStyleWorkflowToChangeTable AS sc ON sc.ChangeTableID = c.ChangeTableID AND c.ChangeTableFieldName = 'WorkFlowItemID' LEFT OUTER JOIN
                                             dbo.pWorkFlowItem AS wi ON wi.WorkFlowItemID = cli.ChangeTablePKID
                       UNION ALL
                       SELECT     l.ChangeTableID, l.ChangeTablePKID, l.ChangeUserName, l.ChangeDate, l.ChangeLogItemID, l.ChangeTransID, l.ChangeLogID, l.ChangeFieldName, 
                                             l.ChangeFieldAlias, l.ChangeBeforeValue, l.ChangeAfterValue, l.ChangeBeforeText, l.ChangeAfterText, l.ChangeSort, l.Custom_SMat_Name, 
                                             l.Custom_SMat_Type, l.Custom_SMat_No, l.ChangeTransTablePKID, l.ActionType, l.ChangeSessionID, l.ChangeSessionNo, l.ChangeTransNo, l.WorkflowID, 
                                             l.Workflow, l.ChangeUserID, '' AS WorkStatus, '' AS WorkflowItemID, c.StyleId AS StyleID
                       FROM         dbo.vwx_ChangeLogItem_SEL AS l INNER JOIN
                                             dbo.pStyleCare AS c ON c.StyleCareId = l.ChangeTablePKID
                       WHERE     (l.ChangeTableID = 'D616FAAE-7ACD-DF11-AF06-005056C00008')
                       UNION ALL
                       SELECT     l.ChangeTableID, l.ChangeTablePKID, l.ChangeUserName, l.ChangeDate, l.ChangeLogItemID, l.ChangeTransID, l.ChangeLogID, l.ChangeFieldName, 
                                             l.ChangeFieldAlias, l.ChangeBeforeValue, l.ChangeAfterValue, l.ChangeBeforeText, l.ChangeAfterText, l.ChangeSort, l.Custom_SMat_Name, 
                                             l.Custom_SMat_Type, l.Custom_SMat_No, l.ChangeTransTablePKID, l.ActionType, l.ChangeSessionID, l.ChangeSessionNo, l.ChangeTransNo, l.WorkflowID, 
                                             l.Workflow, l.ChangeUserID, '' AS WorkStatus, '' AS WorkflowItemID, sm.StyleID
                       FROM         dbo.vwx_ChangeLogItem_SEL AS l INNER JOIN
                                             dbo.pStyleMaterials AS sm ON sm.StyleMaterialID = l.ChangeTablePKID
                       WHERE     (l.ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008')) AS Change RIGHT OUTER JOIN
                      dbo.pStyleHeader AS sh ON sh.StyleID = Change.StyleID INNER JOIN
                      dbo.pStyleDevelopmentItem ON sh.StyleID = dbo.pStyleDevelopmentItem.StyleID LEFT OUTER JOIN
                      dbo.hImage ON sh.DesignSketchID = dbo.hImage.ImageID AND sh.DesignSketchVersion = dbo.hImage.Version

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05623', GetDate())
GO
