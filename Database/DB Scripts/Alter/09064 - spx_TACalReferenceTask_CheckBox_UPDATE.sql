/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceTask_CheckBox_UPDATE]    Script Date: 09/03/2014 13:37:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceTask_CheckBox_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceTask_CheckBox_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceTask_CheckBox_UPDATE]    Script Date: 09/03/2014 13:37:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceTask_CheckBox_UPDATE](
	@TACalTemplateTaskID uniqueidentifier,
	@NewChanged int,
	@CarryOverChanged int,
	@CUser nvarchar(100),
	@CDate datetime
)

AS 

DECLARE @FolderID integer
DECLARE @TACalTemplateID uniqueidentifier
DECLARE @WorkFlowFolder nvarchar(200)

SELECT TOP 1 @FolderID = cr.TACalReferenceTypeId FROM pTACalTemplateTask tt
INNER JOIN pTACalReferenceTask rt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
WHERE tt.TACalTemplateTaskId=@TACalTemplateTaskID

SELECT @TACalTemplateID = TACalTemplateId FROM pTACalTemplateTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

select @WorkFlowFolder = tw.WorkflowFolder from pTACalTemplateTask tt 
INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
WHERE tt.TACalTemplateTaskId=@TACalTemplateTaskID
--delete all old references to current task
--DELETE FROM pTACalReferenceTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @SeasonYearID = SeasonYearID FROM pTACalTemplate 
	WHERE TACalTemplateId = @TACalTemplateID
 
if UPPER(@WorkFlowFolder) = 'STYLE'
begin

 DELETE FROM pTACalReferenceTask WHERE TACalRefTaskId IN  
 (
	 SELECT crt.TACalRefTaskId FROM pTACalReferenceTask crt 
	 INNER JOIN pTACalReference cr ON cr.TACalReferenceId = crt.TACalReferenceId
	 INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId
	 WHERE crt.TACalTemplateTaskId = @TACalTemplateTaskID AND 
			((@NewChanged=1 AND @SeasonYearId = sh.IntroSeasonYearID) 
			OR (@CarryOverChanged = 1 AND @SeasonYearId <> sh.IntroSeasonYearID))
 )
 
INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
INNER JOIN pStyleWorkflow sw ON sw.WorkflowID = tw.WorkflowId AND sw.StyleID=cr.ReferenceId
INNER JOIN pStyleSeasonYear ssy ON ssy.StyleID = cr.ReferenceId and ssy.SeasonYearID = @SeasonYearID
INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId 
where tw.WorkflowFolder='STYLE' and tt.TACalTemplateId=@TACalTemplateId  and ((tt.New=1 AND @SeasonYearId = sh.IntroSeasonYearID AND @NewChanged=1) OR (tt.CarryOver = 1 AND @SeasonYearId <> sh.IntroSeasonYearID AND @CarryOverChanged = 1)) AND (sw.StyleSeasonYearID = ssy.StyleSeasonYearID OR sw.StyleSeasonYearID IS NULL) and sw.StyleSet =1 and tt.TACalTemplateTaskId = @TACalTemplateTaskID 

end



if UPPER(@WorkFlowFolder) = 'STYLE TECHPACK'
begin

DELETE FROM pTACalReferenceTask WHERE TACalRefTaskId IN  
 (
	 SELECT crt.TACalRefTaskId FROM pTACalReferenceTask crt 
	 INNER JOIN pTACalReference cr ON cr.TACalReferenceId = crt.TACalReferenceId
	 INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId
	 WHERE crt.TACalTemplateTaskId = @TACalTemplateTaskID AND 
			((@NewChanged=1 AND @SeasonYearId = sh.IntroSeasonYearID) 
			OR (@CarryOverChanged = 1 AND @SeasonYearId <> sh.IntroSeasonYearID))
 )
 
INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
INNER JOIN pStyleSeasonYear ssy ON ssy.StyleID = cr.ReferenceId and ssy.SeasonYearID = @SeasonYearID
INNER JOIN pStyleHeader sh ON sh.StyleID = cr.ReferenceId 
where tw.WorkflowFolder='STYLE TECHPACK' and tt.TACalTemplateId=@TACalTemplateId  and ((tt.New=1 AND @SeasonYearId = sh.IntroSeasonYearID AND @NewChanged=1) OR (tt.CarryOver = 1 AND @SeasonYearId <> sh.IntroSeasonYearID AND @CarryOverChanged = 1))
end

if UPPER(@WorkFlowFolder) = 'MATERIAL'
begin

