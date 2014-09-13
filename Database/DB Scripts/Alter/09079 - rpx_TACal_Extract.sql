IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_TACal_Extract]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_TACal_Extract]
GO

CREATE PROCEDURE [dbo].[rpx_TACal_Extract]
(
	@TACalTemplateId UNIQUEIDENTIFIER
	, @TaskTypeID INT
	, @Area NVARCHAR(MAX)
	, @AsignedTo NVARCHAR(MAX)
	, @NewCarry INT
	, @Complete BIT
)

AS
BEGIN
	DECLARE @tmpWorkflowFolder TABLE (WorkflowFolder NVARCHAR(200))
	INSERT INTO @tmpWorkflowFolder
	SELECT value FROM fnx_Split(@Area, ',')
	
	DECLARE @tmpAsignedTo TABLE (TeamID UNIQUEIDENTIFIER)
	INSERT INTO @tmpAsignedTo
	SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@AsignedTo, ',')

	SELECT
		tt.TaskId
		, tt.TaskName
		, tw.WorkflowFolder
		, tty.TATaskTypeName
		, vug.FullName
		, CASE WHEN tt.New = 1 THEN 'Yes' ELSE '' END AS New
		, CASE WHEN tt.CarryOver = 1 THEN 'Yes' ELSE '' END AS CarryOver
		, tt.TaskPlanStart
		, tt.TaskPlanEnd
		, tt.TaskDuration
		, STUFF ((SELECT ', ' + CAST(tti.TaskId AS NVARCHAR(5))
			FROM pTACalTemplateTaskDep ttd
			INNER JOIN pTACalTemplateTask tti ON ttd.TACalTemplateTaskParentId = tti.TACalTemplateTaskId
			WHERE ttd.TACalTemplateTaskChildId = tt.TACalTemplateTaskId
			ORDER BY tti.TaskId 
			FOR XML PATH('')), 1, 2, '') AS Dep
		, tt.TaskProgress
		, tt.TaskNote
	FROM
		pTACalTemplateTask tt
		LEFT JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
		LEFT JOIN pTATaskType tty ON tt.TaskTypeId = tty.TATaskTypeId AND tt.TaskWorkflowId IS NOT NULL
		INNER JOIN vwx_UserGroupDropDown_SEL vug ON tt.TaskAssignedToId = vug.TeamID
		INNER JOIN @tmpWorkflowFolder twf ON ISNULL(tw.WorkflowFolder, 'N/A') = twf.WorkflowFolder
		INNER JOIN @tmpAsignedTo tat ON tt.TaskAssignedToId = tat.TeamID
	WHERE
		tt.TACalTemplateId = @TACalTemplateId
		AND (tt.TaskTypeId = @TaskTypeID OR @TaskTypeID IS NULL)
		AND ((@NewCarry = 0 AND tt.New = 1) OR (@NewCarry = 1 AND tt.CarryOver = 1) OR @NewCarry IS NULL)
		AND ((@Complete = 1 AND tt.TaskProgress = 1) OR (@Complete = 0 AND ISNULL(tt.TaskProgress, 0) != 1) OR @Complete IS NULL)
	ORDER BY TaskId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09079', GetDate())
GO