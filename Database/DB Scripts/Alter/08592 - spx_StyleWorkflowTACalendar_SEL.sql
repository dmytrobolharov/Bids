IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowTACalendar_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowTACalendar_SEL]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowTACalendar_SEL] (
	@StyleID uniqueidentifier,
	@WorkflowTemplateID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@TACalReferenceId uniqueidentifier,
	@ShowOnlyTrackedPages int
	)
AS
BEGIN
	declare @TACalReferenceIdString nvarchar(50)
	SET @TACalReferenceIdString = CAST(@TACalReferenceId as nvarchar(50));
	
	IF @TACalReferenceIdString  = '00000000-0000-0000-0000-000000000000' OR @TACalReferenceIdString = '' OR @TACalReferenceIdString IS NULL
		BEGIN
			SELECT vswi.StyleWorkflowID,vswi.WorkflowID, vswi.MapDetail,vswi.WorkflowStatus,vswi.WorkAssignedTo, vswi.ActualStart, vswi.ActualEnd,vswi.WorkflowSort,vswi.MUser,vswi.MDate,vswi.WorkflowStatusImage,
			NULL AS TACalReferenceId, NULL AS TaskPlanStart, NULL AS TaskPlanEnd, NULL AS TaskRevisedlStart, NULL AS TaskRevisedEnd, NULL AS WorkflowId, NULL AS TaskAssignedToId, NULL AS TACalRefTaskId 
			FROM vwx_StyleWorkflowCalendarItems vswi
			WHERE vswi.StyleID = @StyleID AND vswi.StyleSet = 1 
			AND vswi.WorkflowTemplateID = @WorkflowTemplateID 
			AND (IsSeasonal = 1 AND SeasonYearID = @SeasonYearID OR IsSeasonal <> 1) 
			UNION-------------------UNION------------------------------------------------------------------------------
			SELECT 'FFFFFFFF-EEEE-1111-2323-333333333333' AS StyleWorkflowID, '50000000-0000-0000-0000-000000000050' AS WorkflowID, 'Tech Pack' AS MapDeatail, ws.WorkflowStatus, stps.WorkAssignedTo, stps.ActualStart, stps.ActualEnd, 99 AS WorkflowSort,stps.MUser,stps.MDate,ws.WorkflowStatusImage, 
			NULL AS TACalReferenceId, NULL AS TaskPlanStart, NULL AS TaskPlanEnd, NULL AS TaskRevisedlStart, NULL AS TaskRevisedEnd, NULL AS WorkflowId, NULL AS TaskAssignedToId, NULL AS TACalRefTaskId 
			FROM pStyleTechPackStatus stps
			INNER JOIN dbo.pWorkflowStatus ws ON stps.WorkStatus = ws.WorkflowStatusID 
			INNER JOIN pStyleSeasonYear pssy ON pssy.StyleSeasonYearID = stps.StyleSeasonYearID 
			WHERE stps.StyleID=@StyleID AND pssy.SeasonYearID = @SeasonYearID 
			ORDER BY WorkflowSort, vswi.WorkflowID
		END

	ELSE
		BEGIN
		IF @ShowOnlyTrackedPages = 1
			BEGIN
				SELECT vswi.Map,StyleWorkflowID, vswi.WorkflowID, vswi.MapDetail, vswi.WorkflowStatus, vswi.WorkAssignedTo, vswi.ActualStart, vswi.ActualEnd, WorkflowSort,vswi.MUser,vswi.MDate,vswi.WorkflowStatusImage, 
				ds.TACalReferenceId, ds.TaskPlanStart, ds.TaskPlanEnd, ds.TaskRevisedlStart, ds.TaskRevisedEnd, ds.WorkflowId, ds.TaskAssignedToId, ds.TACalRefTaskId 
				FROM vwx_StyleWorkflowCalendarItems vswi 
				LEFT OUTER JOIN(select rt.TACalReferenceId, tt.TaskPlanStart, tt.TaskPlanEnd, rt.TaskRevisedlStart, rt.TaskRevisedEnd,tw.WorkflowId,tt.TaskAssignedToId,rt.TACalRefTaskId 
				from pTACalReferenceTask rt
				INNER JOIN  pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN  pTATaskWorkflow tw ON tt.TaskWorkflowId=tw.TATaskWorkflowId WHERE rt.TACalReferenceId=@TACalReferenceId) ds ON vswi.WorkflowID = ds.WorkflowId
				WHERE vswi.StyleID = @StyleID AND vswi.StyleSet = 1 
				AND vswi.WorkflowTemplateID = @WorkflowTemplateID 
				AND (IsSeasonal = 1 AND SeasonYearID = @SeasonYearID OR IsSeasonal <> 1) 
				AND ds.TACalReferenceId IS NOT NULL
				UNION-------------------UNION------------------------------------------------------------------------------
				SELECT ds.WorkflowId AS Map,'FFFFFFFF-EEEE-1111-2323-333333333333' AS StyleWorkflowID, ds.WorkflowId, 'Tech Pack' AS MapDeatail, ws.WorkflowStatus, stps.WorkAssignedTo, stps.ActualStart, stps.ActualEnd, 99 AS WorkflowSort,stps.MUser,stps.MDate,ws.WorkflowStatusImage, 
				ds.TACalReferenceId, ds.TaskPlanStart, ds.TaskPlanEnd, ds.TaskRevisedlStart, ds.TaskRevisedEnd, ds.WorkflowId, ds.TaskAssignedToId, ds.TACalRefTaskId 
				FROM pStyleTechPackStatus stps
				INNER JOIN dbo.pWorkflowStatus ws ON stps.WorkStatus = ws.WorkflowStatusID
				LEFT OUTER JOIN(select rt.TACalReferenceId, tt.TaskPlanStart, tt.TaskPlanEnd, rt.TaskRevisedlStart, rt.TaskRevisedEnd,tw.WorkflowId,tt.TaskAssignedToId,rt.TACalRefTaskId 
				from pTACalReferenceTask rt
				INNER JOIN  pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN  pTATaskWorkflow tw ON tt.TaskWorkflowId=tw.TATaskWorkflowId WHERE rt.TACalReferenceId=@TACalReferenceId AND tw.WorkflowFolder='STYLE TECHPACK') ds ON WorkflowID = ds.WorkflowId 
				INNER JOIN pStyleSeasonYear pssy ON pssy.StyleSeasonYearID = stps.StyleSeasonYearID 
				WHERE stps.StyleID=@StyleID AND pssy.SeasonYearID = @SeasonYearID AND ds.TACalReferenceId IS NOT NULL
				ORDER BY WorkflowSort--, stps.WorkflowID	 			
			END
		ELSE
			BEGIN	
				SELECT vswi.Map,StyleWorkflowID, vswi.WorkflowID, vswi.MapDetail, vswi.WorkflowStatus, vswi.WorkAssignedTo, vswi.ActualStart, vswi.ActualEnd, WorkflowSort,vswi.MUser,vswi.MDate,vswi.WorkflowStatusImage, 
				ds.TACalReferenceId, ds.TaskPlanStart, ds.TaskPlanEnd, ds.TaskRevisedlStart, ds.TaskRevisedEnd, ds.WorkflowId, ds.TaskAssignedToId, ds.TACalRefTaskId 
				FROM vwx_StyleWorkflowCalendarItems vswi 
				LEFT OUTER JOIN(select rt.TACalReferenceId, tt.TaskPlanStart, tt.TaskPlanEnd, rt.TaskRevisedlStart, rt.TaskRevisedEnd,tw.WorkflowId,tt.TaskAssignedToId,rt.TACalRefTaskId 
				from pTACalReferenceTask rt
				INNER JOIN  pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN  pTATaskWorkflow tw ON tt.TaskWorkflowId=tw.TATaskWorkflowId WHERE rt.TACalReferenceId=@TACalReferenceId) ds ON vswi.WorkflowID = ds.WorkflowId
				WHERE vswi.StyleID = @StyleID AND vswi.StyleSet = 1 
				AND vswi.WorkflowTemplateID = @WorkflowTemplateID 
				AND (IsSeasonal = 1 AND SeasonYearID = @SeasonYearID OR IsSeasonal <> 1) 
				UNION-------------------UNION------------------------------------------------------------------------------
				SELECT ds.WorkflowId AS Map,'FFFFFFFF-EEEE-1111-2323-333333333333' AS StyleWorkflowID, ds.WorkflowId, 'Tech Pack' AS MapDeatail, ws.WorkflowStatus, stps.WorkAssignedTo, stps.ActualStart, stps.ActualEnd, 99 AS WorkflowSort,stps.MUser,stps.MDate,ws.WorkflowStatusImage, 
				ds.TACalReferenceId, ds.TaskPlanStart, ds.TaskPlanEnd, ds.TaskRevisedlStart, ds.TaskRevisedEnd, ds.WorkflowId, ds.TaskAssignedToId, ds.TACalRefTaskId 
				FROM pStyleTechPackStatus stps
				INNER JOIN dbo.pWorkflowStatus ws ON stps.WorkStatus = ws.WorkflowStatusID
				LEFT OUTER JOIN(select rt.TACalReferenceId, tt.TaskPlanStart, tt.TaskPlanEnd, rt.TaskRevisedlStart, rt.TaskRevisedEnd,tw.WorkflowId,tt.TaskAssignedToId,rt.TACalRefTaskId 
				from pTACalReferenceTask rt
				INNER JOIN  pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN  pTATaskWorkflow tw ON tt.TaskWorkflowId=tw.TATaskWorkflowId WHERE rt.TACalReferenceId=@TACalReferenceId AND tw.WorkflowFolder='STYLE TECHPACK') ds ON WorkflowID = ds.WorkflowId 
				INNER JOIN pStyleSeasonYear pssy ON pssy.StyleSeasonYearID = stps.StyleSeasonYearID 
				WHERE stps.StyleID=@StyleID AND pssy.SeasonYearID = @SeasonYearID 
				ORDER BY WorkflowSort--, stps.WorkflowID				
			END	
		END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08592', GetDate())
GO