DELETE FROM pTACalReferenceTask WHERE TACalRefTaskId IN  
 (
	 SELECT crt.TACalRefTaskId FROM pTACalReferenceTask crt 
	 INNER JOIN pTACalReference cr ON cr.TACalReferenceId = crt.TACalReferenceId
	 INNER JOIN pMaterial mh ON mh.MaterialID = cr.ReferenceId
	 WHERE crt.TACalTemplateTaskId = @TACalTemplateTaskID AND 
			((@NewChanged=1 AND @SeasonYearId = ISNULL(mh.IntroSeasonYearID, '00000000-0000-0000-0000-000000000000')) 
			OR (@CarryOverChanged = 1 AND @SeasonYearId <> ISNULL(mh.IntroSeasonYearID, '00000000-0000-0000-0000-000000000000')))
 )
 
INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
INNER JOIN pMaterial mt ON mt.MaterialID = cr.ReferenceId
where tw.WorkflowFolder='MATERIAL' and tt.TACalTemplateId=@TACalTemplateId  
	and ((tt.New=1 AND @SeasonYearId = ISNULL(mt.IntroSeasonYearID, '00000000-0000-0000-0000-000000000000') and @NewChanged=1) 
	OR (tt.CarryOver = 1 AND @SeasonYearId <> ISNULL(mt.IntroSeasonYearID, '00000000-0000-0000-0000-000000000000') and @CarryOverChanged = 1))  and tt.TACalTemplateTaskId = @TACalTemplateTaskID 
AND tw.WorkflowId in (SELECT  ti.MaterialTemplatePageID 
            FROM pMaterialTemplateItem ti 
             INNER JOIN pMaterialTemplatePage tp ON ti.MaterialTemplatePageID = tp.MaterialTemplatePageID 
             INNER JOIN pMaterial  pm on ti.MaterialTemplateID = pm.MaterialTemplateID
             Where pm.MaterialID=cr.ReferenceId) 
             
end


if UPPER(@WorkFlowFolder) = 'SAMPLE REQUEST' AND @NewChanged = 1
begin

DELETE FROM pTACalReferenceTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, 
	TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
SELECT cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, 
	NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
FROM pTACalTemplateTask tt
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
--INNER JOIN SampleRequestBOMTrade srt ON srt.SampleRequestTradeID = cr.ReferenceId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
WHERE tw.WorkflowFolder = 'SAMPLE REQUEST' and tt.TACalTemplateId = @TACalTemplateId AND tt.New = 1  and tt.TACalTemplateTaskId = @TACalTemplateTaskID 
	AND tw.WorkflowId IN (
SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM  pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                         pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
                         WHERE     (pSampleRequestWorkflow.SampleRequestTradeID = cr.ReferenceId)
UNION
SELECT  DISTINCT    pSampleWorkflow.SampleWorkflowGUID FROM pSampleRequestWorkflowBOM WITH (NOLOCK) INNER JOIN
                         pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflowBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
                         WHERE     (pSampleRequestWorkflowBOM.SampleRequestTradeID = cr.ReferenceId)
) 
             
end

if UPPER(@WorkFlowFolder) = 'MATERIAL REQUEST' AND @NewChanged = 1
begin

DELETE FROM pTACalReferenceTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

INSERT INTO pTACalReferenceTask (TACalReferenceId, TACalTemplateTaskId, TaskActualEnd, TaskActualStart, 
	TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
SELECT cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, 
	NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
FROM pTACalTemplateTask tt
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
WHERE tw.WorkflowFolder = 'MATERIAL REQUEST' AND tt.TACalTemplateId = @TACalTemplateId AND tt.New = 1 and tt.TACalTemplateTaskId = @TACalTemplateTaskID 
AND tw.WorkflowId IN (
	SELECT DISTINCT pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID 
	FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK) INNER JOIN
		pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
	WHERE MaterialTradePartnerID = cr.ReferenceId
) 

end

if UPPER(@WorkFlowFolder) = 'SOURCING QUOTATION' AND @NewChanged = 1
begin

DELETE FROM pTACalReferenceTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

INSERT INTO pTACalReferenceTask (TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
SELECT cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
FROM pTACalTemplateTask  tt
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
WHERE tw.WorkflowFolder='SOURCING QUOTATION' AND tt.TACalTemplateId=@TACalTemplateId AND tt.New=1 and tt.TACalTemplateTaskId = @TACalTemplateTaskID 

end

if UPPER(@WorkFlowFolder) = 'SOURCING COMMITMENT' AND @NewChanged = 1
begin

DELETE FROM pTACalReferenceTask WHERE TACalTemplateTaskId = @TACalTemplateTaskID

INSERT INTO pTACalReferenceTask (TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	SELECT cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
	FROM pTACalTemplateTask  tt
	INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	WHERE tw.WorkflowFolder='SOURCING COMMITMENT' AND tt.TACalTemplateId=@TACalTemplateId AND tt.New=1 and tt.TACalTemplateTaskId = @TACalTemplateTaskID 
end


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09064', GetDate())
GO
