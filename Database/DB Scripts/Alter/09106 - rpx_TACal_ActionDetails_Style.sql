IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_TACal_ActionDetails_Style]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_TACal_ActionDetails_Style]
GO

CREATE PROCEDURE [dbo].[rpx_TACal_ActionDetails_Style]
(
	@TACalTemplateId UNIQUEIDENTIFIER
	, @TaskTypeID NVARCHAR(MAX)
	, @Area NVARCHAR(MAX)
	, @AsignedTo NVARCHAR(MAX)
	, @Status NVARCHAR(MAX)
	, @Late BIT
	, @Ended BIT
)

AS
BEGIN
	DECLARE @tmpTaskType TABLE (TaskTypeID INT)
	INSERT INTO @tmpTaskType
	SELECT CAST(value AS INT) FROM fnx_Split(@TaskTypeID, ',')

	DECLARE @tmpWorkflowFolder TABLE (WorkflowFolder NVARCHAR(200))
	INSERT INTO @tmpWorkflowFolder
	SELECT value FROM fnx_Split(@Area, ',')
	
	DECLARE @tmpAsignedTo TABLE (TeamID UNIQUEIDENTIFIER)
	INSERT INTO @tmpAsignedTo
	SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@AsignedTo, ',')

	DECLARE @tmpStatus TABLE (StatusID INT)
	INSERT INTO @tmpStatus
	SELECT CAST(value AS INT) FROM fnx_Split(@Status, ',')

	SELECT
		ttr.WorkflowName
		, ttr.StyleNo
		, ttr.Description
		, div.Custom AS Division
		, st.StyleTypeDescription
		, sc.StyleCategory
		, ttr.SizeClass
		, ws.WorkflowStatus
		, ug.FullName
		, ttr.TaskPlanStart
		, ttr.TaskPlanEnd
		, ttr.TaskRevisedlStart
		, ttr.TaskRevisedEnd
		, ttr.ActualStart
		, ttr.ActualEnd
		, ttr.HighlightColor
	FROM
		vwx_TACalTemplateTask_ReferenceFromStyle_SELECT ttr
		INNER JOIN pStyleType st ON ttr.StyleType = st.StyleTypeID
		INNER JOIN iCustom1 div ON ttr.DivisionID = div.CustomID
		INNER JOIN pStyleCategory sc ON ttr.StyleCategory = sc.StyleCategoryID
		LEFT JOIN pWorkflowStatus ws ON ttr.WorkStatus = ws.WorkflowStatusID
		INNER JOIN vwx_UserGroupDropDown_SEL ug ON ttr.WorkAssignedTo = ug.UserID
		INNER JOIN @tmpTaskType ttt ON ttr.TaskTypeId = ttt.TaskTypeID
		INNER JOIN @tmpWorkflowFolder twf ON ISNULL(ttr.WorkflowFolder, 'N/A') = twf.WorkflowFolder
		INNER JOIN @tmpAsignedTo tat ON ug.TeamID = tat.TeamID
		INNER JOIN @tmpStatus ts ON ttr.WorkStatus = ts.StatusID
	WHERE
		ttr.WorkflowFolder != 'STYLE TECHPACK'
		AND ttr.TACalTemplateId = @TACalTemplateId
		AND (ttr.Late = @Late OR @Late IS NULL)
		AND (ttr.Ended = @Ended OR @Ended IS NULL)
	
	UNION
	
	SELECT
		ttr.WorkflowName
		, ttr.StyleNo
		, ttr.Description
		, div.Custom AS Division
		, st.StyleTypeDescription
		, sc.StyleCategory
		, ttr.SizeClass
		, ws.WorkflowStatus
		, ug.FullName
		, ttr.TaskPlanStart
		, ttr.TaskPlanEnd
		, ttr.TaskRevisedlStart
		, ttr.TaskRevisedEnd
		, ttr.ActualStart
		, ttr.ActualEnd
		, ttr.HighlightColor
	FROM
		vwx_TACalTemplateTask_ReferenceFromStyleTechPack_SELECT ttr
		INNER JOIN pStyleType st ON ttr.StyleType = st.StyleTypeID
		INNER JOIN iCustom1 div ON ttr.DivisionID = div.CustomID
		INNER JOIN pStyleCategory sc ON ttr.StyleCategory = sc.StyleCategoryID
		LEFT JOIN pWorkflowStatus ws ON ttr.WorkStatus = ws.WorkflowStatusID
		INNER JOIN vwx_UserGroupDropDown_SEL ug ON ttr.WorkAssignedTo = ug.UserID
		INNER JOIN @tmpTaskType ttt ON ttr.TaskTypeId = ttt.TaskTypeID
		INNER JOIN @tmpWorkflowFolder twf ON ISNULL(ttr.WorkflowFolder, 'N/A') = twf.WorkflowFolder
		INNER JOIN @tmpAsignedTo tat ON ug.TeamID = tat.TeamID
		INNER JOIN @tmpStatus ts ON ttr.WorkStatus = ts.StatusID
	WHERE
		ttr.TACalTemplateId = @TACalTemplateId
		AND (ttr.Late = @Late OR @Late IS NULL)
		AND (ttr.Ended = @Ended OR @Ended IS NULL)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09106', GetDate())
GO
