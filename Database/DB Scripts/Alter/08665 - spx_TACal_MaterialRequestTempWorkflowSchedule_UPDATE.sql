IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_MaterialRequestTempWorkflowSchedule_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_MaterialRequestTempWorkflowSchedule_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_TACal_MaterialRequestTempWorkflowSchedule_UPDATE]
	@MaterialRequestGroupID UNIQUEIDENTIFIER,
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER,
	@MaterialID  UNIQUEIDENTIFIER,
	@ScheduleBy NVARCHAR(1),
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@TACalTemplateID UNIQUEIDENTIFIER	
AS

begin

DECLARE @StartDate datetime

SELECT  @StartDate = MaterialRequestWorkflowStartDate
FROM  pMaterialRequestTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID

if @StartDate is null 
	begin
		set @StartDate=GETDATE()
	end

	
if (SELECT COUNT(*) FROM pMaterialRequestTempWorkflow WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID) >  0 	
	begin
		if @ScheduleBy='S'
			begin
				UPDATE pMaterialRequestTempWorkflow SET 
					DueDate = CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN DATEADD(DAY,pMaterialRequestTempWorkflow.[Days], tt.TaskPlanStart)  ELSE DATEADD(DAY,pMaterialRequestTempWorkflow.[Days],@StartDate) END,
					AssignedTo = CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN ug.UserID ELSE pMaterialRequestTempWorkflow.AssignedTo END
				FROM pMaterialRequestTempWorkflow
					INNER JOIN pMaterialRequestWorkflow ON pMaterialRequestTempWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
					LEFT JOIN pTACalTemplateTask tt 
						INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder = 'MATERIAL REQUEST'
					ON tt.TACalTemplateId = @TACalTemplateID AND pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID = tw.WorkflowId
					LEFT JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
				WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
			end
	end
else
	begin
		DELETE FROM pMaterialRequestTempWorkflow WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID <> @MaterialRequestWorkflowTempID
		if @ScheduleBy='S'
			begin 
				INSERT INTO  pMaterialRequestTempWorkflow  (MaterialRequestTempWorkflowID, MaterialRequestGroupID, 
					MaterialRequestWorkflowTempID, MaterialRequestWorkflowTemplateItemID, MaterialRequestWorkflowID, AssignedTo, 
					Days, RDays, DueDate, Alerts, Status, PartnerTypeID) 
				SELECT NEWID(), @MaterialRequestGroupID, MaterialRequestWorkflowTempID, 
					MaterialRequestWorkflowTempItemID, pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowID, 
					CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN ug.UserID ELSE pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowAssignedTo END AS AssignedTo,
					MaterialRequestWorkflowDays, MaterialRequestWorkflowRDays, 
					CASE WHEN tt.TACalTemplateTaskId IS NOT NULL THEN DATEADD(Day, MaterialRequestWorkflowDays, tt.TaskPlanStart) ELSE NULL END AS DueDate, 
					MaterialRequestWorkflowAlerts, 0, MaterialRequestPartnerTypeID
				FROM pMaterialRequestWorkflowTemplateItem 
					INNER JOIN pMaterialRequestWorkflow ON pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
					LEFT JOIN pTACalTemplateTask tt 
						INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId AND tw.WorkflowFolder = 'MATERIAL REQUEST'
					ON tt.TACalTemplateId = @TACalTemplateID AND pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID = tw.WorkflowId
					LEFT JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
				WHERE MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
			end
	end
	
end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08665', GetDate())
GO
