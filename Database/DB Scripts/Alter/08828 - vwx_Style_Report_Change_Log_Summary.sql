IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Style_Report_Change_Log_Summary]'))
DROP VIEW [dbo].[vwx_Style_Report_Change_Log_Summary]
GO

CREATE VIEW [dbo].[vwx_Style_Report_Change_Log_Summary]
AS
SELECT
	sh.StyleID
	, wf.WorkflowID
	, wf.Workflow
	, '' AS WorkflowItemID
	, sh.StyleCategory
	, sh.StyleNo
	, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
	, sh.Description
	, sh.SizeClass
	, dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'100') AS FilePath
	, (CASE sh.StyleSet
		WHEN 1 THEN ISNULL(sh.Pc1, CAST(sh.StyleSet AS nVARCHAR(1)) + 'st Set')
		WHEN 2 THEN ISNULL(sh.Pc2, CAST(sh.StyleSet AS nVARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(sh.Pc3, CAST(sh.StyleSet AS nVARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(sh.Pc4, CAST(sh.StyleSet AS nVARCHAR(1)) + 'th Set') 
      END) AS StyleSet
	, cl.ChangeDate
	, ctr.ChangeTransTypeID
	, sh.StyleType
	, sh.DivisionID
FROM
	pChangeLogItem cli
	INNER JOIN pChangeTransaction ctr ON cli.ChangeTransID = ctr.ChangeTransID
	INNER JOIN pChangeLog cl ON cli.ChangeLogID = cl.ChangeLogID
	INNER JOIN pChangeTable ct ON cl.ChangeTableID = ct.ChangeTableID
	INNER JOIN pStyleWorkflowToChangeTable swct ON cl.ChangeTableID = swct.ChangeTableID
	INNER JOIN pWorkFlow wf ON swct.WorkflowID = wf.WorkflowID
	LEFT OUTER JOIN pStyleMaterials AS sm ON cl.ChangeTablePKID = sm.StyleMaterialID
	LEFT OUTER JOIN pStyleHeader sh 
		INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
	ON cl.ChangeTablePKID = sh.StyleID OR sm.StyleID = sh.StyleID
WHERE ct.ChangeTableFieldName <> 'WorkFlowItemID' AND sh.StyleID IS NOT NULL

UNION ALL

SELECT
	sh.StyleID
	, wf.WorkflowID
	, wf.Workflow + ' - ' + ISNULL(wfi.WorkFlowItemName,'')
	, CAST(wfi.WorkFlowItemID AS NVARCHAR(50)) AS WorkFlowItemID
	, sh.StyleCategory
	, sh.StyleNo
	, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
	, sh.Description
	, sh.SizeClass
	, dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'100') AS FilePath
	, (CASE sh.StyleSet
		WHEN 1 THEN ISNULL(sh.Pc1, CAST(sh.StyleSet AS nVARCHAR(1)) + 'st Set')
		WHEN 2 THEN ISNULL(sh.Pc2, CAST(sh.StyleSet AS nVARCHAR(1)) + 'nd Set')
		WHEN 3 THEN ISNULL(sh.Pc3, CAST(sh.StyleSet AS nVARCHAR(1)) + 'rd Set')
		WHEN 4 THEN ISNULL(sh.Pc4, CAST(sh.StyleSet AS nVARCHAR(1)) + 'th Set') 
      END) AS StyleSet
	, cl.ChangeDate
	, ctr.ChangeTransTypeID
	, sh.StyleType
	, sh.DivisionID	
FROM
	pChangeLogItem cli
	INNER JOIN pChangeTransaction ctr ON cli.ChangeTransID = ctr.ChangeTransID
	INNER JOIN pChangeLog cl ON cli.ChangeLogID = cl.ChangeLogID
	INNER JOIN pChangeTable ct ON cl.ChangeTableID = ct.ChangeTableID
	INNER JOIN pStyleWorkflowToChangeTable swct ON cl.ChangeTableID = swct.ChangeTableID
	INNER JOIN pWorkFlow wf ON swct.WorkflowID = wf.WorkflowID
	INNER JOIN pWorkFlowItem wfi ON cl.ChangeTablePKID = wfi.WorkFlowItemID
	INNER JOIN pStyleHeader sh 
		INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
	ON wfi.StyleID = sh.StyleID
WHERE ct.ChangeTableFieldName = 'WorkFlowItemID'


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08828', GetDate())
GO
