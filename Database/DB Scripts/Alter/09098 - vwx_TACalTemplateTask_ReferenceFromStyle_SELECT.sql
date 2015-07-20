IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]') AND type = N'V')
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]
GO

CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromStyle_SELECT]
AS
SELECT crt.TACalRefTaskId
	, 'Style' AS RefType
	, sh.StyleID
	, tw.WorkflowId
	, ct.SeasonYearId
	, sh.StyleNo
	, sh.Description
	, sh.StyleType
	, sh.DivisionID
	, sh.SizeClass
	, sh.SizeRange
	, sh.StyleCategory
	, sh.IntroSeasonYearID
	, crt.TaskRevisedlStart
	, ctt.TaskPlanStart
	, ctt.TaskPlanEnd
	, sw.StyleSeasonYearID
	, crt.TaskRevisedEnd
	, crt.TACalTemplateTaskId
	, sw.WorkAssignedTo
	, sw.WorkStatus
	, sw.StyleWorkflowID
	, sw.ActualStart
	, sw.ActualEnd
	, tw.WorkflowName
	, tw.WorkflowFolder
	, ctt.TaskTypeId
	, ct.TACalTemplateId
	, CASE 
		WHEN ActualEnd IS NULL
			THEN 0
		ELSE 1
		END AS Ended
	, CASE 
		WHEN ActualEnd IS NOT NULL
			THEN CASE 
					WHEN (CAST(ActualEnd AS DATE) > CAST(TaskPlanEnd AS DATE))
						OR (CAST(ActualEnd AS DATE) > CAST(TaskRevisedEnd AS DATE))
						THEN 1
					ELSE 0
					END
		ELSE CASE 
				WHEN TaskRevisedEnd IS NULL
					THEN CASE 
							WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskPlanEnd AS DATE)
								THEN 1
							ELSE 0
							END
				ELSE CASE 
						WHEN CAST(TaskPlanEnd AS DATE) >= CAST(TaskRevisedEnd AS DATE)
							THEN CASE 
									WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskPlanEnd AS DATE)
										OR CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskRevisedEnd AS DATE)
										THEN 1
									ELSE 0
									END
						ELSE 1
						END
				END
		END AS Late
	, dbo.fnx_TACal_HighlightColor(ActualEnd, TaskRevisedEnd, TaskPlanEnd) AS HighlightColor
FROM dbo.pTACalReferenceTask AS crt
	INNER JOIN dbo.pTACalReference AS cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN dbo.pStyleHeader AS sh ON sh.StyleID = cr.ReferenceId
	INNER JOIN dbo.pTACalTemplate AS ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN dbo.pTACalTemplateTask AS ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN dbo.pTATaskWorkflow AS tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
	INNER JOIN dbo.pStyleSeasonYear ssy ON ssy.SeasonYearID = ct.SeasonYearId
		AND ssy.StyleID = sh.StyleID
	LEFT OUTER JOIN dbo.pStyleWorkflow sw ON sw.StyleID = sh.StyleID
		AND sw.WorkflowID = tw.WorkflowId
		AND (
			sw.StyleSeasonYearID = ssy.StyleSeasonYearID
			OR sw.StyleSeasonYearID IS NULL
			)
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId
		AND LOWER(pf.PermissionFolderTypeName) = LOWER('Style Folder')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09098', GetDate())
GO
